import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
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

import '../../../../../widgets/login/rounded_text_field.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/presentation/widgets/RichTextWithLoader.dart';
import '../../../login/presentation/pages/Login.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';

class EditProfileScreenWork extends StatefulWidget {
  const EditProfileScreenWork({super.key});

  @override
  State<EditProfileScreenWork> createState() => _EditProfileScreenWorkState();
}

class _EditProfileScreenWorkState extends State<EditProfileScreenWork> {
  late FToast fToast;

  bool isButtonEnabled = false;
  bool isButtonLoading = false;
  ResponseProfileWork? work;
  bool isLoadingValues = true;
  ResponseProfileList? profile;

  TextEditingController titleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController institutionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          "Work",
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
                  work = profile?.work ?? ResponseProfileWork(null, null, null, null, null);
                  isLoadingValues = false;
                }
              },
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          textAlign: TextAlign.start,
                          'Let’s talk education and work now.',
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
                                                  text: "Job title ",
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
                                              text: work?.jobTitle ?? "Add",
                                              isLoading: isLoadingValues),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Center(
                                                    child: Text(
                                                      'Job title',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  RoundedTextInput(
                                                    titleText: 'Job title',
                                                    hintText: '',
                                                    controller: titleController,
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: CustomButton(
                                                      onPressed: () {
                                                        if (titleController
                                                            .text.isNotEmpty) {
                                                          work?.jobTitle =
                                                              titleController
                                                                  .text;
                                                          isButtonEnabled = true;
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      text: 'Add',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
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
                                                  child: Icon(Icons.how_to_reg,
                                                      size: 14),
                                                ),
                                                const WidgetSpan(
                                                    child: SizedBox(
                                                  width: 8,
                                                )),
                                                TextSpan(
                                                  text: "Company name ",
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
                                              text: work?.companyName ?? "Add",
                                              isLoading: isLoadingValues),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Center(
                                                    child: Text(
                                                      'Company name',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  RoundedTextInput(
                                                    titleText: 'Company name',
                                                    hintText: '',
                                                    controller:
                                                        companyController,
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: CustomButton(
                                                      onPressed: () {
                                                        work?.companyName =
                                                            companyController
                                                                .text;
                                                        isButtonEnabled = true;
                                                        Navigator.pop(context);
                                                      },
                                                      text: 'Add',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
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
                                                  text: "Education level ",
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
                                                  work?.educationLevel ?? "Add",
                                              isLoading: isLoadingValues),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Center(
                                                    child: Text(
                                                      'Education level',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  RoundedTextInput(
                                                    titleText:
                                                        'Education level',
                                                    hintText: '',
                                                    controller:
                                                        educationController,
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: CustomButton(
                                                      onPressed: () {
                                                        work?.educationLevel =
                                                            educationController
                                                                .text;
                                                        isButtonEnabled = true;
                                                        Navigator.pop(context);
                                                      },
                                                      text: 'Add',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
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
                                                  text: "Institution ",
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
                                              text: work?.institution ?? "Add",
                                              isLoading: isLoadingValues),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Center(
                                                    child: Text(
                                                      'Institution',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  RoundedTextInput(
                                                    titleText:
                                                        'The educational institution you last went to',
                                                    hintText: '',
                                                    controller:
                                                        institutionController,
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: CustomButton(
                                                      onPressed: () {
                                                        work?.institution =
                                                            institutionController
                                                                .text;
                                                        isButtonEnabled = true;
                                                        Navigator.pop(context);
                                                      },
                                                      text: 'Add',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
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
                              profile?.work = work;
                              context.read<UpdateProfileBloc>().add(
                                  OnRequestApiCallUpdate(UpdateProfileParams
                                      .getUpdatedParamsFromProfile(profile)));
                            },
                            text: 'Save',
                            isEnabled: isButtonEnabled,
                            isLoading: isButtonLoading,
                          ),
                        )
                      ]),
                );
              },
            )),
      ),
    );
  }
}
