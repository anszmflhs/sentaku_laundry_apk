import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';
import 'package:sentaku_laundry_apk/models/order.dart';

import '../constants/api_config.dart';

class OrderService {
  OrderService._();

  static Future<List<Order>?> getOrders() async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.orderEndpoint}';
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
          List<Order> orders = [];
          for (final json in listDataJson) {
            orders.add(Order.fromJson(json));
          }

          log('${orders.length} PANJANG');
          return orders;
        }
      }
    } catch (e,st) {
      log('Error get Orders $e, $st');
      return null;
    }
  }

  static Future<void> createOrder({
    required String user_id,
    required String service_manages_id,
    required String price_lists_id,
    required String quantity,
    required String status,
    required String total,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.orderEndpoint}';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final Map<String, dynamic> body ={
        'user_id': user_id,
        'service_manages_id': service_manages_id,
        'price_lists_id': price_lists_id,
        'quantity': quantity,
        'status': status,
        'total': total
      };

      final response =
          await dio.post(url, data: body, options: Options(headers: body));
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          await getOrders();
        }
      }
    } catch (e, st) {
      log('Error createOrder : $e\nStacktrace : $st');
    }
  }

  static Future<void> updateOrder({
    required String id,
    required String user_id,
    required String service_manages_id,
    required String price_lists_id,
    required Int quantity,
    required String status,
  }) async {
    try {
      final url = '${ApiConfig.baseUrl}/${ApiConfig.orderEndpoint}/$id';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final Map body = {
        'user_id': '1',
        'service_manages_id': '1',
        'price_lists_id': '1',
        'quantity': '4',
        'status': 'unpaid',
        'total': '8000'
      };
      final response =
          await dio.put(url, data: body, options: Options(headers: header));
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          await getOrders();
        }
      }
    } catch (e) {
      log('Error updateOrder $e');
    }
  }

  static Future<void> deleteOrder(int id) async {
    try {
      final url = '${ApiConfig.baseUrl}/${ApiConfig.orderEndpoint}/$id';
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
          await getOrders();
        }
      }
    } catch (e) {
      log('Error deleteOrder : $e');
    }
  }
}
