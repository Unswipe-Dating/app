import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_create_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_get_requested_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_reject_usecase.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/SwipeCard.dart';

import '../../data/model/profile.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../chat/no_request_screen.dart';
import '../../data/model/get_profile/response_profile_swipe.dart';
import '../../domain/usecase/profile_accept_usecase.dart';
import '../../domain/usecase/profile_get_usecase.dart';
import '../../domain/usecase/profile_skip_usecase.dart';
import '../bloc/profile_swipe_bloc.dart';
import '../bloc/profile_swipe_state.dart';

class MatchedSwipeInterface extends StatefulWidget {
  const MatchedSwipeInterface({
    Key? key,
  }) : super(key: key);

  @override
  State<MatchedSwipeInterface> createState() => _MatchedSwipeInterfaceState();
}

class _MatchedSwipeInterfaceState extends State<MatchedSwipeInterface> {
  List<SwipeCard> cards = [];
  final CardSwiperController controller = CardSwiperController();

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
          profileSkipUseCase: GetIt.I.get<ProfileSkipUseCase>(),
          updateOnboardingStateStreamUseCase:
              GetIt.I.get<UpdateOnboardingStateStreamUseCase>())
        ..add(OnInitiateSubjects())
        ..add(OnInitiateAcceptSubject())
        ..add(OnInitiateCreateSubject())
        ..add(OnInitiateRejectSubject())
        ..add(OnInitiateMatchSubject())
        ..add(OnInitiateSkipSubject())
        ..add(OnProfileSwipeRequested(1)),
      child: BlocConsumer<ProfileSwipeBloc, ProfileSwipeState>(
        listener: (context, state) {
          if (state.status == ProfileSwipeStatus.loaded) {
          } else if (state.status == ProfileSwipeStatus.loadedChat) {
            CustomNavigationHelper.router
                .go(CustomNavigationHelper.startChatPath, extra: state.chatParams);
          }
          else if (state.status == ProfileSwipeStatus.errorAuth) {
            CustomNavigationHelper.router.go(
              CustomNavigationHelper.loginPath,
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ProfileSwipeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ProfileSwipeStatus.loaded:
            case ProfileSwipeStatus.loadedReject:
            case ProfileSwipeStatus.loadedSkip:
              if (state.responseProfileSwipe != null) {
                if (state.responseProfileSwipe?.getRequestedProfilesForUser
                        ?.isNotEmpty ==
                    true) {
                  updateProfiles(state.responseProfileSwipe!);
                  return CardSwiper(
                    allowedSwipeDirection: const AllowedSwipeDirection.only(
                        up: false, down: false, left: false, right: false),
                    threshold: 100,
                    controller: controller,
                    cardsCount: cards.length,
                    onSwipe: _onSwipe,
                    onUndo: _onUndo,
                    numberOfCardsDisplayed: cards.length > 1 ? 2 : 1,
                    padding: const EdgeInsets.all(0.0),
                    cardBuilder: (
                      context,
                      index,
                      horizontalThresholdPercentage,
                      verticalThresholdPercentage,
                    ) =>
                        cards[index],
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProfileSwipeBloc>().add(OnGetRequestedProfile());
                    },
                    child: const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: NoRequestScreen(),
                    ),
                  );
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
    if(cards.isNotEmpty) {
      cards.removeAt(0);
    }
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
    if (cards.isEmpty) {
      cards = responseProfileSwipe.getRequestedProfilesForUser!
          .map((profile) => SwipeCard(
                likeAction: swipeRightMethod,
                dislikeAction: swipeLeftMethod,
                id: profile.id,
                userName: profile.name,
                userAge: 20,
                userDescription: "no desc",
                profileImageSrc: profile.photoURLs,
                isVerified: true,
                showTruncatedName: profile.showTruncatedName ?? false,
                pronouns: profile.pronouns ?? "",
                interests: profile.interests,
                languages: profile.languages,
                datePreference: profile.datingPreference,
                isCreate: false,
                requestId: profile.request?.id,
              ))
          .toList();
    }
  }
}
