part of 'image_pick_bloc.dart';

abstract class ImagePickEvent extends Equatable {
  const ImagePickEvent();

  @override
  List<Object> get props => [];
}

class SelectImageEvent extends ImagePickEvent {
  final ImageSource source;

  const SelectImageEvent(this.source);

  @override
  List<Object> get props => [source];
}

class SaveUserEvent extends ImagePickEvent {
  final RegisterDto registerDto;
  final String path;

  const SaveUserEvent(this.registerDto, this.path);

  @override
  List<Object> get props => [registerDto, path];
}
