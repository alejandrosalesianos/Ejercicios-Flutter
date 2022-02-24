import 'package:flutter_miarmapp/model/my_user_response.dart';

abstract class UserRepository {
  Future<MyUserResponse> fetchPostsUser();
}
