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
class OnConvertS3ToImageFileEvent extends ImageUploadEvent {
  final List<String>? s3Params;

  OnConvertS3ToImageFileEvent(this.s3Params);
}


class OnUpdateOnBoardingUserEvent extends ImageUploadEvent {
  bool isUnAuthorized = false;
  OnUpdateOnBoardingUserEvent({required this.isUnAuthorized});
}

class OnRequestApiCall extends ImageUploadEvent {
  final List<MultipartFile> params;
  final String id;
  final String token;
  OnRequestApiCall(this.params, this.token, this.id);
}

