import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';

class DioService extends GetxService {
  static Future<DioService> init() async {
    String configContent = await rootBundle.loadString(
      "assets/config/config.json",
    );
    Map configData = jsonDecode(configContent);
    return DioService(
      baseOptions: BaseOptions(
        baseUrl: configData["SERVER_BASE_URL"],
      ),
    );
  }

  final Dio _dio;

  DioService({
    required BaseOptions baseOptions,
  }) : _dio = Dio(baseOptions);

  Future<Response?> post({
    required String url,
    FormData? data,
    String? authToken,
  }) async {
    Response? response;
    try {
      response = await _dio.post(
        url,
        options: Options(
          validateStatus: (status) {
            if (status != null && status >= 200 && status <= 422) {
              return true;
            } else {
              return false;
            }
          },
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
          "DioService: Could not perform POST request to [ ${_dio.options.baseUrl}$url ]");
      debugPrint("DioService: $e");
      debugPrint("DioService: $response");
      return response;
    }
  }

  Future<Response?> get({
    required String url,
    String? authToken,
  }) async {
    Response? response;
    try {
      response = await _dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            if (status != null && status >= 200 && status <= 422) {
              return true;
            } else {
              return false;
            }
          },
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
          "DioService: Could not perform POST request to [ ${_dio.options.baseUrl}$url ]");
      debugPrint("DioService: $e");
      debugPrint("DioService: $response");
      return response;
    }
  }
}
