import 'dart:convert';

import 'package:flutter_miarmapp/data/constants.dart';
import 'package:flutter_miarmapp/model/login_response.dart';
import 'package:flutter_miarmapp/model/login_dto.dart';
import 'package:flutter_miarmapp/repository/login_repository.dart';
import 'package:http/http.dart';

class LoginRepositoryImpl extends LoginRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final response =
        await Future.delayed(const Duration(milliseconds: 4000), () {
      return _client.post(Uri.parse('${ApiConstants.apiBaseUrl}auth/login'),
          headers: headers, body: jsonEncode(loginDto.toJson()));
    });
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }
}
