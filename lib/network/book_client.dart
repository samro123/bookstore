import 'package:appbook/url/http.dart';
import 'package:dio/dio.dart';

class BookClient{
  static BaseOptions _options = new BaseOptions(
    baseUrl: URL.url_api,
    connectTimeout: Duration(seconds: 5000),
    receiveTimeout: Duration(seconds: 300),
  );

  static Dio _dio = Dio(_options);
  BookClient._internal(){
    _dio.interceptors.add(LogInterceptor(requestBody: true));
  }
  static final BookClient instance = BookClient._internal();

  Dio get dio => _dio;
}