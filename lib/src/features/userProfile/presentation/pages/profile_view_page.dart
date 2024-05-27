import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/chat/no_request_screen.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_create_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_reject_usecase.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/SwipeCard.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../data/model/get_profile/response_profile_swipe.dart';
import '../../domain/usecase/profile_accept_usecase.dart';
import '../../domain/usecase/profile_get_requested_usecase.dart';
import '../../domain/usecase/profile_get_usecase.dart';
import '../bloc/profile_swipe_bloc.dart';
import '../bloc/profile_swipe_state.dart';

class SwipeInterface extends StatefulWidget {
  const SwipeInterface({
    Key? key,
  }) : super(key: key);

  @override
  State<SwipeInterface> createState() => _SwipeInterfaceState();
}

class _SwipeInterfaceState extends State<SwipeInterface> {
  List<SwipeCard> cards = [];
  final CardSwiperController controller = CardSwiperController();

  String imageUri= "";


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileSwipeBloc(
          profileSwipeUseCase: GetIt.I.get<ProfileGetUseCase>(),
          getAuthStateStreamUseCase: GetIt.I.get<GetAuthStateStreamUseCase>(),
        profileAcceptUseCase: GetIt.I.get<ProfileAcceptUseCase>(),
        profileCreateUseCase: GetIt.I.get<ProfileCreateUseCase>(),
        profileRejectUseCase: GetIt.I.get<ProfileRejectUseCase>(),
        profileGetRequestedUseCase: GetIt.I.get<ProfileGetRequestedUseCase>(),

      )
        ..add(OnInitiateSubjects())
        ..add(OnInitiateAcceptSubject())
        ..add(OnInitiateCreateSubject())
        ..add(OnInitiateRejectSubject())
        ..add(OnInitiateMatchSubject())
        ..add(OnProfileSwipeRequested(0)),
      child: BlocConsumer<ProfileSwipeBloc, ProfileSwipeState>(
        listener: (context, state) {
          if (state.status == ProfileSwipeStatus.loaded) {

          } else if (state.status == ProfileSwipeStatus.loadedCreate) {
            CustomNavigationHelper.router
                .push(CustomNavigationHelper.profilePathHyperEx, extra: imageUri );

          }else if (state.status == ProfileSwipeStatus.loadedReject) {

          }else if (state.status == ProfileSwipeStatus.errorSwipe) {
            controller.undo();
          }

        },
        builder: (context, state) {
          switch (state.status) {
            case ProfileSwipeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ProfileSwipeStatus.loaded:
            case ProfileSwipeStatus.loadedReject:
              if (state.responseProfileSwipe != null) {
                if(state.responseProfileSwipe?.browseProfiles?.profiles.isNotEmpty == true) {
                  updateProfiles(state.responseProfileSwipe!);
                  return CardSwiper(
                    allowedSwipeDirection: const AllowedSwipeDirection.only(
                        up: false, down: false, left: false, right: false),
                    threshold: 100,
                    controller: controller,
                    cardsCount: cards.length,
                    onSwipe: _onSwipe,
                    onUndo: _onUndo,
                    isLoop: false,
                    onEnd: (){
                      context.read<ProfileSwipeBloc>().add(OnRequestApiCall("", ""));
                        },
                    numberOfCardsDisplayed: cards.length > 1 ? 2 : 1,
                    padding: const EdgeInsets.all(0.0),
                    cardBuilder: (context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,) =>
                    cards[index],
                  );
                } else {
                  return NoRequestScreen();
                }
              } else
                return const Center(child: CircularProgressIndicator());
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void swipeRightMethod() {
    controller.swipe(CardSwiperDirection.right);

  }

  void swipeLeftMethod() {
    controller.swipe(CardSwiperDirection.left);
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }

  void updateProfiles(ResponseProfileSwipe responseProfileSwipe) {
     cards = responseProfileSwipe.browseProfiles!.profiles.map((profile) => SwipeCard(
      likeAction: swipeRightMethod,
      dislikeAction: swipeLeftMethod,
      id: profile.id,
      userName: profile.name,
      userAge: 20,
      userDescription: "no desc",
      profileImageSrc: "",
      isVerified: true,
      pronouns: "",
      isCreate: true,
    )).toList();

  }
}
