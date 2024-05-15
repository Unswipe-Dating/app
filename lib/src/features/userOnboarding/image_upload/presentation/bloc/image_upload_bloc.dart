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
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../onBoarding/presentation/bloc/onboarding_bloc.dart';
import '../../domain/usecase/image_upload_usecase.dart';
import '../widgets/multi_image_picker_files/image_file.dart';
part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;
  final ImageUploadUseCase imageUploadUseCase;

  // List of splash

  ImageUploadBloc({
    required this.updateOnboardingStateStreamUseCase,
    required this.getAuthStateStreamUseCase,
    required this.imageUploadUseCase
    
  })
      : super(ImageUploadState()) {
    on<OnImageUploadRequested>(_onStartImageUpload);
    on<OnRequestApiCall>(_onStartImageUploadApi);
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);

  }

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<ImageUploadState> emitter) async{

    emitter(state.copyWith(status: ImageUploadStatus.loading));

    await Future.delayed(const Duration(seconds: 3));
    await emitter.forEach(
        updateOnboardingStateStreamUseCase
            .call(OnBoardingStatus.update), onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: ImageUploadStatus.error);
        } else {
          return state.copyWith(status: ImageUploadStatus.error);
        }
      },
          ifRight: (r) {
            return state.copyWith(status: ImageUploadStatus.loaded);}
      );

    }, onError: (error, stacktrace) {
      return state.copyWith(status: ImageUploadStatus.error);

    });

  }

  _onStartImageUploadApi(OnRequestApiCall event,
      Emitter<ImageUploadState> emitter) async {


    Stream<UploadImageUseCaseResponse> stream =
    await imageUploadUseCase.buildUseCaseStream(event.token,
        event.params);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ImageUploadStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ImageUploadStatus.error);
      } else if (responseData is api_response.Success) {
        add(OnUpdateOnBoardingUserEvent());
        return state.copyWith(status: ImageUploadStatus.loading);
      } else {
        return state.copyWith(status: ImageUploadStatus.error);
      }
    });
  }


  _onStartImageUpload(OnImageUploadRequested event,
      Emitter<ImageUploadState> emitter) async {

    emitter(state.copyWith(
        status: ImageUploadStatus.loading));

    await emitter.forEach(getAuthStateStreamUseCase.call(), onData: (response) {
      return response.fold(
          ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: ImageUploadStatus.error);

            } else {
              return state.copyWith(status: ImageUploadStatus.error);

            }
          },
          ifRight: (r) {

            if(r.userAndToken?.token != null && r.userAndToken?.id != null)  {
              add(OnRequestApiCall(getFilesForUpload(event.params),
                  r.userAndToken!.token,
                  r.userAndToken!.id)
              );
              return state.copyWith(status: ImageUploadStatus.loading);

            }else {
              return state.copyWith(status: ImageUploadStatus.error);
            }

          }
      );
    },
    );

  }

  List<MultipartFile> getFilesForUpload(List<ImageFile> images) {
    List<MultipartFile> listFiles = [];
    for (var element in images) {
      var value = (lookupMimeType(element.path??"")??"image/png").split("/");

      listFiles.add(
          MultipartFile.fromBytes(
            "",
            element.bytes??[],
            filename: element.name,
            contentType: MediaType(value.first, value.last),
          )
      );
    }

    return listFiles;

  }


// This function is called whenever the text field changes


}
