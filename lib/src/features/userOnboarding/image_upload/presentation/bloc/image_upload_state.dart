part of 'image_upload_bloc.dart';


enum ImageUploadStatus { initial,
  fetchedToken,
  loading,
  loaded,
  loadedProfile,
  error,
  errorAuth,
  loadedAuth,
  errorTimeOut,
  emptyFiles,
  loadedS3Images,
}

class ImageUploadState extends Equatable {
  final ImageUploadStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;
  final List<ImageFile>? loadedFiles;

  const ImageUploadState({
    this.status = ImageUploadStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,
    this.loadedFiles,

  });


  ImageUploadState copyWith({
    ImageUploadStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
    List<ImageFile>? loadedFiles,
  }) {
    return ImageUploadState(
      status: status ?? this.status,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      loadedFiles: loadedFiles ?? this.loadedFiles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isFirstTime,
    isAuthenticated,
    loadedFiles,
  ];
}