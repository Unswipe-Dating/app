import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/userOnboarding/domain/usecases/block_contact_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/domain/usecases/create_user_use_case.dart';

import '../../../domain/usecases/upload_images_use_case.dart';



part 'contact_block_event.dart';
part 'contact_block_state.dart';


class ContactBloc extends Bloc<ContactBlockEvent, ContactBlockState> {

  final BlockContactUseCase blockContactUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final CreateUserUseCase createUserUseCase;


  // final
  // List of splash
  late StreamSubscription _subscription;

  ContactBloc({
    required this.blockContactUseCase,
    required this.uploadImageUseCase,
    required this.createUserUseCase

  })
      : super(const ContactBlockState()) {






  }


  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


// This function is called whenever the text field changes


}
