import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medical_app/model/obat_model.dart';
import 'package:medical_app/model/user_login_model.dart';

class ApiConfig {
  late Dio dio;
  ApiConfig() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.2.67:8000/api/',
    ));
  }

  Future<User> login(String username, String password) async {
    try {
      final response = await dio.post('login', data: {
        'username': username,
        'password': password,
      });
      final data = User.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw Exception('Error fetching data: ${e.message}');
    }
  }

  Future<void> storeObat(
      String token, String nama, String harga, String satuan) async {
    try {
      await dio.post('obat',
          data: {
            'nama': nama,
            'harga': harga,
            'satuan': satuan,
          },
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
          }));
    } on DioException catch (e) {
      log('Error fetching data: ${e.message}');
      throw Exception('Error fetching data: ${e.message}');
    }
  }

  Future<void> updateObat(
      String token, int id, String nama, String harga, String satuan) async {
    try {
      await dio.put('obat/$id',
          data: {
            'nama': nama,
            'harga': harga,
            'satuan': satuan,
          },
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
          }));
    } on DioException catch (e) {
      log('Error fetching data: ${e.message}');
      throw Exception('Error fetching data: ${e.message}');
    }
  }

  Future<void> deleteObat(String token, int id) async {
    try {
      await dio.delete('obat/$id',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
          }));
    } on DioException catch (e) {
      log('Error fetching data: ${e.message}');
      throw Exception('Error fetching data: ${e.message}');
    }
  }

  Future<ObatModel> getObat(String token) async {
    try {
      final response = await dio.get('obat',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      final data = ObatModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw Exception('Error fetching data: ${e.message}');
    }
  }
}
