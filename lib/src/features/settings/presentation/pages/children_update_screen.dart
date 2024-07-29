import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

class ChildrenUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;
  final bool toShowLoader;

  const ChildrenUpdateScreen({
    super.key,
    required this.params,
    this.toShowLoader = true,
  });

  @override
  State<ChildrenUpdateScreen> createState() => _ChildrenUpdateScreenState();
}

enum SingingCharacter {
  WT,
  OTI,
  NSY,
  NW,
  HTDWM,
  HTWM
}

class _ChildrenUpdateScreenState extends State<ChildrenUpdateScreen> {
  bool isButtonEnabled = true;
  SingingCharacter? _character = SingingCharacter.WT;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _character = getCharactedFromName(widget.params.profileParams?.values?.children);
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
            "Children",
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
                  textAlign: TextAlign.start,
                  'In an ideal situation, what is your stand on having kids ?',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'lato',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(
                          "Want'em",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.WT,
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
                          "Open to the idea",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.OTI,
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
                          "Not sure yet",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.NSY,
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
                          "No way",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.NW,
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
                          "Have them and don't want more",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.HTDWM,
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
                          "Have them and want more",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.HTWM,
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
      case SingingCharacter.WT:
        return "Want'em";
      case SingingCharacter.OTI:
        return "Open to the idea";
      case SingingCharacter.NSY:
        return "Not sure yet";
      case SingingCharacter.NW:
        return "No way";
      case SingingCharacter.HTDWM:
        return "Have them don't want more";
      case SingingCharacter.HTWM:
        return "Have them want more";
      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "Want'em":
        return SingingCharacter.WT;
      case "Open to the idea":
        return SingingCharacter.OTI;
      case "Not sure yet":
        return SingingCharacter.NSY;
      case "No way":
        return SingingCharacter.NW;
      case "Have them don't want more":
        return SingingCharacter.HTDWM;
      case "Have them want more":
        return SingingCharacter.HTWM;

      default:
        return SingingCharacter.WT;
    }
  }
}
