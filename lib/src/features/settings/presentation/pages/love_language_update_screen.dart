import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

class LoveLanguageUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;
  final bool toShowLoader;

  const LoveLanguageUpdateScreen({
    super.key,
    required this.params,
    this.toShowLoader = true,
  });

  @override
  State<LoveLanguageUpdateScreen> createState() => _LoveLanguageUpdateScreenState();
}

enum SingingCharacter {
  AOS,
  WOA,
  RG,
  PT,
  QT,
}

class _LoveLanguageUpdateScreenState extends State<LoveLanguageUpdateScreen> {
  bool isButtonEnabled = true;
  SingingCharacter? _character = SingingCharacter.AOS;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _character = getCharactedFromName(widget.params.profileParams?.values?.loveLanguage);
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
            "Love language",
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
              if (widget.toShowLoader)
                const Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: LinearProgressIndicator(
                          color: Colors.black,

                          value: 0.61, // Set the progress to 10%
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        textAlign: TextAlign.start,
                        '61%',
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
                  'What are your political view',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Playfair',
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(
                          "Acts of service",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.AOS,
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
                      ListTile(
                        title: const Text(
                          "Words of affirmation",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.WOA,
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
                      ListTile(
                        title: const Text(
                          "Receiving gifts",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.RG,
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
                      ListTile(
                        title: const Text(
                          "Physical touch",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.PT,
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
                      ListTile(
                        title: const Text(
                          "Quality time",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.QT,
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

                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(mContext, getNameFromCharacter(_character));
                  },
                  text: 'Next',
                  isEnabled: isButtonEnabled,
                ),
              ),
            ],
          ),
        ));
  }

  String? getNameFromCharacter(SingingCharacter? character) {
    switch (character) {
      case SingingCharacter.WOA:
        return "Words of affirmation";
      case SingingCharacter.AOS:
        return "Acts of service";
      case SingingCharacter.RG:
        return "Receiving gifts";
      case SingingCharacter.PT:
        return "Physical touch";
      case SingingCharacter.QT:
        return "Quality time";
      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "Words of affirmation":
        return SingingCharacter.WOA;
      case "Acts of service":
        return SingingCharacter.AOS;
      case "Receiving gifts":
        return SingingCharacter.RG;
      case "Physical touch":
        return SingingCharacter.PT;
      case "Quality time":
        return SingingCharacter.QT;

      default:
        return SingingCharacter.AOS;
    }
  }
}
