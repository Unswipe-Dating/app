part of 'image_upload_bloc.dart';


abstract class ImageUploadEvent {
  const ImageUploadEvent();
}

class OnBlockContactsSuccess extends ImageUploadEvent {

  OnBlockContactsSuccess();
}

class OnImageUploadRequested extends ImageUploadEvent {
  final List<ImageFile> params;

  OnImageUploadRequested(this.params);
}


class OnUpdateOnBoardingUserEvent extends ImageUploadEvent {
  OnUpdateOnBoardingUserEvent();
}

class OnRequestApiCall extends ImageUploadEvent {
  final List<MultipartFile> params;
  final String id;
  final String token;
  OnRequestApiCall(this.params, this.token, this.id);
}

