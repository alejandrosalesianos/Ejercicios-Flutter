import 'dart:convert';

import 'package:flutter_miarmapp/data/constants.dart';
import 'package:flutter_miarmapp/model/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository.dart';
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Post>> fetchPosts() async {
    final response =
        await _client.get(Uri.parse('${ApiConstants.apiBaseUrl}post/public'));
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
