import 'dart:convert';

import 'package:flutter_miarmapp/data/constants.dart';
import 'package:flutter_miarmapp/model/my_user_response.dart';
import 'package:flutter_miarmapp/repository/user_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/constants.dart';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<MyUserResponse> fetchPostsUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await _client.get(
        Uri.parse('${ApiConstants.apiBaseUrl}me'),
        headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      return MyUserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
