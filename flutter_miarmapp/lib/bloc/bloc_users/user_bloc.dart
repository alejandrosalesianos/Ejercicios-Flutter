import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserRepository userRepository) : super(UserInitial()) {
    //on<UserEvent>();
    on<FetchUserWithNameEvent>(_fetchUsers);
  }

  void _fetchUsers(FetchUserWithNameEvent event, Emitter<UserState> emit) {}
}
