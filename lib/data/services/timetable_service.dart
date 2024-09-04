import 'package:flutter_application/logic/blocs/auth_bloc/interceptor/dio_interceptor.dart';

class TimetableService {
  final dio = DioInterceptor().createDio();

  Future<void> createTimetable(
    int groupId,
    int roomId,
    int dayId,
    String startTime,
    String endTime,
  ) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "group_id": groupId,
        "room_id": roomId,
        "day_id": dayId,
        "start_time": startTime,
        "end_time": endTime
      };

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/group-classes',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('success');
      } else {
        throw 'Failed to add Timetable: ${response.statusCode}';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroupTimeTables(int groupId) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/group-timetable/$groupId',
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
