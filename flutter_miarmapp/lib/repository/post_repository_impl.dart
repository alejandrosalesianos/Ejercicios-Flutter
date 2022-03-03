import 'dart:convert';

import 'package:flutter_miarmapp/data/constants.dart';
import 'package:flutter_miarmapp/model/post_dto.dart';
import 'package:flutter_miarmapp/model/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Future<PostResponse> newPost(PostDto postDto, filePath) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String,String> header = {
      "Content-Type":"application/json",
      "Authorization": "Bearer ${token}"
    };
    var uri = Uri.parse('${ApiConstants.apiBaseUrl}post/');
    var request = http.MultipartRequest('POST',uri);

    request.headers.addAll(header);
    request.fields['titulo'] = postDto.titulo;
    request.fields['contenido'] = postDto.contenido;
    request.fields['tipoPubli'] = postDto.tipoPublicacion;
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();

    if (response.statusCode == 201) {
      return PostResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Fallo al subir el post');
    }
  }
  
}
