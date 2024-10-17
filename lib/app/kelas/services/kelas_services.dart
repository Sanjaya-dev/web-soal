import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/shared/api/api_connection.dart';
import 'package:edupower_dashboard/shared/api/api_function.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';

class KelasServices {
  static Future<ApiReturnValue> loadKelas() async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpGETRequest(
      url: kelasListUrl,
    );

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: List.generate(data.data['data'].length, (index) {
              return KelasModel(
                  id: data.data['data'][index]['id'],
                  name: data.data['data'][index]['name']);
            }),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> saveKelas(
      {required String name, String? id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: id == null ? kelasAddUrl : kelasUpdateUrl,
        body: id == null ? {'name': name} : {'name': name, 'id': id});

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> deleteKelas({required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: kelasDeleteUrl, body: {'id': id});

    return parsingFromAPI(
      response,
    );
  }
}
