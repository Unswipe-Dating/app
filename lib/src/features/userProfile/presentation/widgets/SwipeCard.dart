import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_get_usecase.dart';
import 'package:unswipe/src/features/userProfile/presentation/bloc/profile_swipe_bloc.dart';
import 'package:unswipe/src/features/userProfile/presentation/bloc/profile_swipe_state.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/date_preference_card.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/interests_card.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/prompt_card.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/swipe_image_card.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/work_card.dart';

import '../../../../core/router/app_router.dart';
import '../../../../../widgets/utils.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';

class SwipeCard extends StatefulWidget {
  final String id;
  final String userName;
  final int userAge;
  final String userDescription;
  final String profileImageSrc;
  final bool isVerified;
  final Function likeAction;
  final Function dislikeAction;
  final String pronouns;
  final bool isCreate;

  const SwipeCard({
    Key? key,
    required this.likeAction,
    required this.dislikeAction,
    required this.id,
    required this.userName,
    required this.userAge,
    required this.userDescription,
    required this.profileImageSrc,
    required this.isVerified,
    required this.pronouns,
    required this.isCreate,
  }) : super(key: key);

  @override
  State<SwipeCard> createState() => _SwipeCard();
}

class _SwipeCard extends State<SwipeCard> {
  ScrollController controller = ScrollController();
  static const imageUrls = [
    "https://images.pexels.com/photos/220453/"
        "pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/220453/"
        "pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/220453/"
        "pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.only(
                      left: 0, top: 0, right: 0, bottom: 0),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: controller,
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
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SwipeImageGallery(
                                        imageUrls: imageUrls,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text:
                                                    "${widget.userName.characters.first} , ",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Playfair',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 24.0),
                                                children: [
                                                  TextSpan(
                                                      text: widget.userAge
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Lato',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18))
                                                ]),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Icon(
                                            Icons.verified,
                                            color: widget.isVerified
                                                ? Colors.green
                                                : Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 84,
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
                              const InterestsCard(
                                  header: "Interests",
                                  chipLabels: [
                                    "Outdoor",
                                    "run",
                                    "journal",
                                    "chinese",
                                    "Football"
                                  ]),
                              const SizedBox(
                                height: 16,
                              ),
                              const PromptCard(
                                  color: 0xffCBDFFF,
                                  question:
                                      "We have the Prompt question displayed here",
                                  answer:
                                      "Let’s say we have a 300 character limit for the prompt"
                                      " answers. This is how it would look."),
                              const SizedBox(
                                height: 16,
                              ),
                              const InterestsCard(
                                  header: "Languages",
                                  chipLabels: ["English", "Hindi"]),
                              const SizedBox(
                                height: 16,
                              ),
                              const PromptCard(
                                  color: 0xffFFD9D9,
                                  question:
                                      "We have the Prompt question displayed here",
                                  answer:
                                      "Let’s say we have a 300 character limit for the prompt "
                                      "answers. This is how it would look."),
                              const SizedBox(
                                height: 16,
                              ),
                              const WorkCard(),
                              const SizedBox(
                                height: 16,
                              ),
                              const PromptCard(
                                  color: 0xffFFD9D9,
                                  question:
                                      "We have the Prompt question displayed here",
                                  answer:
                                      "Let’s say we have a 300 character limit for the prompt"
                                      " answers. This is how it would look. Let’s say we "
                                      "have a 300 character limit for the prompt answers. "
                                      "This is how it would look.Let’s say we have a 300 "
                                      "character limit for the prompt answers."
                                      " This is how it would look."),
                              const SizedBox(
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
                              const PromptCard(
                                  color: 0xffFFDEC6,
                                  question:
                                      "We have the Prompt question displayed here",
                                  answer:
                                      "Let’s say we have a 300 character limit for the prompt"
                                      " answers. This is how it would look."),
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
                            left: 8.0, top: 0.0, right: 8.0, bottom: 42.0),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                    heroTag: null,
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      widget.dislikeAction();
                                      if(widget.isCreate) {
                                        context.read<ProfileSwipeBloc>().add(OnSkipRequest(widget.id));
                                      } else {
                                        context.read<ProfileSwipeBloc>().add(OnRejectRequest(widget.id));
                                      }

                                      controller.jumpTo(0);
                                    },
                                    backgroundColor: Colors.black,
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  width: 8,
                                ),
                                FloatingActionButton(
                                    heroTag: null,
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      showConfirmationDialog(
                                        context,
                                        message,
                                        onAccept: handleAccept,
                                        onReject: handleReject,
                                      );
                                    },
                                    backgroundColor: Colors.grey[200],
                                    child: const ImageIcon(
                                      AssetImage(
                                          "assets/images/locked_heart.png"),
                                      color: Colors.black,
                                    )),
                              ],
                            )),
                      ),
                    ],
                  ),
                );

  }

  String message = "Are you sure you want to proceed?";

  void handleAccept() {
    widget.likeAction();
    if(widget.isCreate) {
      context.read<ProfileSwipeBloc>().add(OnCreateRequest(widget.id));
    } else {
      context.read<ProfileSwipeBloc>().add(OnAcceptRequest(widget.id));

    }

  }

  void handleReject() {

  }
}
