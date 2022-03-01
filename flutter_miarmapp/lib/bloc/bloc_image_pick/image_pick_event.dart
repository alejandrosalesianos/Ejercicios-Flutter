part of 'image_pick_bloc.dart';

abstract class ImagePickEvent extends Equatable {
  const ImagePickEvent();

  @override
  List<Object> get props => [];
}

class SelectImageEvent extends ImagePickEvent {
  final ImageSource source;
  final RegisterDto registerDto;

  const SelectImageEvent(this.source,this.registerDto);

  @override
  List<Object> get props => [source];
}
