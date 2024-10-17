import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:edupower_dashboard/app/data_kode/models/data_category_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_matpel_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_soal_model.dart';
import 'package:edupower_dashboard/shared/api/api_connection.dart';
import 'package:edupower_dashboard/shared/api/api_function.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:http/http.dart' as http;

class DataKodeService {
  static Future<ApiReturnValue> uploadFile({required Uint8List file}) async {
    var request = http.MultipartRequest('POST', Uri.parse(uploadImageUrl));

    request.files.add(http.MultipartFile.fromBytes('image', file,
        filename: '${DateTime.now().millisecondsSinceEpoch}.png'));

    ApiReturnValue returnValue;

    try {
      final streamSend = await request.send();
      final response = await http.Response.fromStream(streamSend);
      var data = json.decode(response.body);
      print(response.statusCode);
      print(data);

      if (response.statusCode != 200) {
        returnValue =
            ApiReturnValue(data: data, status: RequestStatus.failedRequest);
      } else {
        returnValue = ApiReturnValue(
            status: RequestStatus.successRequest,
            data: '$apiUrl/${data['msg']}');
      }
    } on SocketException {
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.internetIssue);
    } catch (e) {
      returnValue =
          ApiReturnValue(status: RequestStatus.serverError, data: null);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> loadKodeDetail({required String kode}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: fetchCodeDetailUrl, body: {'code': kode});

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: List.generate(data.data['data'].length, (index) {
              return DataMatpelKodeModel.fromJson(data.data['data'][index]);
            }),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> loadDataKode() async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpGETRequest(
      url: codeListUrl,
    );

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: List.generate(data.data['data'].length, (index) {
              return DataKodeModel.fromJson(data.data['data'][index]);
            }),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> loadDataCategory({required String code}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: codeCategoryListUrl, body: {'code': code});

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: List.generate(data.data['data'].length, (index) {
              return DataCategoryModel.fromJson(data.data['data'][index]);
            }),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> deleteDataCategory({required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: codeCategoryDeleteUrl, body: {'id': id});

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> saveKodeData(
      {required String code,
      required String category,
      required List<int> idMatpel,
      bool isUpdate = false}) async {
    Map<String, dynamic> dataBody = {'code': code, 'kategori': category};

    for (var i = 0; i < idMatpel.length; i++) {
      dataBody['mapel[$i]'] = idMatpel[i].toString();
    }

    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: isUpdate ? updateCodeUrl : addCodeUrl, body: dataBody);

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> saveKodeCategory(
      {required String code,
      required String name,
      required List<int> idMatpel,
      int? idCategory}) async {
    Map<String, dynamic> dataBody = idCategory != null
        ? {'id': idCategory.toString(), 'kategori': name}
        : {'id_code': code, 'kategori': name};

    for (var i = 0; i < idMatpel.length; i++) {
      dataBody['mapel[$i]'] = idMatpel[i].toString();
    }

    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: idCategory != null ? codeCategoryUpdateUrl : codeCategoryAddUrl,
        body: dataBody);

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> deleteDataKode({required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: codeDeleteUrl, body: {'id': id});

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> deleteMapelFromCode(
      {required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: deleteMapelFromCodeUrl, body: {'id': id});

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> saveLocalSoal(
      {required String idMatpel, required List<DataSoal> data}) async {
    Map<String, dynamic> dataBody = {
      'id_matpel_code': idMatpel,
    };

    for (var i = 0; i < data.length; i++) {
      dataBody['soal[$i]'] = data[i].soal;
      dataBody['jawaban[$i]'] = data[i].correctAnswer;
      dataBody['pembahasan[$i]'] = data[i].pembahasan;
      dataBody['type[$i]'] = data[i].type.toString();
    }

    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: saveSoalBulkUrl, body: dataBody);

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> loadDataSoal(
      {required String idMatpelCode}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: getSoalUrl, body: {'id_matpel_code': idMatpelCode});

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        List<DataSoal> finalData =
            List.generate(data.data['data'].length, (index) {
          return DataSoal.fromJson(data.data['data'][index]);
        });
        return ApiReturnValue(
            data: finalData.reversed.toList(),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> updateSoal({required DataSoal data}) async {
    ApiReturnValue<dynamic> response =
        await ApiReturnValue.httpPostRequest(url: updateSoalUrl, body: {
      'id': data.id.toString(),
      'soal': data.soal,
      'pembahasan': data.pembahasan,
      'jawaban': data.correctAnswer,
      'type': data.type.toString()
    });

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> deleteSoal({required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: deleteSoalUrl, body: {'id': id});

    return parsingFromAPI(
      response,
    );
  }
}
