import 'dart:convert';

import 'package:flutter_miarmapp/data/constants.dart';
import 'package:flutter_miarmapp/model/register_dto.dart';
import 'package:flutter_miarmapp/model/register_response.dart';
import 'package:flutter_miarmapp/repository/register_repository.dart';
import 'package:http/http.dart' as http;

class RegisterRepositoryImpl extends RegisterRepository {
  @override
  Future<RegisterResponse> register(RegisterDto registerDto, filePath) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    var uri = Uri.parse('${ApiConstants.apiBaseUrl}auth/register/');
    var request = http.MultipartRequest('POST', uri);

    request.fields['nick'] = registerDto.nick;
    request.fields['email'] = registerDto.email;
    request.fields['fechaNacimiento'] = registerDto.fechaNacimiento;
    request.fields['telefono'] = registerDto.telefono;
    request.fields['perfil'] = registerDto.perfil;
    request.fields['password'] = registerDto.password;
    request.fields['password2'] = registerDto.password2;
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Fallo al registrarse');
    }
  }
}
