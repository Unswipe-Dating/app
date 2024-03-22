import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/splash_params.dart';
import '../../domain/usecases/splash_usecase.dart';
part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetAuthStateStreamUseCase splashUseCase;

  // List of splash

  SplashBloc({required this.splashUseCase})
      : super(SplashState()) {
    on<onAuthenticatedUserEvent>(_onGettingSplashEvent);
  }

// Getting splash event
  _onGettingSplashEvent(
      onAuthenticatedUserEvent event, Emitter<SplashState> emitter) async {

    splashUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        } else {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        }
      },
          ifRight: (r) {
            emitter(SplashState().copyWith(status: SplashStatus.loaded));
          });
    });
  }

// This function is called whenever the text field changes

}
