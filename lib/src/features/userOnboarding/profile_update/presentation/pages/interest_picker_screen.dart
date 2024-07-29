import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/settings/domain/usecases/get_settings_profile_usecase.dart';
import 'package:unswipe/src/features/settings/presentation/pages/edit_profile_screen_basic.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../login/presentation/pages/Login.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../userProfile/data/model/get_profile/response_profile_swipe.dart';
import '../../domain/repository/update_profile_repository.dart';
import '../bloc/profile_update_bloc.dart';
class InterestsUpdateScreen extends StatefulWidget {
  final bool toShowLoader;
  final SettingProfileParams params;


  const InterestsUpdateScreen({super.key,
    required this.params,
    this.toShowLoader = true,
  });

  @override
  _InterestsUpdateScreenState createState() => _InterestsUpdateScreenState();
}

class _InterestsUpdateScreenState extends State<InterestsUpdateScreen> {
  bool isButtonEnabled = true;
  bool isLoadingValues = false;
  Map<String,ChipValues> weekendMap = {
    "Takeaway": ChipValues("Takeaway"),
    "Outdoors":ChipValues("Outdoors"),
    "Party":ChipValues("Party"),
    "Club hop":ChipValues("Club hop"),
    "Sleep in":ChipValues("Sleep in"),
    "Cook":ChipValues("Cook"),
    "Brunch":ChipValues("Brunch"),
    "Music":ChipValues("Music"),
    "Long Drive":ChipValues("Long Drive"),
    "":ChipValues("Fancy restaurants")
  };

  Map<String,ChipValues> petsMap = {
    "Dogs": ChipValues("Dogs"),
    "Cats": ChipValues("Cats"),
    "Birds": ChipValues("Birds"),
    "Fish": ChipValues("Fish"),
    "Rabbits": ChipValues("Rabbits"),
    "Turtle": ChipValues("Turtle"),
  };

  Map<String,ChipValues> selfCareMap = {
    "Yoga": ChipValues("Yoga"),
    "Run": ChipValues("Run"),
    "Meditate": ChipValues("Meditate"),
    "Spa days": ChipValues("Spa days"),
    "Travel": ChipValues("Travel"),
    "Gardening": ChipValues("Gardening"),
    "Cycling": ChipValues("Cycling"),
    "Journal": ChipValues("Journal"),
    "Dance": ChipValues("Dance"),
    "Photography": ChipValues("Photography"),
    "Music": ChipValues("Music"),
    "Sing": ChipValues("Sing"),
  };

  Map<String,ChipValues> foodNDrinkMap = {
    "Chinese":ChipValues("Chinese"),
    "Thai":ChipValues("Thai"),
    "Greek":ChipValues("Greek"),
    "Korean":ChipValues("Korean"),
    "Mexican":ChipValues("Mexican"),
    "Japanese":ChipValues("Japanese"),
    "Italian":ChipValues("Italian"),
    "Vegan":ChipValues("Vegan"),
};

  Map<String,ChipValues> sportsMap = {
    "Pilates": ChipValues("Pilates"),
    "Gym": ChipValues("Gym"),
    "Football": ChipValues("Football"),
    "Boxing": ChipValues("Boxing"),
    "Cricket": ChipValues("Cricket"),
    "Tennis": ChipValues("Tennis"),
    "Badminton": ChipValues("Badminton"),
    "Go kart": ChipValues("Go kart"),
    "Basketball": ChipValues("Basketball"),
    "Baseball": ChipValues("Baseball"),
    "Hockey": ChipValues("Hockey"),
  };

  List<String> weekendListString = [];
  List<String> petsListString = [];
  List<String> foodNDrinkListString = [];
  List<String> sportsListString = [];
  List<String> selfCareListString = [];
  int selectedLength = 0;

  @override
  void initState() {
    super.initState();
    if(widget.params.profileParams != null) {
      weekendListString.addAll(
          widget.params.profileParams?.interests.weekendActivities ?? []);
      petsListString.addAll(widget.params.profileParams?.interests.pets ?? []);
      foodNDrinkListString.addAll(
          widget.params.profileParams?.interests.fnd ?? []);
      sportsListString.addAll(
          widget.params.profileParams?.interests.sports ?? []);
      selfCareListString.addAll(
          widget.params.profileParams?.interests.selfCare ?? []);

      updateSelectionState();


      for(var weekends in weekendListString) {
        weekendMap[weekends]?.isSelected = true;
      }
      for(var pets in petsListString) {
        petsMap[pets]?.isSelected = true;
      }
      for(var fnd in foodNDrinkListString) {
        foodNDrinkMap[fnd]?.isSelected = true;
      }
      for(var sports in sportsListString) {
        sportsMap[sports]?.isSelected = true;
      }
      for(var sc in selfCareListString) {
        selfCareMap[sc]?.isSelected = true;
      }
    }
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
  Widget build(BuildContext mContext) {
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
          )..add(OnGetTokenEvent()),
          child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
            listener: (context, state) {
              if (state.status == UpdateProfileStatus.error ||
                  state.status == UpdateProfileStatus.errorTimeOut) {
                isLoadingValues = false;
                isButtonEnabled = true;
              }
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
                    if (widget.toShowLoader)
                      const Row(
                      children: [
                        Expanded(
                            flex: 9,
                            child: LinearProgressIndicator(
                              color: Colors.black,

                              value: 0.87, // Set the progress to 10%
                            )
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            textAlign: TextAlign.start,
                            '87%',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.start,
                        'Interests',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Select upto 8 things you love to do. They will be displayed on your profile.",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          const Text(
                            "On Weekends you like to",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                          Wrap(
                            spacing: 8.0,
                            // Adjust spacing between chips as desired
                            children: weekendMap.values
                                .map((label) => ActionChip(
                                side:
                                const BorderSide(color: Colors.transparent),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                backgroundColor: label.isSelected
                                    ? Colors.black
                                    : Colors.grey[200],
                                labelStyle: TextStyle(
                                    color: label.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                label: Text(label.val),
                                onPressed: () {
                                  setState(() {

                                    label.isSelected = !label.isSelected;
                                    label.isSelected
                                        ? weekendListString.add(label.val)
                                        : weekendListString.remove(label.val);
                                    updateSelectionState();
                                  });
                                }))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Pets",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                          Wrap(
                            spacing: 8.0,
                            // Adjust spacing between chips as desired
                            children: petsMap.values
                                .map((label) => ActionChip(
                                side:
                                const BorderSide(color: Colors.transparent),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                backgroundColor: label.isSelected
                                    ? Colors.black
                                    : Colors.grey[200],
                                labelStyle: TextStyle(
                                    color: label.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                label: Text(label.val),
                                onPressed: () {
                                  setState(() {
                                    label.isSelected = !label.isSelected;
                                    label.isSelected
                                        ? petsListString.add(label.val)
                                        : petsListString.remove(label.val);
                                    updateSelectionState();
                                  });
                                }))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Self-care",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                          Wrap(
                            spacing: 8.0,
                            // Adjust spacing between chips as desired
                            children: selfCareMap.values
                                .map((label) => ActionChip(
                                side:
                                const BorderSide(color: Colors.transparent),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                backgroundColor: label.isSelected
                                    ? Colors.black
                                    : Colors.grey[200],
                                labelStyle: TextStyle(
                                    color: label.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                label: Text(label.val),
                                onPressed: () {
                                  setState(() {
                                    label.isSelected = !label.isSelected;
                                    label.isSelected
                                        ? selfCareListString.add(label.val)
                                        : selfCareListString.remove(label.val);
                                    updateSelectionState();
                                  });
                                }))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Food & Drink",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                          Wrap(
                            spacing: 8.0,
                            // Adjust spacing between chips as desired
                            children: foodNDrinkMap.values
                                .map((label) => ActionChip(
                                side:
                                const BorderSide(color: Colors.transparent),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                backgroundColor: label.isSelected
                                    ? Colors.black
                                    : Colors.grey[200],
                                labelStyle: TextStyle(
                                    color: label.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                label: Text(label.val),
                                onPressed: () {
                                  setState(() {
                                    label.isSelected = !label.isSelected;
                                    label.isSelected
                                        ? foodNDrinkListString.add(label.val)
                                        : foodNDrinkListString
                                        .remove(label.val);
                                    updateSelectionState();
                                  });
                                }))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Sports",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                          Wrap(
                            spacing: 8.0,
                            // Adjust spacing between chips as desired
                            children: sportsMap.values
                                .map((label) => ActionChip(
                                side:
                                const BorderSide(color: Colors.transparent),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                backgroundColor: label.isSelected
                                    ? Colors.black
                                    : Colors.grey[200],
                                labelStyle: TextStyle(
                                    color: label.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                label: Text(label.val),
                                onPressed: () {
                                  setState(() {
                                    label.isSelected = !label.isSelected;
                                    label.isSelected
                                        ? sportsListString.add(label.val)
                                        : sportsListString.remove(label.val);
                                    updateSelectionState();
                                  });
                                }))
                                .toList(),
                          ),
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

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: CustomButton(
                        onPressed: () {

                          widget.params.updateParams?.interests = Interests(weekendListString,
                              petsListString,
                              selfCareListString,
                              foodNDrinkListString,
                              sportsListString);
                          if(widget.params.profileParams != null) {
                            Navigator.pop(mContext, ResponseProfileSwipeInterests(
                                weekendListString,
                                petsListString,
                                selfCareListString,
                                foodNDrinkListString,
                                sportsListString
                            ));
                          } else {
                            isButtonEnabled = false;
                            isLoadingValues = true;
                            context.read<UpdateProfileBloc>().add(
                                OnRequestApiCallCreate(
                                    widget.params.updateParams ??
                                        UpdateProfileParams()));
                            setState(() {

                            });
                          }
                        },
                        text: 'Next',
                        isEnabled: isButtonEnabled,
                        isLoading: isLoadingValues
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
