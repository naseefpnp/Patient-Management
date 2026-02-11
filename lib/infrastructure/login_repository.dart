import 'package:dio/dio.dart';
import 'package:patient_management/core/api/api_endpoints.dart';
import 'package:patient_management/core/network/dio_client.dart';

class AuthRepository {
  final Dio _dio = DioClient().dio;

  Future<Response> login({
    required String username,
    required String password,
  }) async {
    final formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    return await _dio.post(
      ApiEndpoints.login,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }
}
