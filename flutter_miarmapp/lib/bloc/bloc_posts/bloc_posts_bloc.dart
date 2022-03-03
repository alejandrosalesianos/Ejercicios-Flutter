import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/bloc/bloc_image_pick/image_pick_bloc.dart';
import 'package:flutter_miarmapp/model/post_dto.dart';
import 'package:flutter_miarmapp/model/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'bloc_posts_event.dart';
part 'bloc_posts_state.dart';

class BlocPostsBloc extends Bloc<BlocPostsEvent, BlocPostsState> {
  final PostRepository postRepository;

  BlocPostsBloc(this.postRepository) : super(BlocPostsInitial()) {
    on<FetchPosts>(_postsFetched);
    on<SelectImagePostEvent>(_onSelectImagePost);
    on<SavePostEvent>(_savePost);
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

  void _savePost(SavePostEvent event, Emitter<BlocPostsState> emit) async {
    emit(NewPostLoadingState());
    try {
      final PostResponse = await postRepository.newPost(event.postDto, event.path);
      emit(NewPostSuccessState());
      return;
    }on Exception catch (e) {
      emit(NewPostErrorState(e.toString()));
    }
  }

  void _onSelectImagePost(SelectImagePostEvent event, Emitter<BlocPostsState> emit) async {
    final ImagePicker _picker = ImagePicker();
    try{
      final XFile? pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(ImageSelectedPostSuccessState(pickedFile));
    } else {
      emit(const ImageSelectedPostErrorState('Error en la selección de imagen'));
    }
    }catch (e){
      emit(const ImageSelectedPostErrorState('Error en la selección de imagen'));
    }
    
  }
}
