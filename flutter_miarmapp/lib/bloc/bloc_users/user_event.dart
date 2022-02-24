part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

//por cada evento que pueda producirse se instancia una nueva clase
class FetchUsersEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
