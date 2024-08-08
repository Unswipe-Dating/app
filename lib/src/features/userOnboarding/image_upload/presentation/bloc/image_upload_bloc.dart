import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../../../../../data/api_response.dart';
import '../../../../../../data/api_response.dart' as api_response;
import '../../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../../../shared/presentation/widgets/multi_image_view/image_file.dart';
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../onBoarding/presentation/bloc/onboarding_bloc.dart';
import '../../../../settings/domain/usecases/get_settings_profile_usecase.dart';
import '../../../../userProfile/data/model/get_profile/response_profile_swipe.dart';
import '../../domain/usecase/image_upload_usecase.dart';
import '../../../../../shared/utils/file_utils.dart';
part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;
  final ImageUploadUseCase imageUploadUseCase;
  bool isS3FilesAvailable = false;
  final GetSettingsProfileUseCase getSettingsProfileUseCase;
  String id = "";
  String? userId = "";
  String token = "";


  // List of splash

  ImageUploadBloc({
    required this.updateOnboardingStateStreamUseCase,
    required this.getAuthStateStreamUseCase,
    required this.imageUploadUseCase,
    required this.getSettingsProfileUseCase
    
  })
      : super(const ImageUploadState()) {
    on<OnInitiateUploadSubject>(_onStartImageUploadApi);
    on<OnRequestApiCall>(_onStartUploadApi);
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);
    on<OnConvertS3ToImageFileEvent>(_onConvertS3ToImageFIleEvent);
    on<OnStartGettingProfile>(_onStartSettingProfileUseCase);
    on<OnGetUserProfile>(_onGetUserProfile);

  }

  _onGetUserProfile(
      OnGetUserProfile event, Emitter<ImageUploadState> emitter) async {
    Stream<GetSettingsProfileUseCaseResponse> stream =
    await getSettingsProfileUseCase.buildUseCaseStream(
        event.token, event.id);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ImageUploadStatus.error);
      } else if (responseData is api_response.AuthorizationFailure) {
        return state.copyWith(status: ImageUploadStatus.errorAuth);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: ImageUploadStatus.errorTimeOut);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ImageUploadStatus.error);
      } else if (responseData is api_response.Success) {
        var profile = (((responseData as api_response.Success).data)
        as ResponseProfileSwipe)
            .userProfile;
        add(OnConvertS3ToImageFileEvent(profile?.photoURLs));

        return state.copyWith(
            status: ImageUploadStatus.loading);
      } else {
        return state.copyWith(status: ImageUploadStatus.error);
      }
    });
  }



  _onStartSettingProfileUseCase(
      OnStartGettingProfile event, Emitter<ImageUploadState> emitter) async {
    emitter(state.copyWith(status: ImageUploadStatus.loading));

    await emitter.forEach(
      getAuthStateStreamUseCase.call(),
      onData: (response) {
        return response.fold(ifLeft: (l) {
          if (l is CancelTokenFailure) {
            return state.copyWith(status: ImageUploadStatus.error);
          } else {
            return state.copyWith(status: ImageUploadStatus.error);
          }
        }, ifRight: (r) {
          if (r.userAndToken?.token != null && r.userAndToken?.id != null) {
            token = r.userAndToken!.token;
            id = r.userAndToken!.id;
            userId = r.userAndToken!.userId;
            if(userId?.isNotEmpty == true) {
              add(OnGetUserProfile(r.userAndToken!.token, r.userAndToken!.id));
              return state.copyWith(status: ImageUploadStatus.loading);
            }
            return state.copyWith(status: ImageUploadStatus.loadedAuth);
          } else {
            return state.copyWith(status: ImageUploadStatus.error);
          }
        });
      },
    );
  }

  _onStartUploadApi(
      OnRequestApiCall event, Emitter<ImageUploadState> emitter) async {
    emitter(state.copyWith(status: ImageUploadStatus.loading));
    await imageUploadUseCase.buildUseCaseStream(
        token, getFilesForUpload(event.params));
    emitter(state.copyWith(status: ImageUploadStatus.loaded));

  }


  _onConvertS3ToImageFIleEvent(OnConvertS3ToImageFileEvent event,
      Emitter<ImageUploadState> emitter) async{

    emitter(state.copyWith(
        status: ImageUploadStatus.loading));

    if(event.s3Params != null) {
    isS3FilesAvailable = true;
      List<ImageFile> files = [];

      for (final uri in event.s3Params!) {
        var val = await imageFileFromImageUrl(uri, uri.substring(uri.length - 13 , uri.length - 4));
        files.add(val);
      }

      emitter.call(
          state.copyWith(status: ImageUploadStatus.loadedS3Images, loadedFiles: files));
    } else {
      emitter.call(
          state.copyWith(status: ImageUploadStatus.emptyFiles,));
    }

}

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<ImageUploadState> emitter) async{

    OnBoardingStatus status = OnBoardingStatus.update;
    if(event.isUnAuthorized) {
      status = OnBoardingStatus.init;
    }

    await emitter.forEach(
        updateOnboardingStateStreamUseCase
            .call(status), onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: ImageUploadStatus.error);
        } else {
          return state.copyWith(status: ImageUploadStatus.error);
        }
      },
          ifRight: (r) {
        if(status == OnBoardingStatus.init) {
          return state.copyWith(status: ImageUploadStatus.errorAuth);
        }

            return state.copyWith(status: ImageUploadStatus.loaded);}
      );

    }, onError: (error, stacktrace) {
      return state.copyWith(status: ImageUploadStatus.error);

    });

  }

  _onStartImageUploadApi(OnInitiateUploadSubject event,
      Emitter<ImageUploadState> emitter) async {

    await emitter.forEach(imageUploadUseCase.controller.stream,
        onData: (response)  {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ImageUploadStatus.error);
      } else if (responseData is api_response.AuthorizationFailure) {
        add(OnUpdateOnBoardingUserEvent(isUnAuthorized: true));
        return state.copyWith(status: ImageUploadStatus.loading);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: ImageUploadStatus.errorTimeOut);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ImageUploadStatus.error);
      } else if (responseData is api_response.Success) {
        if(isS3FilesAvailable) {
          return state.copyWith(status: ImageUploadStatus.loaded);
        }
        add(OnUpdateOnBoardingUserEvent(isUnAuthorized: false));
        return state.copyWith(status: ImageUploadStatus.loading);
      } else {
        return state.copyWith(status: ImageUploadStatus.error);
      }
    });
  }


  List<MultipartFile> getFilesForUpload(List<ImageFile> images) {
    List<MultipartFile> listFiles = [];
    for (var element in images) {
      if (element.path != null) {
        File file = File(element.path!);
        var value = (lookupMimeType(file.path ?? "") ?? "image/png").split(
            "/");

        listFiles.add(
            MultipartFile.fromBytes(
              "",
              file.readAsBytesSync() ?? [],
              filename: element.name,
              contentType: MediaType(value.first, value.last),
            )
        );
      }
    }

    return listFiles;

  }


// This function is called whenever the text field changes


}
