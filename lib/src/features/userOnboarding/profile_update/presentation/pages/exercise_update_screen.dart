import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../core/router/app_router.dart';

class ExerciseUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;
  final bool toShowLoader;

  const ExerciseUpdateScreen({
    super.key,
    required this.params,
    this.toShowLoader = true,

  });

  @override
  _ExerciseUpdateScreenState createState() => _ExerciseUpdateScreenState();
}

enum SingingCharacter { Never, Sometimes, Active, Sportsperson,}

class _ExerciseUpdateScreenState extends State<ExerciseUpdateScreen> {
  bool isButtonEnabled = true;
  SingingCharacter? _character = SingingCharacter.Never;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext mContext) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(""),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                if (widget.toShowLoader)
                  const Row(
                    children: [
                      Expanded(
                          flex: 9,
                          child: LinearProgressIndicator(
                            color: Colors.black,

                            value: 0.48, // Set the progress to 10%
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.start,
                          '48%',
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
                    'Which gender do you associate yourself with ?',
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
                    "This will be shown on your profile. You can change this later.",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          title: const Text(
                            "Never",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Never,
                            groupValue: _character,
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return Colors.black.withOpacity(.32);
                                  }
                                  return Colors.black;
                                }),
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          title: const Text(
                            "Sometimes",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Sometimes,
                            groupValue: _character,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.black.withOpacity(.32);
                                  }
                                  return Colors.black;
                                }),
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          title: const Text(
                            "Active",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Active,
                            groupValue: _character,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.black.withOpacity(.32);
                                  }
                                  return Colors.black;
                                }),
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          title: const Text(
                            "Sportsperson",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Sportsperson,
                            groupValue: _character,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.black.withOpacity(.32);
                                  }
                                  return Colors.black;
                                }),
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      )


                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: CustomButton(
                    onPressed: () {
                      if (!widget.toShowLoader) {
                        Navigator.pop(
                            mContext, getNameFromCharacter(_character));
                      } else {
                        widget.params.updateParams?.gender =
                            getNameFromCharacter(_character);
                        CustomNavigationHelper.router.push(
                            CustomNavigationHelper.onboardingPronounPath,
                            extra: UpdateProfileParams                                .getUpdatedParams(widget.params.updateParams));
                      }
                    },
                    text: 'Next',
                    isEnabled: isButtonEnabled,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  String? getNameFromCharacter(SingingCharacter? character) {
    switch (character) {
      case SingingCharacter.Never:
        return "Never";
      case SingingCharacter.Sometimes:
        return "Sometimes";
      case SingingCharacter.Active:
        return "Active";
      case SingingCharacter.Sportsperson:
        return "Sportsperson";
      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "Never":
        return SingingCharacter.Never;
      case "Sometimes":
        return SingingCharacter.Sometimes;
      case "Active":
        return SingingCharacter.Active;
      case "Sportsperson":
        return SingingCharacter.Sportsperson;
      default:
        return SingingCharacter.Never;
    }
  }
}
