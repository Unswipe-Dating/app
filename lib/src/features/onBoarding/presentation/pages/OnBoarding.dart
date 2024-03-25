import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/src/core/utils/injections.dart';
import 'package:unswipe/src/features/onBoarding/presentation/bloc/onboarding_bloc.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import 'package:unswipe/widgets/onBoarding/dot_inidcator.dart';

import '../widgets/on_board_content.dart';

// OnBoarding content Model
class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

// OnBoarding content list
final List<OnBoard> demoData = [
  OnBoard(
    image: "assets/images/onboarding_1.svg",
    title: "Run by you, for you",
    description:
        "This is a community led dating app that rewards responsible dating.",
  ),
  OnBoard(
    image: "assets/images/onboarding_2.svg",
    title: "Verified by default",
    description:
        "If the profile is not verified, the profile is not displayed. Period.",
  ),
  OnBoard(
    image: "assets/images/onboarding_3.svg",
    title: "Go Exclusive ",
    description: "We encourage one match at a time . No parallel conversations",
  ),
  OnBoard(
    image: "assets/images/onboarding_4.svg",
    title: "Found the one?",
    description: "Signal your interest by giving up swiping on other profiles.",
  ),
];

// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Variables
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) =>   OnBoardingBloc(
      updateOnboardingStateStreamUseCase: sl<UpdateOnboardingStateStreamUseCase>()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<OnBoardingBloc, OnBoardState>(
            listener: (context, state) {
              if (state.status == OnBoardStatus.loaded) {
                if (!state.isFirstTime) {
                  context.pushReplacementNamed('login');
                }
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  // Carousel area
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemCount: demoData.length,
                      controller: _pageController,
                      itemBuilder: (context, index) => OnBoardContent(
                        title: demoData[index].title,
                        description: demoData[index].description,
                        image: demoData[index].image,
                      ),
                    ),
                  ),
                  // Indicator area
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          demoData.length,
                              (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: DotIndicator(
                              isActive: index == _pageIndex,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Privacy policy area
                  // White space
                  const SizedBox(
                    height: 16,
                  ),
                  // Button area
                  InkWell(
                    onTap: () async {
                       context.read<OnBoardingBloc>().add(onUpdateOnBoardingUserEvent());


                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 48),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: const Center(
                        child: Text(
                          "Login / Registration",
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// OnBoarding area widget

