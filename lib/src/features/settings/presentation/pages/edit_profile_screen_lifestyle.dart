import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/settings/domain/usecases/get_settings_profile_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/drink_update_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/exercise_update_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/food_update_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/gender_picker_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/household_update_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/interest_picker_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/partner_gender_picker_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/pronoun_picker_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/smoke_update_screen.dart';
import 'package:unswipe/src/features/userProfile/data/model/get_profile/response_profile_swipe.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/interests_card.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/shared/presentation/widgets/RichTextWithLoader.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/router/app_router.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';

class EditProfileScreenLifestyle extends StatefulWidget {
  const EditProfileScreenLifestyle({super.key});

  @override
  State<EditProfileScreenLifestyle> createState() =>
      _EditProfileScreenLifestyleState();
}

class _EditProfileScreenLifestyleState
    extends State<EditProfileScreenLifestyle> {
  late FToast fToast;

  bool isButtonEnabled = false;
  bool isButtonLoading = false;
  ResponseProfileLifeStyle? lifestyle;
  bool isLoadingValues = true;
  ResponseProfileList? profile;


  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 4.0,
        title: const Text(
          "Lifestyle",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Playfair',
              fontWeight: FontWeight.w600,
              fontSize: 24.0),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/permission_bg.png',
              ),
              fit: BoxFit.fill,
            )),
        child: BlocProvider(
            create: (BuildContext context) =>
            UpdateProfileBloc(
                updateOnboardingStateStreamUseCase:
                GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
                getAuthStateStreamUseCase:
                GetIt.I.get<GetAuthStateStreamUseCase>(),
                updateProfileUseCase: GetIt.I.get<UpdateProfileUseCase>(),
                createProfileUseCase: GetIt.I.get<CreateProfileUseCase>(),
                updateUserStateStreamUseCase:
                GetIt.I.get<UpdateUserStateStreamUseCase>(),
                getSettingsProfileUseCase:
                GetIt.I.get<GetSettingsProfileUseCase>())
              ..add(OnStartGettingProfile()),
            child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
              listener: (context, state) {
                if (state.status == UpdateProfileStatus.loaded
                    || state.status == UpdateProfileStatus.error
                    || state.status == UpdateProfileStatus.errorTimeOut) {
                  isButtonLoading = false;
                  isButtonEnabled = true;
                  fToast.showToast(
                    toastDuration: Duration(milliseconds: 5000),
                    child: Material(
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.face),
                          Text(
                            "Press and hold to send Alert!",
                            style: TextStyle(color: Colors.black87, fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    gravity: ToastGravity.CENTER,
                  );
                } else if (state.status == UpdateProfileStatus.loadedSave) {
                  isButtonLoading = false;
                  isButtonEnabled = true;

                } else if (state.status == UpdateProfileStatus.errorAuth) {
                  CustomNavigationHelper.router.go(
                    CustomNavigationHelper.loginPath,
                  );
                } else if (state.status == UpdateProfileStatus.loadedProfile) {
                  profile = state.responseProfileList;
                  lifestyle = profile?.lifestyle ??
                      ResponseProfileLifeStyle(null, null, null, null, null);
                  isLoadingValues = false;
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
                            'Unveil your lifestyle',
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
                            "Habits maketh a man",
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
                                    InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(Icons.male,
                                                        size: 14),
                                                  ),
                                                  const WidgetSpan(
                                                      child: SizedBox(
                                                        width: 8,
                                                      )),
                                                  TextSpan(
                                                    text: "Drink ",
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichTextWithLoader(
                                                text: lifestyle?.drink ?? "Add",
                                                isLoading: isLoadingValues),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final drink = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DrinkUpdateScreen(
                                                        toShowLoader: false,
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                            UpdateProfileParams(),
                                                            profileParams:
                                                            profile))));
                                        if (drink != null) {
                                          lifestyle?.drink = drink;
                                          isButtonEnabled = true;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(
                                                        Icons.how_to_reg,
                                                        size: 14),
                                                  ),
                                                  const WidgetSpan(
                                                      child: SizedBox(
                                                        width: 8,
                                                      )),
                                                  TextSpan(
                                                    text: "Smoke ",
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichTextWithLoader(
                                                text: lifestyle?.smoke ?? "Add",
                                                isLoading: isLoadingValues),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final smoke = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SmokeUpdateScreen(
                                                        toShowLoader: false,
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                            UpdateProfileParams(),
                                                            profileParams: profile))));
                                        if (smoke != null) {
                                          lifestyle?.smoke = smoke;
                                          isButtonEnabled = true;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
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
                                                    text: "Exercise ",
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichTextWithLoader(
                                                text: lifestyle?.exercise ??
                                                    "Add",
                                                isLoading: isLoadingValues),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final exercise = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ExerciseUpdateScreen(
                                                        toShowLoader: false,
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                            UpdateProfileParams(),
                                                            profileParams: profile))));
                                        if (exercise != null) {
                                          lifestyle?.exercise = exercise;
                                          isButtonEnabled = true;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(Icons.sunny,
                                                        size: 14),
                                                  ),
                                                  const WidgetSpan(
                                                      child: SizedBox(
                                                        width: 8,
                                                      )),
                                                  TextSpan(
                                                    text: "Cook ",
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichTextWithLoader(
                                                text: lifestyle?.cook ?? "Add",
                                                isLoading: isLoadingValues),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final cook = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CookUpdateScreen(
                                                        toShowLoader: false,
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                            UpdateProfileParams(),
                                                            profileParams: profile))));
                                        if (cook != null) {
                                          lifestyle?.cook = cook;
                                          isButtonEnabled = true;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(Icons.home,
                                                        size: 14),
                                                  ),
                                                  const WidgetSpan(
                                                      child: SizedBox(
                                                        width: 8,
                                                      )),
                                                  TextSpan(
                                                    text: "Household chores ",
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichTextWithLoader(
                                                text: lifestyle
                                                    ?.householdChores ?? "Add",
                                                isLoading: isLoadingValues),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final household = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HouseholdUpdateScreen(
                                                        toShowLoader: false,
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                            UpdateProfileParams(),
                                                            profileParams: profile))));
                                        if (household != null) {
                                          lifestyle?.householdChores = household;
                                          isButtonEnabled = true;
                                          setState(() {});
                                        }
                                      },
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
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  isButtonEnabled = false;
                                  isButtonLoading = true;
                                });
                                profile?.lifestyle = lifestyle;
                                context.read<UpdateProfileBloc>()
                                    .add(OnRequestApiCallUpdate(
                                    UpdateProfileParams
                                        .getUpdatedParamsFromProfile(profile)
                                )
                                );
                              },
                              text: 'Save',
                              isEnabled: isButtonEnabled,
                              isLoading: isButtonLoading,
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

