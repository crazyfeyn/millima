import 'package:dio/dio.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/interceptor/dio_interceptor.dart';

class RoomService {
  final Dio dio = DioInterceptor().createDio();
  String api = "http://millima.flutterwithakmaljon.uz/api/";

  Future<Map<String, dynamic>> getRooms() async {
    try {
      final response = await dio.get(
        '${api}rooms',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addRoom(String name, String description, int capacity) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "name": name,
        "description": description,
        "capacity": capacity,
      };

      final response = await dio.post(
        '${api}rooms',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw 'Failed to add room: ${response.statusCode}';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> getAvailableRooms(
    int dayId,
    String startTime,
    String endTime,
  ) async {
    try {
      final response = await dio.get(
        '${api}available-rooms?dayId=$dayId&startTime=$startTime&endTime=$endTime',
      );
      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRoom(
      int roomId, String name, String description, int capacity) async {
    try {
      await dio.put(
        '${api}rooms/$roomId',
        data: {
          'name': name,
          'description': description,
          'capacity': capacity,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRoom(int roomId) async {
    try {
      final response = await dio.delete(
        '${api}rooms/$roomId',
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
