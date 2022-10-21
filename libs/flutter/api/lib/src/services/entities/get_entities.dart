import 'package:dio/dio.dart';

abstract class GetEntitiesService {
  static final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getAllEntities(String url) async {
    try {
      List<Map<String, dynamic>> allEntities = [];
      var response = await _dio.get(url);

      try {
        allEntities.addAll(List<Map<String, dynamic>>.from(response.data["results"]));
      } catch (e) {
        allEntities.addAll(List<Map<String, dynamic>>.from(response.data));
      }
      
      return allEntities;
    } on DioError {
      return [];
    }
  }

  Future<dynamic> getEntitie(String url) async {
    try {
      var response = await _dio.get(url);

      return response.data;
    } on DioError {
      rethrow;
    }
  }
}