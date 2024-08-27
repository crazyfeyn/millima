import 'package:flutter_application/logic/blocs/auth_bloc/interceptor/dio_interceptor.dart';

class SubjectService {
  final dio = DioInterceptor().createDio();
  String api = "http://millima.flutterwithakmaljon.uz/api/";

  Future<void> addSubject(String name) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "name": name,
      };

      dio.post(
        '${api}subjects',
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getSubjects() async {
    try {
      final response = await dio.get(
        '${api}subjects',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSubject(int subjectId, String name) async {
    try {
      await dio.put(
        '${api}subjects/$subjectId',
        data: {
          'name': name,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSubject(int subjectId) async {
    try {
      await dio.delete(
        '${api}subjects/$subjectId',
      );
    } catch (e) {
      rethrow;
    }
  }
}
