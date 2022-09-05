

import 'package:dio/dio.dart';
import 'package:jkapp/constants.dart';

class HttpUtil{
  final _dio = Dio();
  final _baseUrl = 'http://$kServerAddr:$kServerPort/';
  static final HttpUtil _instance = HttpUtil._internal();
  HttpUtil._internal();

  factory HttpUtil.instance() => _instance;

  Future get(String queryUrl,{ Map<String, dynamic>? queryParameters,}) async {
    return _dio.get(_baseUrl+queryUrl,queryParameters: queryParameters);
  }
}