part of 'image_pick_bloc.dart';

abstract class ImagePickState extends Equatable {
  const ImagePickState();
  
  @override
  List<Object> get props => [];
}

class ImagePickInitial extends ImagePickState {}

class ImageSelecedSuccessState extends ImagePickState {
  final XFile SelectedFile;

  const ImageSelecedSuccessState(this.SelectedFile);

  @override
  List<Object> get props => [SelectedFile];
}

class ImageSelectedErrorState extends ImagePickState {
  final String message;

  const ImageSelectedErrorState(this.message);

  @override
  List<Object> get props => [message];
}
