import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';
import 'package:sentaku_laundry_apk/models/order.dart';

import '../constants/api_config.dart';

class ServiceManageService {
  ServiceManageService._();

  static Future<List<Servicemanage>?> getServiceManages() async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.serviceManageEndpoint}';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final response = await dio.get(url, options: Options(headers: header));
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          final List listDataJson = responseJson['data'];
          List<Servicemanage> servicemanages = [];
          for (final json in listDataJson) {
            servicemanages.add(Servicemanage.fromJson(json));
          }
          return servicemanages;
        }
      }
    } catch (e) {
      log('Error get Orders $e');
      return null;
    }
  }

  static Future<void> createServiceManages({
    required String id,
    required String title,
    required String userId,
    required String createdAt,
    required String updatedAt,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.serviceManageEndpoint}';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final Map<String, dynamic> body ={
        'id': id,
        'title': title,
        'userId': userId,
      };

      final response =
      await dio.post(url, data: body, options: Options(headers: body));
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          await getServiceManages();
        }
      }
    } catch (e, st) {
      log('Error createOrder : $e\nStacktrace : $st');
    }
  }

  static Future<void> updateServiceManages({
    required String id,
    required String title,
    required String userId,
    required String createdAt,
    required String updatedAt,
  }) async {
    try {
      final url = '${ApiConfig.baseUrl}/${ApiConfig.serviceManageEndpoint}/$id';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final Map body = {
        'id': id,
        'title': title,
        'userId': userId,
      };
      final response =
      await dio.put(url, data: body, options: Options(headers: header));
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          await getServiceManages();
        }
      }
    } catch (e) {
      log('Error updateOrder $e');
    }
  }

  static Future<void> deleteServiceManages(int id) async {
    try {
      final url = '${ApiConfig.baseUrl}/${ApiConfig.serviceManageEndpoint}/$id';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final response = await dio.delete(
        url,
        options: Options(headers: header),
      );
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          await getServiceManages();
        }
      }
    } catch (e) {
      log('Error deleteOrder : $e');
    }
  }
}
