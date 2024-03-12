import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:unswipe/widgets/homePage/swipeView/SwipeCard.dart';

import '../../Profile.dart';

class SwipeInterface extends StatefulWidget {
  const SwipeInterface({
    Key? key,
  }) : super(key: key);

  @override
  State<SwipeInterface> createState() => _SwipeInterfaceState();
}

class _SwipeInterfaceState extends State<SwipeInterface> {
  late List<Profile> profiles;
  late List<SwipeCard> cards;
  final CardSwiperController controller = CardSwiperController();

  loadJsonData() async {
    String jsonData = await rootBundle.loadString('assets/json/profiles.json');
    setState(() {
      profiles = json
          .decode(jsonData)
          .map<Profile>((dataPoint) => Profile.fromJson(dataPoint))
          .toList();
      cards = profiles
          .map((profile) => SwipeCard(
                likeAction: swipeRightMethod,
                dislikeAction: swipeLeftMethod,
                id: profile.id,
                userName: profile.userName,
                userAge: profile.userAge,
                userDescription: profile.userDescription,
                profileImageSrc: profile.profileImageSrc,
                isVerified: profile.isVerified,
                pronouns: profile.pronouns,
              ))
          .toList();
    });
  }

  _SwipeInterfaceState() {
    loadJsonData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CardSwiper(
        allowedSwipeDirection: const AllowedSwipeDirection.only(
            up: false, down: false, left: true, right: false),
        threshold: 100,
        controller: controller,
        cardsCount: profiles.length,
        onSwipe: _onSwipe,
        onUndo: _onUndo,
        numberOfCardsDisplayed: 2,
        padding: const EdgeInsets.all(10.0),
        cardBuilder: (
          context,
          index,
          horizontalThresholdPercentage,
          verticalThresholdPercentage,
        ) =>
            cards[index],
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
    if (currentIndex!=null) cards[currentIndex].resetToZero();
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
}
