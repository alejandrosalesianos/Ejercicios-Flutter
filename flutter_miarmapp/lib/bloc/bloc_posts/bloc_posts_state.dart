part of 'bloc_posts_bloc.dart';

abstract class BlocPostsState extends Equatable {
  const BlocPostsState();

  @override
  List<Object> get props => [];
}

class BlocPostsInitial extends BlocPostsState {}

class BlocPostsFetched extends BlocPostsState {
  final List<Post> posts;

  const BlocPostsFetched(this.posts);

  @override
  List<Object> get props => [posts];
}

class BlocPostsFetchedError extends BlocPostsState {
  final String message;

  const BlocPostsFetchedError(this.message);

  @override
  List<Object> get props => [message];
}
