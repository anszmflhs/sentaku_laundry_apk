import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';
import 'package:sentaku_laundry_apk/models/order.dart';

import '../constants/api_config.dart';

class PriceListService {
  PriceListService._();

  static Future<List<Pricelist>?> getPriceLists() async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.priceListEndpoint}';
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
          List<Pricelist> pricelists = [];
          for (final d in listDataJson) {
            pricelists.add(Pricelist.fromJson(d));
          }
          return pricelists;
        }
      }
    } catch (e) {
      log('Error get Orders $e');
      return null;
    }
  }

  static Future<void> createPriceLists({
    required String id,
    required String quantity,
    required String harga,
    required String another,
    required String hargaanother,
    required String total,
    required String createdAt,
    required String updatedAt,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.priceListEndpoint}';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final Map<String, dynamic> body ={
        'id': id,
        'quantity': quantity,
        'harga': harga,
        'another': another,
        'hargaanother': hargaanother,
        'total': total,
      };

      final response =
      await dio.post(url, data: body, options: Options(headers: body));
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          await getPriceLists();
        }
      }
    } catch (e, st) {
      log('Error createOrder : $e\nStacktrace : $st');
    }
  }

  static Future<void> updatePriceLists({
    required String id,
    required String quantity,
    required String harga,
    required String another,
    required String hargaanother,
    required String total,
    required String createdAt,
    required String updatedAt,
  }) async {
    try {
      final url = '${ApiConfig.baseUrl}/${ApiConfig.priceListEndpoint}/$id';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      final Map body = {
        'id': id,
        'quantity': quantity,
        'harga': harga,
        'another': another,
        'hargaanother': hargaanother,
        'total': total,
      };
      final response =
      await dio.put(url, data: body, options: Options(headers: header));
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          await getPriceLists();
        }
      }
    } catch (e) {
      log('Error updateOrder $e');
    }
  }

  static Future<void> deletePriceLists(int id) async {
    try {
      final url = '${ApiConfig.baseUrl}/${ApiConfig.priceListEndpoint}/$id';
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
          await getPriceLists();
        }
      }
    } catch (e) {
      log('Error deleteOrder : $e');
    }
  }
}
