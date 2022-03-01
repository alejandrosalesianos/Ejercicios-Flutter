import 'package:flutter_miarmapp/model/register_dto.dart';
import 'package:flutter_miarmapp/model/register_response.dart';

abstract class RegisterRepository{
  Future<RegisterResponse> register(RegisterDto registerDto,String filePath);
}