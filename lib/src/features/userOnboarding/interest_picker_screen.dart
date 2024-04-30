import 'dart:io';

import 'package:flutter/material.dart';

import '../../../widgets/login/rounded_text_field.dart';
import '../../core/router/app_router.dart';

class InterestsUpdateScreen extends StatefulWidget {
  const InterestsUpdateScreen({super.key});

  @override
  _InterestsUpdateScreenState createState() => _InterestsUpdateScreenState();
}

class _InterestsUpdateScreenState extends State<InterestsUpdateScreen> {
  bool isButtonEnabled = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(""),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: 0.22, // Set the progress to 10%
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  child: SingleChildScrollView(child:
                  Column(
                    children: [

                    ]
                  ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: isButtonEnabled ? () {

                      CustomNavigationHelper.router.push(
                        CustomNavigationHelper.onboardingPronounPath,);
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
}
