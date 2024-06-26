import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';

import '../../../../../core/router/app_router.dart';
import '../../domain/repository/update_profile_repository.dart';


class PartnerGenderUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;
  const PartnerGenderUpdateScreen({super.key, required this.params});

  @override
  _PartnerGenderUpdateScreenState createState() => _PartnerGenderUpdateScreenState();
}

enum SingingCharacter { Man, Woman, Nonbinary }

class _PartnerGenderUpdateScreenState extends State<PartnerGenderUpdateScreen> {
  bool isButtonEnabled = true;
  bool isTrue = false;
  SingingCharacter? _character = SingingCharacter.Man;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _character = getCharactedFromName(widget.params.profileParams?.pronouns);
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
                const Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: LinearProgressIndicator(
                          color: Colors.black,

                          value: 0.74, // Set the progress to 10%
                        )
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        textAlign: TextAlign.start,
                        '74%',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.start,
                    'You prefer to date',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      ListTile(
                        title: const Text(
                          "Man",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Man,
                          groupValue: _character,
                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
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
                          "Woman",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Woman,
                          groupValue: _character,
                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
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
                          "Nonbinary",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Nonbinary,
                          groupValue: _character,
                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
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

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Show only first letter",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: isTrue,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          isTrue = value;
                        });
                      },
                    )
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: isButtonEnabled ? () {
                      if(widget.params.profileParams != null) {
                        Navigator.pop(mContext, getNameFromCharacter(_character));


                      } else {
                        widget.params.updateParams?.datingPreference =
                            getNameFromCharacter(_character);
                        CustomNavigationHelper.router.push(
                            CustomNavigationHelper.onboardingInterestPath,
                            extra: UpdateProfileParams()
                                .getUpdatedParams(widget.params.updateParams)
                        );
                      }
                    } : null,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        disabledBackgroundColor: Colors.black.withOpacity(0.6),
                        disabledForegroundColor: Colors.white.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(2.0), // Rounded corners
                        ),
                        minimumSize:
                        const Size.fromHeight(48) // Set button text color
                    ),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  String? getNameFromCharacter(SingingCharacter? character) {
    switch (character) {
      case SingingCharacter.Man: return "MEN";
      case SingingCharacter.Woman: return "WOMEN";
      case SingingCharacter.Nonbinary: return "NONBINARY";
      default: return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch(name?.toLowerCase()) {
      case "MEN": return SingingCharacter.Man;
      case "WOMEN": return SingingCharacter.Woman;
      case "NONBINARY": return SingingCharacter.Nonbinary;
      default: return SingingCharacter.Man;

    }
  }
}
