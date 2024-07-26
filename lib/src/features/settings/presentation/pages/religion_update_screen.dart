import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

class ReligionUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;
  final bool toShowLoader;

  const ReligionUpdateScreen({
    super.key,
    required this.params,
    this.toShowLoader = true,
  });

  @override
  State<ReligionUpdateScreen> createState() => _ReligionUpdateScreenState();
}

enum SingingCharacter {
  Agnostic,
  Atheist,
  Buddhist,
  Catholic,
  Christian,
  Hindu,
  Jain,
  Jewish,
  Mormon,
  Muslim,
  Sikh,
  Shinto,
  Taoist,
  Zoroastranism
}

class _ReligionUpdateScreenState extends State<ReligionUpdateScreen> {
  bool isButtonEnabled = true;
  SingingCharacter? _character = SingingCharacter.Agnostic;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _character = getCharactedFromName(widget.params.profileParams?.values?.religion);
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
            "Religion",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(
                          "Agnostic",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Agnostic,
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
                          "Atheist",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Atheist,
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
                          "Buddhist",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Buddhist,
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
                          "Catholic",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Catholic,
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
                          "Christian",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Christian,
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
                          "Hindu",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Hindu,
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
                          "Jain",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Jain,
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
                          "Jewish",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Jewish,
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
                          "Mormon",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Mormon,
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
                          "Muslim",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Muslim,
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
                          "Sikh",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Sikh,
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
                          "Shinto",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Shinto,
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
                          "Taoist",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Taoist,
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
                          "Zoroastrianism",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Zoroastranism,
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
      case SingingCharacter.Agnostic:
        return "Agnostic";
      case SingingCharacter.Atheist:
        return "Atheist";
      case SingingCharacter.Buddhist:
        return "Buddhist";
      case SingingCharacter.Christian:
        return "Christian";
      case SingingCharacter.Catholic:
        return "Catholic";
      case SingingCharacter.Hindu:
        return "Hindu";
      case SingingCharacter.Jain:
        return "Jain";
      case SingingCharacter.Jewish:
        return "Jewish";
      case SingingCharacter.Mormon:
        return "Mormon";
      case SingingCharacter.Muslim:
        return "Muslim";
      case SingingCharacter.Sikh:
        return "Sikh";
      case SingingCharacter.Shinto:
        return "Shinto";
      case SingingCharacter.Taoist:
        return "Taoist";
      case SingingCharacter.Zoroastranism:
        return "Zoroastrianism";

      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "Agnostic":
        return SingingCharacter.Agnostic;
      case "Atheist":
        return SingingCharacter.Atheist;
      case "Buddhist":
        return SingingCharacter.Buddhist;
      case "Christian":
        return SingingCharacter.Christian;
      case "Catholic":
        return SingingCharacter.Catholic;
      case "Hindu":
        return SingingCharacter.Hindu;
      case "Jain":
        return SingingCharacter.Jain;
      case "Jewish":
        return SingingCharacter.Jewish;
      case "Mormon":
        return SingingCharacter.Mormon;
      case "Muslim":
        return SingingCharacter.Muslim;
      case "Sikh":
        return SingingCharacter.Sikh;
      case "Shinto":
        return SingingCharacter.Shinto;
      case "Taoist":
        return SingingCharacter.Taoist;
      case "Zoroastrianism":
        return SingingCharacter.Zoroastranism;
      default:
        return SingingCharacter.Agnostic;
    }
  }
}
