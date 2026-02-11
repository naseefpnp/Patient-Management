import 'package:dio/dio.dart';
import 'package:patient_management/core/api/api_endpoints.dart';
import 'package:patient_management/core/network/dio_client.dart';

class HomeRepository {
  final Dio _dio = DioClient().dio;

  Future<Response> listPatients() async {
    return await _dio.get(ApiEndpoints.patientList);
  }
}
