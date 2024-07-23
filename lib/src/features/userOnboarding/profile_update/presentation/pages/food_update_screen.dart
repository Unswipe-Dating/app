import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../core/router/app_router.dart';

class CookUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;
  final bool toShowLoader;

  const CookUpdateScreen({
    super.key,
    required this.params,
    this.toShowLoader = true,

  });

  @override
  _CookUpdateScreenState createState() => _CookUpdateScreenState();
}

enum SingingCharacter { Nope, InstantFood, Little, Daily }

class _CookUpdateScreenState extends State<CookUpdateScreen> {
  bool isButtonEnabled = true;
  SingingCharacter? _character = SingingCharacter.Nope;

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
                            "Nope",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Nope,
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
                            "Instant food",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.InstantFood,
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
                            "A little",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Little,
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
                            "Cooks daily",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Daily,
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
      case SingingCharacter.Nope:
        return "Nope";
      case SingingCharacter.InstantFood:
        return "Instant food";
      case SingingCharacter.Little:
        return "A Little";
      case SingingCharacter.Daily:
        return "Cooks daily";
      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "Nope":
        return SingingCharacter.Nope;
      case "Instant food":
        return SingingCharacter.InstantFood;
      case "A little":
        return SingingCharacter.Little;
      case "Cooks daily":
        return SingingCharacter.Daily;
      default:
        return SingingCharacter.Nope;
    }
  }
}
