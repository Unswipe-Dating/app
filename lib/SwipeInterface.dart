import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Profile.dart';
import 'SwipeCard.dart';

class SwipeInterface extends StatefulWidget {
  const SwipeInterface({super.key});

  @override
  State<StatefulWidget> createState() => _SwipeInterfaceState();
}

class _SwipeInterfaceState extends State<SwipeInterface> {
  late List<Profile> profiles;

  int stackCounter = 0;
  double swipeThreshold = 100.0;

  loadJsonData() async {
    String jsonData = await rootBundle.loadString('assets/json/profiles.json');
    setState(() {
      profiles = json
          .decode(jsonData)
          .map<Profile>((dataPoint) => Profile.fromJson(dataPoint))
          .toList();
    });
  }

  _SwipeInterfaceState() {
    loadJsonData();
  }

  void evaluateSwipe(dx) {            
    if (dx > swipeThreshold) {
      likeProfile();
    } else if (dx < -swipeThreshold) {
      doNotLikeProfile();
    }
  }

  void likeProfile() {
    // do some magic
    increaseStackCounter();
  }

  void doNotLikeProfile() {
    // do some other magic
    increaseStackCounter();
  }

  void increaseStackCounter() {
    setState(() {
      stackCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Draggable(
          onDragEnd: (details) => evaluateSwipe(details.offset.dx),
          feedback: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: SwipeCard(
              id: profiles[stackCounter].id,
              userName: profiles[stackCounter].userName,
              userAge: profiles[stackCounter].userAge,
              userDescription: profiles[stackCounter].userDescription,
              profileImageSrc: profiles[stackCounter].profileImageSrc,
              isVerified: profiles[stackCounter].isVerified,
              pronouns: profiles[stackCounter].pronouns,
            ),
          ),
          childWhenDragging: SwipeCard(
            id: profiles[stackCounter + 1].id,
            userName: profiles[stackCounter + 1].userName,
            userAge: profiles[stackCounter + 1].userAge,
            userDescription: profiles[stackCounter + 1].userDescription,
            profileImageSrc: profiles[stackCounter + 1].profileImageSrc,
            isVerified: profiles[stackCounter + 1].isVerified,
            pronouns: profiles[stackCounter+1].pronouns,

          ),
          child: SwipeCard(
            id: profiles[stackCounter].id,
            userName: profiles[stackCounter].userName,
            userAge: profiles[stackCounter].userAge,
            userDescription: profiles[stackCounter].userDescription,
            profileImageSrc: profiles[stackCounter].profileImageSrc,
            isVerified: profiles[stackCounter].isVerified,
            pronouns: profiles[stackCounter].pronouns,
          ),
        ),
      ),
    );
  }
}