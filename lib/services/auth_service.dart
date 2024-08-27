import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/interceptor/dio_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

class AuthService {
  final Dio dio = DioInterceptor().createDio();
  String api = "http://millima.flutterwithakmaljon.uz/api/";
  String apiWithoutApi = "http://millima.flutterwithakmaljon.uz/";

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
        roleId: response.data['data']['role_id'],
        photo:
            "$apiWithoutApi/storage/avatars/${response.data['data']['photo']}",
        email: response.data['data']['email'],
        id: response.data['data']['id'],
      );
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    String? email,
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
        File compressedPhoto =
            await _compressImage(photo, maxSizeInBytes: 512 * 1024);

        formData.files.add(
          MapEntry(
            'photo',
            await MultipartFile.fromFile(
              compressedPhoto.path,
              filename: 'profile_photo.${compressedPhoto.path.split('.').last}',
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
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<File> _compressImage(File file, {required int maxSizeInBytes}) async {
    img.Image image = img.decodeImage(await file.readAsBytes())!;

    int quality = 100;
    File compressedFile = file;

    do {
      quality -= 10;

      List<int> compressedBytes = img.encodeJpg(image, quality: quality);

      compressedFile = File('${file.path}_compressed.jpg');
      await compressedFile.writeAsBytes(compressedBytes);
    } while (compressedFile.lengthSync() > maxSizeInBytes && quality > 10);

    return compressedFile;
  }

  Future<List<GeneralUserInfoModel>> getAllUsers() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/users',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }

      List<GeneralUserInfoModel> result = [];
      for (var user in response.data['data']) {
        result.add(
          GeneralUserInfoModel(
              name: user['name'],
              phone: user['phone'],
              roleId: user['role_id'],
              photo: user['photo'] != null
                  ? "$apiWithoutApi/storage/avatars/${user['photo']}"
                  : null,
              email: user['email'],
              id: user['id']),
        );
      }
      return result;
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
