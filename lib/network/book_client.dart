import 'package:appbook/data/spref/Spref.dart';
import 'package:appbook/url/http.dart';
import 'package:dio/dio.dart';
import 'package:appbook/shared/widget/contant.dart';

class BookClient{
  static BaseOptions _options = new BaseOptions(
    baseUrl: URL.url_api,
    connectTimeout: Duration(seconds: 5000),
    receiveTimeout: Duration(seconds: 300),
  );

  static Dio _dio = Dio(_options);
  BookClient._internal(){
    _dio.interceptors.add(LogInterceptor(requestBody: true));
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      var token = await SPref.instance.get(SPerfCache.KEY_TOKEN);
      if (token != null) {
        options.headers["Authorization"] = "Bearer " + token;
      }
          return handler.next(options);
        }, ));
  }


  static final BookClient instance = BookClient._internal();

  Dio get dio => _dio;
}