import 'package:edupower_dashboard/shared/api/api_connection.dart';
import 'package:edupower_dashboard/shared/api/api_function.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';

class LoginService {
  static Future<ApiReturnValue> login(
      {required String username, required String password}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: loginUrl, body: {'username': username, 'password': password});

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: data.data['data'], status: RequestStatus.successRequest);
      },
    );
  }
}
