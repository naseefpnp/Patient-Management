import 'package:dio/dio.dart';
import 'package:patient_management/core/api/api_endpoints.dart';
import 'package:patient_management/core/network/dio_client.dart';
import 'package:patient_management/presentation/register/model/register_request.dart';

class RegisterRepository {
  final Dio _dio = DioClient().dio;

  Future<Response> loadBranches() async {
    return await _dio.get(ApiEndpoints.loadBranch);
  }

  Future<Response> loadTreatments() async {
    return await _dio.get(ApiEndpoints.loadTreatment);
  }

  Future<Response> register({
    required PatientBookingRequest requestdata,
  }) async {
    final formData = FormData.fromMap(requestdata.toJson());

    return await _dio.post(
      ApiEndpoints.register,
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }
}
