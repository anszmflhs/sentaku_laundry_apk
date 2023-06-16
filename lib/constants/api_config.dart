import 'package:dio/dio.dart';

class ApiConfig {
  ApiConfig._();

  static const baseUrl = 'http://127.0.0.1:8000/api';
  static const loginEndpoint = 'login-user';
  static const registerEndpoint = 'register';
  static const logoutEndpoint = 'logoutUser';
  static const orderEndpoint = 'payments';
  static const userUpdateEndpoint = 'user/update';
  static const priceListEndpoint = 'price_lists';
  static const serviceManageEndpoint = 'service_manages';
}

final dio = Dio();