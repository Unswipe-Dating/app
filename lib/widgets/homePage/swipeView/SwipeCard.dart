import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unswipe/widgets/homePage/expandable_fab.dart';
import 'package:unswipe/widgets/homePage/swipeView/swipeViewCards/date_preference_card.dart';
import 'package:unswipe/widgets/homePage/swipeView/swipeViewCards/interests_card.dart';
import 'package:unswipe/widgets/homePage/swipeView/swipeViewCards/photo_card_secondary.dart';
import 'package:unswipe/widgets/homePage/swipeView/swipeViewCards/prompt_card.dart';
import 'package:unswipe/widgets/homePage/swipeView/swipeViewCards/work_card.dart';

class SwipeCard extends StatelessWidget {
  final String id;
  final String userName;
  final int userAge;
  final String userDescription;
  final String profileImageSrc;
  final bool isVerified;
  final Function swipeRightAction;
  final Function swipeLeftAction;

  final String pronouns;

   final _controller = ScrollController();

   SwipeCard({
    Key? key,
    required this.swipeRightAction,
     required this.swipeLeftAction,
     required this.id,
    required this.userName,
    required this.userAge,
    required this.userDescription,
    required this.profileImageSrc,
    required this.isVerified,
    required this.pronouns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.network(
                            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "${userName.characters.first} , ",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Playfair',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24.0),
                                    children: [
                                      TextSpan(
                                          text: userAge.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18))
                                    ]),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Icon(
                                Icons.verified,
                                color: isVerified ? Colors.green : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Chip(
                              padding: const EdgeInsets.all(8),
                              side: const BorderSide(color: Colors.transparent),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              backgroundColor: Colors.grey[400],
                              label: Text(
                                pronouns,
                                style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const DatePreferenceCard(chipLabels: ["Men"]),
                  const SizedBox(
                    height: 16,
                  ),
                  const InterestsCard(header: "Interests", chipLabels: [
                    "Outdoor",
                    "run",
                    "journal",
                    "chinese",
                    "Football"
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  const PhotoCardSecondary(
                      chipLabels: ["5'4\"\"", "Capricorn"]),
                  const SizedBox(
                    height: 16,
                  ),
                  const PromptCard(
                      color: 0xffCBDFFF,
                      question: "We have the Prompt question displayed here",
                      answer:
                          "Let’s say we have a 300 character limit for the prompt answers. This is how it would look."),
                  const SizedBox(
                    height: 16,
                  ),
                  const InterestsCard(
                      header: "Languages", chipLabels: ["English", "Hindi"]),
                  const SizedBox(
                    height: 16,
                  ),
                  const PromptCard(
                      color: 0xffFFD9D9,
                      question: "We have the Prompt question displayed here",
                      answer:
                          "Let’s say we have a 300 character limit for the prompt answers. This is how it would look."),
                  const SizedBox(
                    height: 16,
                  ),
                  const WorkCard(),
                  const SizedBox(
                    height: 16,
                  ),
                  const PhotoCardSecondary(chipLabels: ["Banglore", "Assam"]),
                  SizedBox(
                    height: 16,
                  ),
                  const PromptCard(
                      color: 0xffFFD9D9,
                      question: "We have the Prompt question displayed here",
                      answer:
                          "Let’s say we have a 300 character limit for the prompt answers. This is how it would look. Let’s say we have a 300 character limit for the prompt answers. This is how it would look.Let’s say we have a 300 character limit for the prompt answers. This is how it would look."),
                  SizedBox(
                    height: 16,
                  ),
                  const InterestsCard(
                      header: "Lifestyle",
                      isFilled: false,
                      chipLabels: [
                        "Socially",
                        "Never",
                        "Active",
                        "A little",
                        "Often"
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  const PhotoCardSecondary(chipLabels: []),
                  const PromptCard(
                      color: 0xffFFDEC6,
                      question: "We have the Prompt question displayed here",
                      answer:
                          "Let’s say we have a 300 character limit for the prompt answers. This is how it would look."),
                  const SizedBox(
                    height: 16,
                  ),
                  const InterestsCard(
                      header: "Value",
                      isFilled: false,
                      chipLabels: [
                        "Christian",
                        "Apolitical",
                        "Acts of service",
                        "Want'em"
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  const PhotoCardSecondary(chipLabels: []),
                  const SizedBox(
                    height: 16,
                  ),
                  const InterestsCard(
                      header: "Core Values",
                      isFilled: true,
                      chipLabels: [
                        "Loyalty",
                        "Determination",
                        "Family",
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, top: 0.0, right: 8.0, bottom: 32.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                   FloatingActionButton(
                      shape: const CircleBorder(),
                      onPressed: () => swipeLeftAction,
                      backgroundColor: Colors.white,
                      child: const Icon(
                          Icons.close
                      )
                  ),
                  FloatingActionButton(
                      shape: CircleBorder(),
                      onPressed: () => swipeRightAction,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                          Icons.favorite,
                      )
                  ),

                  const FloatingActionButton(
                      shape: CircleBorder(),
                      onPressed: null,
                      backgroundColor: Colors.black,
                      child: Icon(
                          Icons.punch_clock,
                        color: Colors.white,
                      )
                  ),

                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  void resetToZero() {
    _controller.jumpTo(0);
  }
}
