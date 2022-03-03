import 'package:flutter_miarmapp/model/post_dto.dart';
import 'package:flutter_miarmapp/model/post_response.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts();
  Future<PostResponse> newPost(PostDto postDto,String filePath);
}
