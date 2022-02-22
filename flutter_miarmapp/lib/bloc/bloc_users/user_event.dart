part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

//por cada evento que pueda producirse se instancia una nueva clase
class FetchUserWithNameEvent extends UserEvent {
  final String name;

  const FetchUserWithNameEvent(this.name);

  @override
  List<Object> get props => [name];
}
