import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';
import 'package:unswipe/src/shared/domain/entities/auth_state.dart';

import '../../../../../../data/api_response.dart' as api_response;

import '../../../../../../data/api_response.dart';
import '../../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../onBoarding/presentation/bloc/onboarding_bloc.dart';
import '../../domain/usecase/contact_bloc_usecase.dart';
part 'contact_block_state.dart';
part 'contact_block_event.dart';

class ContactBloc extends Bloc<ContactBlockEvent, ContactBlockState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final ContactBlockUseCase updateBlockedContactsUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;

  // List of splash

  ContactBloc({
    required this.updateOnboardingStateStreamUseCase,
    required this.updateBlockedContactsUseCase,
    required this.getAuthStateStreamUseCase,
  })
      : super(ContactBlockState()) {
    on<OnContactBlockRequested>(_onStartBlockContacts);
    on<OnRequestApiCall>(_onStartBlockApi);
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);


  }

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<ContactBlockState> emitter) async{

    emitter(state.copyWith(status: ContactBlockStatus.loading));

    await emitter.forEach(
        updateOnboardingStateStreamUseCase
            .call(OnBoardingStatus.images), onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: ContactBlockStatus.error);
        } else {
          return state.copyWith(status: ContactBlockStatus.error);
        }
      },
      ifRight: (r) {
        return state.copyWith(status: ContactBlockStatus.loaded);}
      );

    }, onError: (error, stacktrace) {
      return state.copyWith(status: ContactBlockStatus.error);

    });

  }

  _onStartBlockApi(OnRequestApiCall event,
      Emitter<ContactBlockState> emitter) async {


    Stream<GetBlockContactsUseCaseResponse> stream =
    await updateBlockedContactsUseCase.buildUseCaseStream(event.token,
        ContactBlockParams(data: event.params, id: event.id));

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ContactBlockStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ContactBlockStatus.error);
      } else if (responseData is api_response.Success) {
        add(OnUpdateOnBoardingUserEvent());
        return state.copyWith(status: ContactBlockStatus.loading);
      } else {
        return state.copyWith(status: ContactBlockStatus.error);
      }
    });
  }


  _onStartBlockContacts(OnContactBlockRequested event,
      Emitter<ContactBlockState> emitter) async {

     emitter(state.copyWith(
        status: ContactBlockStatus.loading));

    await emitter.forEach(getAuthStateStreamUseCase.call(), onData: (response) {
      return response.fold(
          ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: ContactBlockStatus.error);

            } else {
              return state.copyWith(status: ContactBlockStatus.error);

            }
          },
          ifRight: (r) {

            if(r.userAndToken?.token != null && r.userAndToken?.id != null)  {
              add(OnRequestApiCall(event.params,
                  r.userAndToken!.token,
                  r.userAndToken!.id)
              );
              return state.copyWith(status: ContactBlockStatus.loading);

            }else {
              return state.copyWith(status: ContactBlockStatus.error);
            }

          }
      );
    },
    );

  }


// This function is called whenever the text field changes


}
