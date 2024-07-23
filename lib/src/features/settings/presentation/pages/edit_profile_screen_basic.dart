import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/settings/domain/usecases/get_settings_profile_usecase.dart';
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
import 'package:unswipe/src/shared/presentation/widgets/RichTextWithLoader.dart';
import 'package:unswipe/src/shared/presentation/widgets/shimmer.dart';

import '../../../../core/router/app_router.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';

class EditProfileScreenBasic extends StatefulWidget {
  const EditProfileScreenBasic({super.key});

  @override
  State<EditProfileScreenBasic> createState() => _EditProfileScreenBasicState();
}

class _EditProfileScreenBasicState extends State<EditProfileScreenBasic> {
  bool isButtonEnabled = true;
  double latitude = 0.0;
  double longitude = 0.0;
  bool isLoadingLocation = true;
  bool isLocationRequested = false;
  bool isLoadingValues = true;
  ResponseProfileList? profile;

  List<String> interestString = [];

  Future<Address?> getAddressFromLatLng() async {
    return await GeoCode()
        .reverseGeocoding(latitude: latitude, longitude: longitude);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void updateInterestString() {
    interestString =
        (profile?.interests.weekendActivities ?? [] as List<String>) +
            (profile?.interests.sports ?? [] as List<String>) +
            (profile?.interests.selfCare ?? [] as List<String>) +
            (profile?.interests.pets ?? [] as List<String>) +
            (profile?.interests.fnd ?? [] as List<String>);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 4.0,
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
                          GetIt.I.get<GetSettingsProfileUseCase>())
                    ..add(OnStartGettingProfile()),
                  child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                    listener: (context, state) async {
                      if (state.status == UpdateProfileStatus.loaded) {
                        isLoadingValues = false;
                      } else if (state.status ==
                          UpdateProfileStatus.errorAuth) {
                        CustomNavigationHelper.router.go(
                          CustomNavigationHelper.loginPath,
                        );
                      } else if (state.status ==
                          UpdateProfileStatus.loadedProfile) {
                        profile = state.responseProfileList;
                        updateInterestString();
                        if (profile?.locationCoordinates != null) {
                          latitude = double.parse(profile?.locationCoordinates?[0] ?? "0");
                          longitude = double.parse(profile?.locationCoordinates?[1] ?? "0");
                        }
                        var data = await getAddressFromLatLng();
                        profile?.location = data?.region;
                        isLoadingValues = false;
                        isLoadingLocation = false;
                        setState(() {

                        });
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
                                !isLoadingValues
                                    ? InkWell(
                                        child: InterestsCard(
                                          header: null,
                                          chipLabels: interestString,
                                          elevation: 4,
                                        ),
                                        onTap: () async {
                                          final interests = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InterestsUpdateScreen(
                                                          params: SettingProfileParams(
                                                              updateParams:
                                                                  UpdateProfileParams(),
                                                              profileParams:
                                                                  profile))));
                                          if (interests != null) {
                                            profile?.interests = interests;
                                            setState(() {
                                              updateInterestString();
                                            });
                                          }
                                        },
                                      )
                                    : const ShimmerLoader(),
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
                                                  child: Icon(Icons.person,
                                                      size: 14),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichTextWithLoader(
                                            text:
                                                profile?.pronouns ?? "Add",
                                            isLoading: isLoadingValues,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    final pronouns = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PronounUpdateScreen(
                                                    params: SettingProfileParams(
                                                        updateParams:
                                                            UpdateProfileParams(),
                                                        profileParams:
                                                            profile))));
                                    if (pronouns != null) {
                                      profile?.pronouns = pronouns;
                                      setState(() {});
                                    }
                                  },
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
                                          InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const WidgetSpan(
                                                          child: Icon(
                                                              Icons.male,
                                                              size: 14),
                                                        ),
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          width: 8,
                                                        )),
                                                        TextSpan(
                                                          text: "Gender ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontFamily:
                                                                  'lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichTextWithLoader(
                                                      text: profile?.gender ??
                                                          "Add", isLoading:isLoadingValues),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              final gender = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GenderUpdateScreen(
                                                              params: SettingProfileParams(
                                                                  updateParams:
                                                                      UpdateProfileParams(),
                                                                  profileParams:
                                                                      profile))));
                                              if (gender != null) {
                                                profile?.gender = gender;
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                          text:
                                                              "Prefer to date ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontFamily:
                                                                  'lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichTextWithLoader(
                                                      text: profile
                                                              ?.datingPreference ??
                                                          "Add", isLoading:isLoadingValues),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              final datePreference = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PartnerGenderUpdateScreen(
                                                              params: SettingProfileParams(
                                                                  updateParams:
                                                                      UpdateProfileParams(),
                                                                  profileParams: profile))));
                                              if (datePreference != null) {
                                                profile?.datingPreference =
                                                    datePreference;
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const WidgetSpan(
                                                          child: Icon(
                                                              Icons
                                                                  .vertical_split,
                                                              size: 14),
                                                        ),
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          width: 8,
                                                        )),
                                                        TextSpan(
                                                          text: "Height ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontFamily:
                                                                  'lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichTextWithLoader(text: profile?.height ??
                                                      "Add", isLoading: isLoadingValues,),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              final datePreference = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PartnerGenderUpdateScreen(
                                                              params: SettingProfileParams(
                                                                  updateParams:
                                                                      UpdateProfileParams(),
                                                                  profileParams:profile))));
                                              if (datePreference != null) {
                                                profile?.datingPreference =
                                                    datePreference;
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const WidgetSpan(
                                                          child: Icon(
                                                              Icons.sunny,
                                                              size: 14),
                                                        ),
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          width: 8,
                                                        )),
                                                        TextSpan(
                                                          text: "Zodiac ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontFamily:
                                                                  'lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichTextWithLoader(text: profile?.zodiac ??
                                                      "Add", isLoading: isLoadingValues),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const WidgetSpan(
                                                          child: Icon(
                                                              Icons
                                                                  .pin_drop_outlined,
                                                              size: 14),
                                                        ),
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          width: 8,
                                                        )),
                                                        TextSpan(
                                                          text: "Location ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontFamily:
                                                                  'lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichTextWithLoader(text: profile?.location ??
                                                      "Add", isLoading: isLoadingLocation),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              if (isLoadingLocation ||
                                                  isLocationRequested) {
                                              } else {
                                                isLoadingLocation = true;
                                                var pos =
                                                    await _determinePosition();
                                                longitude = pos.longitude;
                                                latitude = pos.latitude;
                                                profile?.locationCoordinates = [
                                                  pos.latitude.toString(),
                                                  pos.longitude.toString()
                                                ];
                                                Address? data =  await getAddressFromLatLng();
                                                profile?.location = data?.region;
                                                setState(() {});
                                                isLocationRequested = true;
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const WidgetSpan(
                                                          child: Icon(
                                                              Icons.home,
                                                              size: 14),
                                                        ),
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          width: 8,
                                                        )),
                                                        TextSpan(
                                                          text: "Hometown ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontFamily:
                                                                  'lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichTextWithLoader(text: profile?.hometown ??
                                                      "Add", isLoading: isLoadingValues,),
                                                ],
                                              ),
                                            ),
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
                                !isLoadingValues
                                    ? profile?.languages?.isNotEmpty == false  ?
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
                                                child: Icon(Icons.person,
                                                    size: 14),
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
                                        RichTextWithLoader(text: "Add", isLoading: isLoadingValues),
                                      ],
                                    ),
                                  ),
                                ):
                                InkWell(
                                  child: InterestsCard(
                                    header: null,
                                    chipLabels: interestString,
                                    elevation: 4,
                                  ),
                                  onTap: () async {
                                    final interests = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InterestsUpdateScreen(
                                                    params: SettingProfileParams(
                                                        updateParams:
                                                        UpdateProfileParams(),
                                                        profileParams:
                                                        profile))));
                                    if (interests != null) {
                                      profile?.interests = interests;
                                      setState(() {
                                        updateInterestString();
                                      });
                                    }
                                  },
                                )
                                    : const ShimmerLoader(),
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
