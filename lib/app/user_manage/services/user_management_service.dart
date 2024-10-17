import 'package:edupower_dashboard/app/user_manage/models/user_management_model.dart';
import 'package:edupower_dashboard/shared/api/api_connection.dart';
import 'package:edupower_dashboard/shared/api/api_function.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';

class UserManagementService {
  static Future<ApiReturnValue> onChangePassword({
    required String id,
    required String oldPassword,
    required String newPassword,
  }) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: userManagementChangePasswordUrl,
        body: {
          'id': id,
          'old_password': oldPassword,
          'new_password': newPassword
        });

    return parsingFromAPI(
      response,
      onFailed: (data) {
        String? message;
        try {
          message = data.data['msg'];
        } catch (e) {}
        return ApiReturnValue(
            data: message, status: RequestStatus.failedRequest);
      },
    );
  }

  static Future<ApiReturnValue> saveUser(
      {String? id,
      required String username,
      required String name,
      required String password,
      required String role}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: id == null ? userManagementAddUrl : userManagementUpdateUrl,
        body: id == null
            ? {
                'username': username,
                'password': password,
                'role': role,
                'name': name
              }
            : password.isEmpty
                ? {'role': role, 'name': name, 'id': id}
                : {'role': role, 'name': name, 'id': id, 'password': password});

    return parsingFromAPI(
      response,
      onFailed: (data) {
        String? message;
        try {
          message = data.data['msg'];
        } catch (e) {}
        return ApiReturnValue(
            data: message, status: RequestStatus.failedRequest);
      },
    );
  }

  static Future<ApiReturnValue> loadUserManagement() async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpGETRequest(
      url: userManagementListUrl,
    );

    return parsingFromAPI(
      response,
      onSuccess: (data) {
        return ApiReturnValue(
            data: List.generate(data.data['data'].length, (index) {
              return UserManagement.fromJson(data.data['data'][index]);
            }),
            status: RequestStatus.successRequest);
      },
    );
  }

  static Future<ApiReturnValue> deleteUser({required String id}) async {
    ApiReturnValue<dynamic> response = await ApiReturnValue.httpPostRequest(
        url: userManagementDeleteUrl, body: {'id': id});

    return parsingFromAPI(
      response,
    );
  }
}
