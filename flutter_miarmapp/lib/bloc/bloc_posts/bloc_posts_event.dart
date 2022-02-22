part of 'bloc_posts_bloc.dart';

abstract class BlocPostsEvent extends Equatable {
  const BlocPostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends BlocPostsEvent {
  @override
  List<Object> get props => [];
}
