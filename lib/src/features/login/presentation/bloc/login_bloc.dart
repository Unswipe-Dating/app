import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/usecases/update_login_state_stream_usecase.dart';


part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LogInEvent, LoginState> {
  final UpdateUserStateStreamUseCase updateUserStateStreamUseCase;

  // List of splash
  late StreamSubscription _subscription;

  LoginBloc({
    required this.updateUserStateStreamUseCase
  })
      : super(LoginState()) {
    on<onLoginSuccess>(_onLoginSuccess);

  }

  _onLoginSuccess(onLoginSuccess event,
      Emitter<LoginState> emitter) async{

    _subscription = updateUserStateStreamUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(state.copyWith(status: LoginStatus.error));
        } else {
          emitter(state.copyWith(status: LoginStatus.error));
        }
      },
          ifRight: (r) {
              emitter(state.copyWith(
                  status: LoginStatus.loaded,
                  token: "token"
              ));

           });
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


// This function is called whenever the text field changes

}
