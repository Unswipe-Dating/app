import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unswipe/src/core/utils/injections.dart';
import 'package:unswipe/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/get_onboarding_state_stream_use_case.dart';
import 'package:unswipe/viewmodels/auth_view_model.dart';
import 'package:unswipe/widgets/onBoarding/dot_inidcator.dart';

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
  Timer? _timer;
  final SplashBloc _bloc = SplashBloc(
  splashUseCase: sl<GetAuthStateStreamUseCase>(),
  onboardingStateStreamUseCase: sl<GetOnboardingStateStreamUseCase>());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => _bloc,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state.status == SplashStatus.loaded) {
                if (!state.isFirstTime) {
                  context.goNamed('login');
                }
              }
            },
            child: Column(
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
                  onTap: () {
                  //  _bloc.add(event)


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
            ),
          ),
        ),
      ),
    );
  }
}

// OnBoarding area widget
class OnBoardContent extends StatefulWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  @override
  State<OnBoardContent> createState() => _OnBoardContentState();
}

class _OnBoardContentState extends State<OnBoardContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(widget.image),
        const Spacer(),
        const Spacer(),
        Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Playfair',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          widget.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Lato',
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
