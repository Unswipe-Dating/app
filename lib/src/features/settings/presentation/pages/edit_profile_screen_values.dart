import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/settings/domain/usecases/get_settings_profile_usecase.dart';
import 'package:unswipe/src/features/settings/presentation/pages/children_update_screen.dart';
import 'package:unswipe/src/features/settings/presentation/pages/core_value_screen.dart';
import 'package:unswipe/src/features/settings/presentation/pages/love_language_update_screen.dart';
import 'package:unswipe/src/features/settings/presentation/pages/political_view_update_screen.dart';
import 'package:unswipe/src/features/settings/presentation/pages/religion_update_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/gender_picker_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/interest_picker_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/partner_gender_picker_screen.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/presentation/pages/pronoun_picker_screen.dart';
import 'package:unswipe/src/features/userProfile/data/model/get_profile/response_profile_swipe.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/interests_card.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../core/router/app_router.dart';
import '../../../login/presentation/pages/Login.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';

class EditProfileScreenValue extends StatefulWidget {
  final ResponseProfileList? profile;

  const EditProfileScreenValue({super.key, this.profile});

  @override
  State<EditProfileScreenValue> createState() => _EditProfileScreenValueState();
}

class _EditProfileScreenValueState extends State<EditProfileScreenValue> {
  late FToast fToast;

  bool isButtonEnabled = false;
  bool isButtonLoading = false;
  ResponseProfileValues? values;
  bool isLoadingValues = true;
  ResponseProfileList? profile;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

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
          "Values",
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
                    GetIt.I.get<GetSettingsProfileUseCase>())
              ..add(OnStartGettingProfile()),
            child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
              listener: (context, state) {
                if (state.status == UpdateProfileStatus.loaded ||
                    state.status == UpdateProfileStatus.error ||
                    state.status == UpdateProfileStatus.errorTimeOut) {
                  isButtonLoading = false;
                  isButtonEnabled = true;
                  fToast.showToast(
                    toastDuration: const Duration(milliseconds: 5000),
                    child:  Container(

                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.face),
                          Text(
                          state.status == UpdateProfileStatus.loaded ? "Updates saved": "Some error occurred"
                          ,
                            style: TextStyle(
                                color: Colors.black87, fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    gravity: ToastGravity.BOTTOM,
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
                  values = profile?.values ?? ResponseProfileValues(null, null, null, null, null);
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
                            'My Values',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
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
                                                    text: "Religion ",
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
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: values?.religion ??
                                                        "Add",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                  ),
                                                  const WidgetSpan(
                                                    child: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        size: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final religion = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReligionUpdateScreen(
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                                UpdateProfileParams(),
                                                            profileParams: widget
                                                                .profile))));
                                        if (religion != null) {
                                          values?.religion = religion;
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
                                                    text: "Political views ",
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
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: values
                                                            ?.politicalViews ??
                                                        "Add",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                  ),
                                                  const WidgetSpan(
                                                    child: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        size: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final politicalViews = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PoliticalViewUpdateScreen(
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                                UpdateProfileParams(),
                                                            profileParams: widget
                                                                .profile))));
                                        if (politicalViews != null) {
                                          values?.politicalViews =
                                              politicalViews;
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
                                                    text: "Love language ",
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
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        values?.loveLanguage ??
                                                            "Add",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                  ),
                                                  const WidgetSpan(
                                                    child: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        size: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final loveLang = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoveLanguageUpdateScreen(
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                                UpdateProfileParams(),
                                                            profileParams: widget
                                                                .profile))));
                                        if (loveLang != null) {
                                          values?.loveLanguage = loveLang;
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
                                                    text: "Children ",
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
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: values?.children ??
                                                        "Add",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                  ),
                                                  const WidgetSpan(
                                                    child: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        size: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final children = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChildrenUpdateScreen(
                                                        params: SettingProfileParams(
                                                            updateParams:
                                                                UpdateProfileParams(),
                                                            profileParams: widget
                                                                .profile))));
                                        if (children != null) {
                                          values?.children = children;
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
                          const Text(
                            textAlign: TextAlign.start,
                            'My core values',
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
                            "These are the values you strongly hold onto",
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
                            child: Card(
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
                                            text: "Core values ",
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
                            onTap: () async {
                              final core = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CoreValuesUpdateScreen(
                                              params: SettingProfileParams(
                                                  updateParams:
                                                      UpdateProfileParams(),
                                                  profileParams:
                                                      widget.profile))));
                              if (core != null) {
                                values?.coreValues = core;
                                isButtonEnabled = true;
                                setState(() {});
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  isButtonEnabled = false;
                                  isButtonLoading = true;
                                });
                                profile?.values = values;
                                context.read<UpdateProfileBloc>().add(
                                    OnRequestApiCallUpdate(UpdateProfileParams
                                        .getUpdatedParamsFromProfile(profile)));
                              },
                              text: 'Save',
                              isEnabled: isButtonEnabled,
                              isLoading: isButtonLoading,
                            ),
                          )                        ]),
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
