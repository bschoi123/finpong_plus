//part of finpong_plus;

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../constants/conf.dart';

class DioHelper {
  static late Dio dio;

  static init(String token) {
    dio = Dio(BaseOptions(
        baseUrl: getBaseUrl(),
        receiveDataWhenStatusError: true,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        headers: {'Authorization': 'Bearer $token'}));

    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      //client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
