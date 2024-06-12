import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/settings/domain/usecases/get_settings_profile_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart';
import 'package:unswipe/src/features/userProfile/presentation/widgets/swipeViewCards/interests_card.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../core/router/app_router.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';

class EditProfileScreenBasic extends StatefulWidget {
  final UpdateProfileParams? params;

  const EditProfileScreenBasic({super.key, this.params});

  @override
  _EditProfileScreenBasicState createState() => _EditProfileScreenBasicState();
}

class _EditProfileScreenBasicState extends State<EditProfileScreenBasic> {
  bool isButtonEnabled = true;
  List<ChipValues> weekendList = [
    ChipValues("Takeaway"),
    ChipValues("Outdoors"),
    ChipValues("Party"),
    ChipValues("Club hop"),
    ChipValues("Sleep in"),
    ChipValues("Cook"),
    ChipValues("Brunch"),
    ChipValues("Music"),
    ChipValues("Long Drive"),
    ChipValues("Fancy restaurants")
  ];

  List<ChipValues> petsList = [
    ChipValues("Dogs"),
    ChipValues("Cats"),
    ChipValues("Birds"),
    ChipValues("Fish"),
    ChipValues("Rabbits"),
    ChipValues("Turtle"),
  ];

  List<ChipValues> selfCareList = [
    ChipValues("Yoga"),
    ChipValues("Run"),
    ChipValues("Meditate"),
    ChipValues("Spa days"),
    ChipValues("Travel"),
    ChipValues("Gardening"),
    ChipValues("Cycling"),
    ChipValues("Journal"),
    ChipValues("Dance"),
    ChipValues("Photography"),
    ChipValues("Music"),
    ChipValues("Sing"),
  ];

  List<ChipValues> foodNDrinkList = [
    ChipValues("Chinese"),
    ChipValues("Thai"),
    ChipValues("Greek"),
    ChipValues("Korean"),
    ChipValues("Mexican"),
    ChipValues("Japanese"),
    ChipValues("Italian"),
    ChipValues("Vegan"),
  ];

  List<ChipValues> sportsList = [
    ChipValues("Pilates"),
    ChipValues("Gym"),
    ChipValues("Football"),
    ChipValues("Boxing"),
    ChipValues("Cricket"),
    ChipValues("Tennis"),
    ChipValues("Badminton"),
    ChipValues("Go kart"),
    ChipValues("Basketball"),
    ChipValues("Baseball"),
    ChipValues("Hockey"),
  ];

  List<String> weekendListString = [];
  List<String> petsListString = [];
  List<String> foodNDrinkListString = [];
  List<String> sportsListString = [];
  List<String> selfCareListString = [];
  int selectedLength = 0;

  @override
  void initState() {
    super.initState();
  }

  void updateSelectionState() {
    selectedLength = weekendListString.length +
        petsListString.length +
        foodNDrinkListString.length +
        sportsListString.length +
        selfCareListString.length;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(""),
        ),
        body: BlocProvider(
            create: (BuildContext context) => UpdateProfileBloc(
                updateOnboardingStateStreamUseCase:
                GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
                getAuthStateStreamUseCase: GetIt.I.get<GetAuthStateStreamUseCase>(),
                updateProfileUseCase: GetIt.I.get<UpdateProfileUseCase>(),
                createProfileUseCase: GetIt.I.get<CreateProfileUseCase>(),
                updateUserStateStreamUseCase: GetIt.I.get<UpdateUserStateStreamUseCase>(),
                getSettingsProfileUseCase: GetIt.I.get<GetSettingsProfileUseCase>()


            ),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                textAlign: TextAlign.start,
                                'My Interests',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0),
                              ),
                            ),
                            const Text(
                              "Tell us about all the things you love <3",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),
                            InterestsCard(header: null, chipLabels: ["a", "b", "c "]),
                            const SizedBox(
                              height: 24,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                textAlign: TextAlign.start,
                                'My Interests',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0),
                              ),
                            ),
                            const Text(
                              "Tell us about all the things you love <3",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),
                          Card(
                            elevation: 0,
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 8,),
                                Text(
                                  "Pronoun",
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0),
                                ),
                                Text(
                                  "selected text",
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0),
                                ),
                                Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                            ),
                          ),

                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                textAlign: TextAlign.start,
                                'Basic Information',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0),
                              ),
                            ),
                            const Text(
                              "Tell us more about you. Everyone is curious too",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),

                            Card(
                              elevation: 0,
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Pronoun",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        "selected text",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Icon(Icons.keyboard_arrow_right),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Pronoun",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        "selected text",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Icon(Icons.keyboard_arrow_right),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Pronoun",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        "selected text",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Icon(Icons.keyboard_arrow_right),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Pronoun",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        "selected text",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Icon(Icons.keyboard_arrow_right),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Pronoun",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        "selected text",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Icon(Icons.keyboard_arrow_right),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 8,),
                                      Text(
                                        "Pronoun",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        "selected text",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontFamily: 'lato',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0),
                                      ),
                                      Icon(Icons.keyboard_arrow_right),
                                    ],
                                  ),
                                ],)
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                textAlign: TextAlign.start,
                                'My Languages',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0),
                              ),
                            ),
                            const Text(
                              "In how many languages can you place an order in a restaurant?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),

                            Card(
                              elevation: 0,
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 8,),
                                    Text(
                                      "Pronoun",
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontFamily: 'lato',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "selected text",
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontFamily: 'lato',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(32),
                              child: ElevatedButton(
                                onPressed: () {
                                },
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Selected",
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0),
                            ),
                            Text(
                              "$selectedLength / 8",
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
        ),
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
