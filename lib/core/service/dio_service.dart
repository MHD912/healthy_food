import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioService {
  final Dio _dio;

  DioService({
    required BaseOptions baseOptions,
  }) : _dio = Dio(baseOptions);

  Future<Response?> post({
    required String url,
    FormData? data,
    String? authToken,
  }) async {
    try {
      Response? response = await _dio.post(
        url,
        options: Options(
          validateStatus: (status) =>
              (status == 200 || status == 422) ? true : false,
          contentType: (data != null) ? "multipart/form-data" : null,
          headers: (authToken != null)
              ? {
                  'accept': 'application/json',
                  'Authorization': 'Bearer $authToken',
                }
              : {
                  'accept': 'application/json',
                },
        ),
        data: data,
      );
      return response;
    } on DioException catch (e) {
      debugPrint(
          "HttpService: Could not perform POST request to [ ${_dio.options.baseUrl}$url ]");
      debugPrint(e.response.toString());
      return e.response;
    }
  }

  Future<Response?> get({
    required String url,
    String? authToken,
  }) async {
    try {
      Response? response = await _dio.get(
        url,
        options: Options(
          validateStatus: (status) =>
              (status == 200 || status == 422) ? true : false,
          headers: (authToken != null)
              ? {
                  'accept': 'application/json',
                  'authorization': 'Bearer $authToken',
                }
              : {
                  'accept': 'application/json',
                },
        ),
      );
      return response;
    } on DioException catch (e) {
      debugPrint(
          "HttpService: Could not perform GET request to [ ${_dio.options.baseUrl}$url ]");
      debugPrint(e.response.toString());
      return e.response;
    }
  }
}
