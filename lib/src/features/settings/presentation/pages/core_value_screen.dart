import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/settings/domain/usecases/get_settings_profile_usecase.dart';
import 'package:unswipe/src/features/settings/presentation/pages/edit_profile_screen_basic.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../core/router/app_router.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';

class CoreValuesUpdateScreen extends StatefulWidget {
  final bool toShowLoader;
  final SettingProfileParams params;


  const CoreValuesUpdateScreen({super.key,
    required this.params,
    this.toShowLoader = true,
  });

  @override
  _CoreValuesUpdateScreenState createState() => _CoreValuesUpdateScreenState();
}

class _CoreValuesUpdateScreenState extends State<CoreValuesUpdateScreen> {
  bool isButtonEnabled = true;
  Map<String,ChipValues> coreMap = {
    "Loyalty": ChipValues("Loyalty"),
    "Spirituality":ChipValues("Spirituality"),
    "Humility":ChipValues("Humility"),
    "Compassion":ChipValues("Compassion"),
    "Honesty":ChipValues("Honesty"),
    "Kindness":ChipValues("Kindness"),
    "Integrity":ChipValues("Integrity"),
    "Selflessness":ChipValues("Selflessness"),
    "Determination":ChipValues("Determination"),
    "Generosity":ChipValues("Generosity"),
    "Courage":ChipValues("Courage"),
    "Tolerance":ChipValues("Tolerance"),
    "Trust":ChipValues("Trust"),
    "Equity":ChipValues("Equity"),
    "Equality":ChipValues("Equality"),
    "Empathy":ChipValues("Empathy"),
    "Independence":ChipValues("Independence"),
    "Gratitude":ChipValues("Gratitude"),
    "Friendship":ChipValues("Friendship"),
    "Family":ChipValues("Family"),
    "Justice":ChipValues("Justice"),
    "Knowledge":ChipValues("Knowledge"),
    "Patience":ChipValues("Patience"),
    "Self-respect":ChipValues("Self-respect"),
    "Security":ChipValues("Security"),
    "Adventure":ChipValues("Adventure"),
    "Fun":ChipValues("Fun"),
    "":ChipValues("Loyalty")
  };


  List<String> coreListString = [];


  int selectedLength = 0;

  @override
  void initState() {
    super.initState();
    if(widget.params.profileParams != null) {
       coreListString.addAll(
          widget.params.profileParams?.values?.coreValues ?? []);

      updateSelectionState();


      for(var core in coreListString) {
        coreMap[core]?.isSelected = true;
      }
    }
  }

  void updateSelectionState() {
    selectedLength = coreListString.length;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext mContext) {
    return  Scaffold(
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
            "Core values",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Playfair',
                fontWeight: FontWeight.w600,
                fontSize: 24.0),
          ),
        ),
        body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          "What are your top 3 core values?",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w600,
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
                              children: coreMap.values
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
                                          ? coreListString.add(label.val)
                                          : coreListString.remove(label.val);
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
                            Navigator.pop(mContext, coreListString);
                          },
                          text: 'Next',
                          isEnabled: isButtonEnabled,
                        ),
                      ),
                    ],
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
