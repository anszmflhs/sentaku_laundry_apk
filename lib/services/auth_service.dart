import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sentaku_laundry_apk/constants/api_config.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';


import '../models/user.dart';

class AuthService {
  // ! Dibikin singleton biar mastiin yg dibikin program hanya 1 object yg dibuat dari class ini
  AuthService._();

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.loginEndpoint}';
      final data = {
        'email': email,
        'password': password,
      };
      log(data.toString());
      final response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          final token = responseJson['access_token'];
          final user = User.fromJson(responseJson['data']);
          // ! Cache User dan token
          await SecureStorage.cacheToken(token: token);
          await SecureStorage.cacheUser(user: user);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e,st) {
      log('$e $st');
      return false;
    }
  }

  static Future<bool> register({
    required String name,
    required String email,
    required String nohp,
    required String alamat,
    required String password,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.registerEndpoint}';
      final data = {
        'name': name,
        'email': email,
        'nohp': nohp,
        'alamat': alamat,
        'password': password,
      };
      log(data.toString());
      final response = await dio.post(
       url,
        data: data,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          final token = responseJson['access_token'];
          final user = User.fromJson(responseJson['data']);
          // ! Cache User dan token
          await SecureStorage.cacheToken(token: token);
          await SecureStorage.cacheUser(user: user);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }

  static Future<bool> logout() async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.logoutEndpoint}';
      log(url);
      final token = await SecureStorage.getToken();
      log('$token');
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response = await dio.post(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log('Error $e');
      return false;
    }
  }
}