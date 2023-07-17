import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_picture_state.dart';

class UploadPictureCubit extends Cubit<UploadPictureState> {
  UploadPictureCubit() : super(UploadPictureInitial());
}
