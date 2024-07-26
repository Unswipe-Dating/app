import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';

import '../../domain/repository/user_settings_repository.dart';

class ZodiacUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;
  final bool toShowLoader;

  const ZodiacUpdateScreen({
    super.key,
    required this.params,
    this.toShowLoader = true,
  });

  @override
  State<ZodiacUpdateScreen> createState() => _ZodiacUpdateScreenState();
}

enum SingingCharacter {
  Aries,
  Taurus,
  Gemini,
  Cancer,
  Leo,
  Virgo,
  Libra,
  Scorpio,
  Sagittarius,
  Capricorn,
  Aquarius,
  Pisces
}

class _ZodiacUpdateScreenState extends State<ZodiacUpdateScreen> {
  bool isButtonEnabled = true;
  bool isTrue = false;
  SingingCharacter? _character = SingingCharacter.Aries;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _character = getCharactedFromName(widget.params.profileParams?.zodiac);
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
              "Zodiac",
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
                            "Aries",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Aries,
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
                            "Taurus",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Taurus,
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
                            "Gemini",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Gemini,
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
                            "Cancer",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Cancer,
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
                            "Leo",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Leo,
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
                            "Virgo",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Virgo,
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
                            "Libra",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Libra,
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
                            "Scorpio",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Scorpio,
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
                            "Sagittarius",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Sagittarius,
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
                            "Capricorn",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Capricorn,
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
                            "Aquarius",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Aquarius,
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
                            "Pisces",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.Pisces,
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
      case SingingCharacter.Aries:
        return "Aries";
      case SingingCharacter.Taurus:
        return "Taurus";
      case SingingCharacter.Gemini:
        return "Gemini";
      case SingingCharacter.Cancer:
        return "Cancer";
      case SingingCharacter.Leo:
        return "Leo";
      case SingingCharacter.Virgo:
        return "Virgo";
      case SingingCharacter.Libra:
        return "Libra";
      case SingingCharacter.Scorpio:
        return "Scorpio";
      case SingingCharacter.Sagittarius:
        return "Sagittarius";
      case SingingCharacter.Capricorn:
        return "Capricorn";
      case SingingCharacter.Aquarius:
        return "Aquarius";
      case SingingCharacter.Pisces:
        return "Pisces";

      default:
        return null;
    }
  }

  SingingCharacter getCharactedFromName(String? name) {
    switch (name?.toLowerCase()) {
      case "Aries":
        return SingingCharacter.Aries;
      case "Taurus":
        return SingingCharacter.Taurus;
      case "Gemini":
        return SingingCharacter.Gemini;
      case "Cancer":
        return SingingCharacter.Cancer;
      case "Leo":
        return SingingCharacter.Leo;
      case "Virgo":
        return SingingCharacter.Virgo;
      case "Libra":
        return SingingCharacter.Libra;
      case "Scorpio":
        return SingingCharacter.Scorpio;
      case "Sagittarius":
        return SingingCharacter.Sagittarius;
      case "Capricorn":
        return SingingCharacter.Capricorn;
      case "Aquarius":
        return SingingCharacter.Aquarius;
      case "Pisces":
        return SingingCharacter.Pisces;

      default:
        return SingingCharacter.Aries;
    }
  }
}
