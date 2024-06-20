import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/settings/domain/usecases/get_settings_profile_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart';
import 'package:unswipe/src/features/userProfile/data/model/get_profile/response_profile_swipe.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/interests_card.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../core/router/app_router.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';

class EditProfileScreenBasic extends StatefulWidget {
  final UpdateProfileParams? params;
  final ResponseProfileList? profile;

  const EditProfileScreenBasic({super.key, this.params, this.profile});

  @override
  State<EditProfileScreenBasic> createState() => _EditProfileScreenBasicState();
}

class _EditProfileScreenBasicState extends State<EditProfileScreenBasic> {
  bool isButtonEnabled = true;

  List<String> interestString = [];

  @override
  void initState() {
    super.initState();
    interestString =
        (widget.profile?.interests.weekendActivities ?? [] as List<String>) +
            (widget.profile?.interests.sports ?? [] as List<String>) +
            (widget.profile?.interests.selfCare ?? [] as List<String>) +
            (widget.profile?.interests.pets ?? [] as List<String>) +
            (widget.profile?.interests.fnd ?? [] as List<String>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 16.0,
        title: const Text(
          "Basics",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Playfair',
              fontWeight: FontWeight.w600,
              fontSize: 24.0),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/images/permission_bg.png',
          ),
          fit: BoxFit.fill,
        )),
        child: BlocProvider(
            create: (BuildContext context) => UpdateProfileBloc(
                updateOnboardingStateStreamUseCase:
                    GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
                getAuthStateStreamUseCase:
                    GetIt.I.get<GetAuthStateStreamUseCase>(),
                updateProfileUseCase: GetIt.I.get<UpdateProfileUseCase>(),
                createProfileUseCase: GetIt.I.get<CreateProfileUseCase>(),
                updateUserStateStreamUseCase:
                    GetIt.I.get<UpdateUserStateStreamUseCase>(),
                getSettingsProfileUseCase:
                    GetIt.I.get<GetSettingsProfileUseCase>()),
            child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
              listener: (context, state) {
                if (state.status == UpdateProfileStatus.loaded) {
                  CustomNavigationHelper.router.go(
                    CustomNavigationHelper.profilePath,
                  );
                } else if (state.status == UpdateProfileStatus.errorAuth) {
                  CustomNavigationHelper.router.go(
                    CustomNavigationHelper.loginPath,
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            textAlign: TextAlign.start,
                            'My Interests',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Tell us about all the things you love <3",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            child: InterestsCard(
                              header: null,
                              chipLabels: interestString,
                              elevation: 4,
                            ),
                            onTap: () {
                              CustomNavigationHelper.router.go(
                                CustomNavigationHelper.onboardingInterestPath,
                                extra: SettingProfileParams(updateParams: UpdateProfileParams(),
                                    profileParams: widget.profile)
                              );
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            textAlign: TextAlign.start,
                            'My Pronouns',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Be Unapologetically yourself",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Card(
                            elevation: 4,
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          child: Icon(Icons.person, size: 14),
                                        ),
                                        const WidgetSpan(
                                            child: SizedBox(
                                          width: 8,
                                        )),
                                        TextSpan(
                                          text: "Pronoun ",
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontFamily: 'lato',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: widget.profile?.pronouns ??
                                              "not set",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'lato',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0),
                                        ),
                                        const WidgetSpan(
                                          child: Icon(
                                              Icons.keyboard_arrow_right,
                                              size: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            textAlign: TextAlign.start,
                            'Basic Information',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Tell us more about you. Everyone is curious too",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Card(
                            elevation: 4,
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child:
                                                    Icon(Icons.male, size: 14),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 8,
                                              )),
                                              TextSpan(
                                                text: "Gender ",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.profile?.gender ??
                                                    "not set",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0),
                                              ),
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child: Icon(Icons.how_to_reg,
                                                    size: 14),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 8,
                                              )),
                                              TextSpan(
                                                text: "Prefer to date ",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.profile
                                                        ?.datingPreference ??
                                                    "not set",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0),
                                              ),
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.vertical_split,
                                                    size: 14),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 8,
                                              )),
                                              TextSpan(
                                                text: "Height ",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.profile?.height ??
                                                    "not set",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0),
                                              ),
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child:
                                                    Icon(Icons.sunny, size: 14),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 8,
                                              )),
                                              TextSpan(
                                                text: "Zodiac ",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.profile?.zodiac ??
                                                    "Add",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0),
                                              ),
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.pin_drop_outlined,
                                                    size: 14),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 8,
                                              )),
                                              TextSpan(
                                                text: "Location ",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    widget.profile?.location ??
                                                        "Add",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0),
                                              ),
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child:
                                                    Icon(Icons.home, size: 14),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 8,
                                              )),
                                              TextSpan(
                                                text: "Hometown ",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    widget.profile?.hometown ??
                                                        "Add",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'lato',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0),
                                              ),
                                              const WidgetSpan(
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            textAlign: TextAlign.start,
                            'My Languages',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "In how many languages can you place an order in a restaurant?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Card(
                            elevation: 4,
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          child: Icon(Icons.person, size: 14),
                                        ),
                                        const WidgetSpan(
                                            child: SizedBox(
                                          width: 8,
                                        )),
                                        TextSpan(
                                          text: "Languages ",
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontFamily: 'lato',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Add",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'lato',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0),
                                        ),
                                        WidgetSpan(
                                          child: Icon(
                                              Icons.keyboard_arrow_right,
                                              size: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  // Set button background color
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        2.0), // Rounded corners
                                  ),
                                  minimumSize: const Size.fromHeight(
                                      48) // Set button text color
                                  ),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            ),
                          )
                        ]),
                  ),
                );
              },
            )),
      ),
    );
  }
}

class ChipValues {
  final String val;
  bool isSelected = false;

  ChipValues(this.val);

  void setSelection(bool isSelected) {
    this.isSelected = isSelected;
  }
}
