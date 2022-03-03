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

class SelectImagePostEvent extends BlocPostsEvent {
  final ImageSource source;

  const SelectImagePostEvent(this.source);

  @override
  List<Object> get props => [source];
}

class SavePostEvent extends BlocPostsEvent{
  final PostDto postDto;
  final String path;

  const SavePostEvent(this.postDto,this.path);

  @override
  List<Object> get props => [postDto,path];
}
