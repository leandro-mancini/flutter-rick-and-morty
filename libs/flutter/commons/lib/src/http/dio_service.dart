import 'package:dio/dio.dart';

class DioService {
  Dio dio = Dio();
  Future<Response> getMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      return response;
    }).catchError((error) {
      if (error is DioError) {
        return error.response!;
      }
    });
  }
}