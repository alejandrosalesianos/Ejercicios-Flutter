import 'dart:convert';

import 'package:flutter_miarmapp/data/constants.dart';
import 'package:flutter_miarmapp/model/my_user_response.dart';
import 'package:flutter_miarmapp/repository/user_repository.dart';
import 'package:http/http.dart';
import '../data/constants.dart';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<MyUserResponse> fetchPostsUser() async {
    final response =
        await _client.get(Uri.parse('${ApiConstants.apiBaseUrl}me'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzNjEwNTVhMC1iZDdmLTQwM2UtYjI5ZC0yY2IyYzY3ZDljMzAiLCJpYXQiOjE2NDU3OTExNjgsIm5vbWJyZSI6InNreWFkb3IiLCJwZXJmaWwiOiJQVUJMSUNPIn0.PShEc_GnFjiZK_WdWsieb1jQ0EjXY9yhHmTZzIvwa2qNj3b7lFdFrHxvtxaIAmxmfP7WLO2EBsWKlaefqPQNZw'
    });
    if (response.statusCode == 200) {
      return MyUserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
