import 'package:dio/dio.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/interceptor/dio_interceptor.dart';

class GroupService {
  final Dio dio = DioInterceptor().createDio();
  String api = "http://millima.flutterwithakmaljon.uz/api/";

  Future<void> addGroup(String name, int mainTeacherId, int assistantTeacherId,
      int subjectId) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "name": name,
        "main_teacher_id": mainTeacherId,
        "assistant_teacher_id": assistantTeacherId,
        "subject_id": subjectId
      };

      final response = await dio.post(
        '${api}groups',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw 'Failed to add group: ${response.statusCode}';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getStudentGroups() async {
    try {
      final response = await dio.get(
        '${api}student/groups',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGroup(int groupId, String name, int mainTeacherId,
      int assistantTeacherId) async {
    try {
      await dio.put(
        '${api}groups/$groupId',
        data: {
          'name': name,
          'main_teacher_id': mainTeacherId,
          'assistant_teacher_id': assistantTeacherId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteGroup(int groupId) async {
    try {
      await dio.delete(
        '${api}groups/$groupId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addStudentsToGroup(int groupId, List studentIds) async {
    try {
      await dio.post(
        '${api}groups/$groupId/students',
        data: {
          'students': studentIds,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroups() async {
    try {
      final response = await dio.get(
        '${api}groups',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
