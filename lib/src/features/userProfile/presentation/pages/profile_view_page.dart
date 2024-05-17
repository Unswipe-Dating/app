import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/userProfile/data/model/response_profile_swipe.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/SwipeCard.dart';

import '../../../../../Profile.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../domain/usecase/profile_swap_usecase.dart';
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
  late List<SwipeCard> cards;
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
          profileSwipeUseCase: GetIt.I.get<ProfileSwipeUseCase>(),
          getAuthStateStreamUseCase: GetIt.I.get<GetAuthStateStreamUseCase>())
        ..add(OnProfileSwipeRequested()),
      child: BlocConsumer<ProfileSwipeBloc, ProfileSwipeState>(
        listener: (context, state) {
          if (state.status == ProfileSwipeStatus.loaded) {

          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ProfileSwipeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ProfileSwipeStatus.loaded:
              if (state.responseProfileSwipe != null) {
                updateProfiles(state.responseProfileSwipe!);
                return CardSwiper(
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                      up: false, down: false, left: false, right: false),
                  threshold: 100,
                  controller: controller,
                  cardsCount: cards.length,
                  onSwipe: _onSwipe,
                  onUndo: _onUndo,
                  numberOfCardsDisplayed: cards.length > 1 ? 2: 1,
                  padding: const EdgeInsets.all(0.0),
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) =>
                      cards[index],
                );
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

    cards = responseProfileSwipe.browseProfiles.profiles.map((profile) => SwipeCard(
      likeAction: swipeRightMethod,
      dislikeAction: swipeLeftMethod,
      id: profile.id,
      userName: profile.name,
      userAge: 20,
      userDescription: "no desc",
      profileImageSrc: "",
      isVerified: true,
      pronouns: "",
    )).toList();

  }
}
