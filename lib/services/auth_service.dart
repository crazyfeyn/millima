import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/interceptor/dio_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio = DioInterceptor().createDio();
  String api = "http://millima.flutterwithakmaljon.uz/api/";

  Future<Response> signUp(UserModel user) async {
    try {
      final result = await dio.post(
        "${api}register",
        data: {
          "name": user.name,
          "phone": user.phone,
          "password": user.password,
          "password_confirmation": user.passwordConfirmation,
          "role_id": user.roleId ?? 1
        },
      );
      return result;
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<Response> signIn(
    String phone,
    String password,
  ) async {
    try {
      final result = await dio.post(
        "${api}login",
        data: {
          "phone": phone,
          "password": password,
        },
      );
      return result;
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await dio.post("${api}logout");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<GeneralUserInfoModel> getUser() async {
    try {
      var response = await dio.get("${api}user");
      return GeneralUserInfoModel(
          name: response.data['data']['name'],
          phone: response.data['data']['phone'],
          roleId: response.data['data']['role_id']);
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateProfile({
    required String name,
    String? email,
    required String phone,
    File? photo,
  }) async {
    try {
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('name', name),
        MapEntry('phone', phone),
      ]);

      if (email != null) {
        formData.fields.add(MapEntry('email', email));
      }

      if (photo != null) {
        formData.files.add(
          MapEntry(
            'photo',
            await MultipartFile.fromFile(
              photo.path,
              filename: 'profile_photo.${photo.path.split('.').last}',
            ),
          ),
        );
      }

      final response = await dio.post(
        "http://millima.flutterwithakmaljon.uz/api/profile/update",
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      print("Profile updated: ${response.data}");
    } on DioException catch (error) {
      print("Failed to update profile: ${error.response?.data}");
      throw error.message.toString();
    } catch (e) {
      print("An error occurred: $e");
      rethrow;
    }
  }
}
