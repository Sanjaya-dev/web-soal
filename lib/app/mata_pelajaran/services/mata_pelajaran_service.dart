import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:edupower_dashboard/shared/api/api_connection.dart';
import 'package:edupower_dashboard/shared/api/api_function.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';

class MataPelajaranService {
  static Future<ApiReturnValue> loadMapel() async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpGETRequest(
      url: mapelListUrl,
    );

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: List.generate(data.data['data'].length, (index) {
              return MataPelajaranModel.fromJson(data.data['data'][index]);
            }),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> loadMapelByCategory(
      {required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: mapelByCategoryUrl, body: {'id': id});

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: List.generate(data.data['data'].length, (index) {
              return MataPelajaranModel.fromJson(data.data['data'][index]);
            }),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> saveMataPelajaran(
      {required String name, required String idKelas, String? id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: id == null ? mapelAddUrl : mapelUpdateUrl,
        body: id == null
            ? {'name': name, 'id_kelas': idKelas}
            : {'name': name, 'kelas_id': idKelas, 'id': id});

    return parsingFromAPI(
      response,
    );
  }

  static Future<ApiReturnValue> deleteMataPelajaran(
      {required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: mapelDeleteUrl, body: {'id': id});

    return parsingFromAPI(
      response,
    );
  }
}
