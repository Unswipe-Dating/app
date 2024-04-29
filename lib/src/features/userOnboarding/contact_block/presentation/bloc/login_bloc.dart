import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/domain/usecases/request_otp_use_case.dart';
import 'package:unswipe/src/features/login/domain/usecases/verify_otp_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/usecases/block_contact_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/usecases/create_user_use_case.dart';

import '../../domain/usecases/upload_images_use_case.dart';


part 'login_event.dart';
part 'login_state.dart';


class OnBoardingBloc extends Bloc<LogInEvent, LoginState> {
  final BlockContactUseCase blockContactUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final CreateUserUseCase createUserUseCase;


  // final
  // List of splash
  late StreamSubscription _subscription;

  OnBoardingBloc({
    required this.blockContactUseCase,
    required this.uploadImageUseCase,
    required this.createUserUseCase

  })
      : super(const LoginState()) {






  }


  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


// This function is called whenever the text field changes


}
