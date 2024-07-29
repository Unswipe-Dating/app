import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../../widgets/login/rounded_text_field.dart';
import '../../../../core/router/app_router.dart';
import '../../../login/presentation/pages/Login.dart';
import '../../domain/repository/user_settings_repository.dart';

class HeightUpdateScreen extends StatefulWidget {
  final SettingProfileParams params;

  const HeightUpdateScreen({
    super.key,
    required this.params,
  });

  @override
  State<HeightUpdateScreen> createState() => _HeightUpdateScreenState();
}

class _HeightUpdateScreenState extends State<HeightUpdateScreen> {
  TextEditingController feetController = TextEditingController();
  TextEditingController inchController = TextEditingController();

  bool isButtonEnabled = false;

  var request = [];

  @override
  void initState() {
    super.initState();
    if (widget.params.profileParams?.height?.isNotEmpty == true) {
      List<String> heightText =
          widget.params.profileParams?.height?.split(" ") ?? ["", "", "", ""];
      feetController.text = heightText[0];
      inchController.text = heightText[3];
    }
    feetController.addListener(validateFields);
    inchController.addListener(validateFields);
  }

  void validateFields() {
    // Enable or disable the button based on the validation status
    setState(() {
      isButtonEnabled =
          isValidFeet(feetController.text) && isValidInch(inchController.text);
    });
  }

  bool isValidFeet(String text) {
    if (text.isEmpty) return false;
    try {
      int val = int.parse(text);
      return val > 0 && val <= 7;
    } on Exception catch (_) {
      return false;
    }
  }

  bool isValidInch(text) {
    if (text.isEmpty) return false;
    try {
      int val = int.parse(text);
      return val > 0 && val <= 11;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
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
            elevation: 2.0,
            title: const Text(
              "Height",
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
                    'How tall are you?',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RoundedTextInput(
                          titleText: '',
                          hintText: 'ft',
                          controller: feetController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: RoundedTextInput(
                          titleText: '',
                          hintText: 'in',
                          controller: inchController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pop(mContext,
                          "${feetController.text} ft  ${inchController.text} in");
                    },
                    text: 'Next',
                    isEnabled: isButtonEnabled,
                  ),
                ),
              ],
            ),
          ));
  }

  String? getHeight(String yearText, String monthText, String dateText) {
    return "$yearText-$monthText-$dateText";
  }
}
