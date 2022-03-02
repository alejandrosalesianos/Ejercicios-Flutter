import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/model/register_dto.dart';
import 'package:flutter_miarmapp/model/register_response.dart';
import 'package:flutter_miarmapp/repository/register_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'image_pick_event.dart';
part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  final RegisterRepository registerRepository;
  ImagePickBloc(this.registerRepository) : super(ImagePickInitial()) {
    on<SelectImageEvent>(_onSelectImage);
    on<SaveUserEvent>(_doRegister);
  }

  void _onSelectImage(
      SelectImageEvent event, Emitter<ImagePickState> emit) async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(ImageSelecedSuccessState(pickedFile));
      } else {
        emit(const ImageSelectedErrorState('Error in image selection'));
      }
    } catch (e) {
      emit(const ImageSelectedErrorState('Error in image selection'));
    }
  }

  void _doRegister(SaveUserEvent event, Emitter<ImagePickState> emit) async {
    emit(SaveLoadingState());
    try {
      final registerResponse =
          await registerRepository.register(event.registerDto, event.path);
      emit(RegisterSucessState());
      return;
    } on Exception catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
