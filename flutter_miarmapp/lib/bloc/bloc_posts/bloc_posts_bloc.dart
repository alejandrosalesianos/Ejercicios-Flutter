import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/model/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository.dart';

part 'bloc_posts_event.dart';
part 'bloc_posts_state.dart';

class BlocPostsBloc extends Bloc<BlocPostsEvent, BlocPostsState> {
  final PostRepository postRepository;

  BlocPostsBloc(this.postRepository) : super(BlocPostsInitial()) {
    on<BlocPostsEvent>(_postsFetched);
  }

  void _postsFetched(BlocPostsEvent event, Emitter<BlocPostsState> emit) async {
    try {
      final posts = await postRepository.fetchPosts();
      emit(BlocPostsFetched(posts));
      return;
    } on Exception catch (e) {
      emit(BlocPostsFetchedError(e.toString()));
    }
  }
}
