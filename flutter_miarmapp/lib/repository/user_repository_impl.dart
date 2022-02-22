import 'dart:convert';

import 'package:flutter_miarmapp/data/constants.dart';
import 'package:flutter_miarmapp/repository/user_repository.dart';
import 'package:http/http.dart';
import '../data/constants.dart';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<List<Object>> fetchUsers(String nombre) {
    // TODO: implement fetchUsers
    throw UnimplementedError();
  }

  /*@override
  Future<List<Object>> fetchUsers(String nombre) async {
    final response = await _client.get(Uri.parse('${ApiConstants.apiBaseUrl}'));
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Fail to load users');
    }
  } */
}
