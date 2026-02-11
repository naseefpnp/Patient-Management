import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:patient_management/core/utils/auth_utils.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AuthUtils.instance.readAccessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE ← ${response.requestOptions.path}', name: 'DIO');

    if (response.data is Map || response.data is List) {
      log(jsonEncode(response.data), name: 'DIO-BODY');
    } else {
      log(response.data.toString(), name: 'DIO-BODY');
    }

    super.onResponse(response, handler);
  }

  @override
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR TYPE: ${err.type}', name: 'DIO');

    log('ERROR MESSAGE: ${err.message}', name: 'DIO');

    if (err.response != null) {
      log('STATUS CODE: ${err.response?.statusCode}', name: 'DIO');

      log('ERROR DATA: ${err.response?.data}', name: 'DIO');
    }

    super.onError(err, handler);
  }
}
