import 'package:flutter_miarmapp/model/login_dto.dart';
import 'package:flutter_miarmapp/model/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}
