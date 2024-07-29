part of 'image_upload_bloc.dart';


abstract class ImageUploadEvent {
  const ImageUploadEvent();
}

class OnBlockContactsSuccess extends ImageUploadEvent {

  OnBlockContactsSuccess();
}

class OnStartGettingProfile extends ImageUploadEvent {
  OnStartGettingProfile();
}

class OnGetUserProfile extends ImageUploadEvent {
  final String id;
  final String token;
  OnGetUserProfile(this.token, this.id);
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

class OnInitiateUploadSubject extends ImageUploadEvent {
  OnInitiateUploadSubject();
}

class OnRequestApiCall extends ImageUploadEvent {
  final List<ImageFile> params;
  OnRequestApiCall(this.params);
}

