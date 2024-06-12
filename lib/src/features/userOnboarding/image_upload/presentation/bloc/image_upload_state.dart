part of 'image_upload_bloc.dart';


enum ImageUploadStatus { initial, fetchedToken, loading, loaded, error, errorAuth, errorTimeOut, }

class ImageUploadState extends Equatable {
  final ImageUploadStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;

  const ImageUploadState({
    this.status = ImageUploadStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,

  });


  ImageUploadState copyWith({
    ImageUploadStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
  }) {
    return ImageUploadState(
      status: status ?? this.status,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isFirstTime,
    isAuthenticated,
  ];
}