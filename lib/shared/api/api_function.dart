import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/dev_print.dart';

ApiReturnValue parsingFromAPI(ApiReturnValue value,
    {ApiReturnValue Function(ApiReturnValue data)? onSuccess,
    ApiReturnValue Function(ApiReturnValue data)? onFailed,
    bool byPassStatus = false}) {
  if (value.status == RequestStatus.successRequest) {
    if (byPassStatus) {
      if (onSuccess != null) {
        return onSuccess(value);
      } else {
        return ApiReturnValue(data: null, status: RequestStatus.successRequest);
      }
    } else {
      if (value.data['status']) {
        if (onSuccess != null) {
          return onSuccess(value);
        } else {
          return ApiReturnValue(
              data: null, status: RequestStatus.successRequest);
        }
      } else {
        if (onFailed != null) {
          return onFailed(value);
        } else {
          return ApiReturnValue(
              data: parsingErrorMessage(value.data),
              status: RequestStatus.failedRequest);
        }
      }
    }
  } else {
    return ApiReturnValue(
        data: parsingErrorMessage(value.data), status: value.status);
  }
}

String? parsingErrorMessage(dynamic jsonMap) {
  String? returnValue;
  try {
    Map<String, dynamic> dataRaw = jsonMap as Map<String, dynamic>;
    returnValue = dataRaw['message'];
  } catch (e) {
    devPrint(e);
  }

  return returnValue;
}
