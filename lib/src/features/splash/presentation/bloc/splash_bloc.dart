import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/splash_params.dart';
import '../../domain/usecases/splash_usecase.dart';
part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashUseCase splashUseCase;

  // List of splash

  SplashBloc({required this.splashUseCase})
      : super(SplashState()) {
    on<onAuthenticatedUserEvent>(_onGettingSplashEvent);
  }

// Getting splash event
  _onGettingSplashEvent(
      onAuthenticatedUserEvent event, Emitter<SplashState> emitter) async {

    final result = await splashUseCase.call(
      SplashParams(
        period: 1,
      ),
    );
    result.fold((l) {
      if (l is CancelTokenFailure) {
        emitter(SplashState().copyWith(status: SplashStatus.error));
      } else {
        emitter(SplashState().copyWith(status: SplashStatus.error));
      }
    }, (r) {
      // Return list of splash with filtered by search text
      emitter(SplashState().copyWith(status: SplashStatus.loaded));

    });
  }


  // This function is called whenever the text field changes

}
