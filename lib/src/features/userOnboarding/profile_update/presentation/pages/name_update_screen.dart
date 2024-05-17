import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../../widgets/login/rounded_text_field.dart';
import '../../../../../core/router/app_router.dart';




class NameUpdateScreen extends StatefulWidget {
  const NameUpdateScreen({super.key});

  @override
  _NameUpdateScreenState createState() => _NameUpdateScreenState();
}

class _NameUpdateScreenState extends State<NameUpdateScreen> {
  TextEditingController contactController = TextEditingController();
  String emailError = "";
  bool isTrue = false;
  bool isButtonEnabled = false;

  var request = [];


  @override
  void initState() {
    super.initState();
    contactController.addListener(() {
      setState(() {
        emailError = "";
        isButtonEnabled = contactController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(""),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: LinearProgressIndicator(
                      color: Colors.black,
                      value: 0.22, // Set the progress to 10%
                    )
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.start,
                      '22%',
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
                  'Your Name ?',
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
                  "This will be shown on your profile. You can't change this later.",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'lato',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: RoundedTextInput(
                  titleText: '',
                  hintText: 'Your Name',
                  controller: contactController,
                  errorString: emailError,
                ),
              ),
              Expanded(
                child: Container(
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
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? () {
                    CustomNavigationHelper.router.push(
                      CustomNavigationHelper.onboardingDOBPath,
                        extra: UpdateProfileParams(name: contactController.text,
                            showTruncatedName: isTrue)
                    );
                  }: null,
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
          )
          ,)
      ),
    );
  }
}
