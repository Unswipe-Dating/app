import 'package:bloc/bloc.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/splash_params.dart';
import '../../domain/usecases/splash_usecase.dart';
part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashUseCase splashUseCase;

  // List of splash

  SplashBloc({required this.splashUseCase})
      : super(LoadingGetSplashState()) {
    on<OnGettingSplashEvent>(_onGettingSplashEvent);
  }

// Getting splash event
  _onGettingSplashEvent(
      OnGettingSplashEvent event, Emitter<SplashState> emitter) async {
    if (event.withLoading) {
      emitter(LoadingGetSplashState());
    }

    final result = await splashUseCase.call(
      SplashParams(
        period: event.period,
      ),
    );
    result.fold((l) {
      if (l is CancelTokenFailure) {
        emitter(LoadingGetSplashState());
      } else {
        emitter(ErrorGetSplashState(l.errorMessage));
      }
    }, (r) {
      // Return list of splash with filtered by search text
      emitter(SuccessGetSplashState());
    });
  }


  // This function is called whenever the text field changes

}
