import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../settings/domain/repository/user_settings_repository.dart';
import '../../domain/repository/update_profile_repository.dart';

class PronounUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;

  const PronounUpdateScreen({
    super.key,
    required this.params,
  });

  @override
  State<PronounUpdateScreen> createState() => _PronounUpdateScreenState();
}

enum SingingCharacter { Man, Woman, Nonbinary }

class _PronounUpdateScreenState extends State<PronounUpdateScreen> {
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
    return Scaffold(
      appBar: widget.params.profileParams != null
          ? AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness:
                    Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 4.0,
              title: const Text(
                "Pronouns",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w600,
                    fontSize: 24.0),
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            if (widget.params.profileParams == null)
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
            if (widget.params.profileParams != null)
              const SizedBox(
                height: 8,
              ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.start,
                'Your Preferred pronouns',
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
                  ListTile(
                    title: const Text(
                      "he / him",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
                    ),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.Man,
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
                      "she / her",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
                    ),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.Woman,
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
                      "they / them",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
                    ),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.Nonbinary,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Display on profile",
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
              child: CustomButton(
                onPressed: () {
                  if (widget.params.profileParams != null) {
                    Navigator.pop(mContext, getNameFromCharacter(_character));
                  } else {
                    widget.params.updateParams?.pronouns =
                        getNameFromCharacter(_character);
                    CustomNavigationHelper.router.push(
                        CustomNavigationHelper.onboardingPartnerGenderPath,
                        extra: UpdateProfileParams.getUpdatedParams(
                            widget.params.updateParams));
                  }
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
      case SingingCharacter.Man:
        return "He/Him";
      case SingingCharacter.Woman:
        return "She/Her";
      case SingingCharacter.Nonbinary:
        return "They/Them";
      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "he/him":
        return SingingCharacter.Man;
      case "she/her":
        return SingingCharacter.Woman;
      case "they/them":
        return SingingCharacter.Nonbinary;
      default:
        return SingingCharacter.Man;
    }
  }
}
