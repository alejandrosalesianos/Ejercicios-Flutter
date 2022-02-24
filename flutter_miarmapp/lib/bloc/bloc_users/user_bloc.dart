import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/model/my_user_response.dart';
import 'package:flutter_miarmapp/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsersEvent>(_fetchUsers);
  }

  void _fetchUsers(FetchUsersEvent event, Emitter<UserState> emit) async {
    try {
      final user = await userRepository.fetchPostsUser();
      emit(UserFetched(user));
      return;
    } on Exception catch (e) {
      emit(UserFetchError(e.toString()));
    }
  }
}
