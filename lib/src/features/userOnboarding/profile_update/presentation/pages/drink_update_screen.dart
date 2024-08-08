import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../core/router/app_router.dart';

class DrinkUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;

  const DrinkUpdateScreen({
    super.key,
    required this.params,

  });

  @override
  _DrinkUpdateScreenState createState() => _DrinkUpdateScreenState();
}

enum SingingCharacter { Regularly, Often, Socially, Rarely, Never, Sober }

class _DrinkUpdateScreenState extends State<DrinkUpdateScreen> {
  bool isButtonEnabled = true;
  SingingCharacter? _character = SingingCharacter.Regularly;

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
              "Drink",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    textAlign: TextAlign.start,
                    'How often do you drink?',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w600,
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
                            "Regularly",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Regularly,
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
                            "Often",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Often,
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
                            "Socially",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Socially,
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
                            "Rarely",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Rarely,
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
                            "Sober",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Sober,
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
                        Navigator.pop(
                            mContext, getNameFromCharacter(_character));
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

  String? getNameFromCharacter(SingingCharacter? character) {
    switch (character) {
      case SingingCharacter.Regularly:
        return "Regularly";
      case SingingCharacter.Often:
        return "Often";
      case SingingCharacter.Socially:
        return "Socially";
      case SingingCharacter.Rarely:
        return "Rarely";
      case SingingCharacter.Never:
        return "Never";
      case SingingCharacter.Sober:
        return "Sober";
      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "Regularly":
        return SingingCharacter.Regularly;
      case "Often":
        return SingingCharacter.Often;
      case "Socially":
        return SingingCharacter.Socially;
      case "Rarely":
        return SingingCharacter.Rarely;
      case "Never":
        return SingingCharacter.Never;
      case "Sober":
        return SingingCharacter.Sober;
      default:
        return SingingCharacter.Regularly;
    }
  }
}
