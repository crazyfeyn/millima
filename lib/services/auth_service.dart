import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final dio = Dio();
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

  // Future<void> logout() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('token');

  //     if (token != null) {
  //       await dio.post(
  //         "${api}logout",
  //         options: Options(
  //           headers: {"Authorization": "Bearer $token"},
  //         ),
  //       );
  //     }

  //     await prefs.remove('token');
  //   } on DioException {
  //     rethrow;
  //   }
  // }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    try {
      final response = await dio.post(
        "http://millima.flutterwithakmaljon.uz/api/logout",
        options: Options(
          headers: {"Authorization": 'Bearer $token'},
        ),
      );
      await prefs.clear();
    } on DioException {
      rethrow;
    } catch (e) {
      print("Error:  $e");
      rethrow;
    }
  }
}
