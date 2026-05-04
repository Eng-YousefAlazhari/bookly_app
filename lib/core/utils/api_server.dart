import 'package:dio/dio.dart';

class ApiServer {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;

  ApiServer(this._dio);

  Future<Map<String, dynamic>> get({required String endPoing}) async {
    final response = await _dio.get('$_baseUrl$endPoing');

    return response.data;
  }
}
