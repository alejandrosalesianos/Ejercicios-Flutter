part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFetched extends UserState {
  final List<Object> listUser; //cambiar por user cuando tenga el model

  const UserFetched(this.listUser);
  @override
  List<Object> get props => [listUser];
}

class UserFetchError extends UserState {
  final String message;

  const UserFetchError(this.message);
  @override
  List<Object> get props => [message];
}

class OneUserFetchError extends UserState {}

class OneUserFetched extends UserState {}
