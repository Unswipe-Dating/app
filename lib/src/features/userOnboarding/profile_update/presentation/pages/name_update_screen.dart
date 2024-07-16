import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
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
  bool isButtonLoading = false;


  var request = [];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


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
      debugShowCheckedModeBanner: false,
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
                child: Align(alignment: Alignment.topLeft,
                  child: Text(
                    'Your Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
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
                child: CustomButton(
                  onPressed: () async {
                    isButtonEnabled = false;
                    isButtonLoading = true;
                    setState(() {

                    });
                    var pos = await _determinePosition();
                    isButtonEnabled = true;
                    isButtonLoading = false;
                    setState(() {

                    });
                    CustomNavigationHelper.router.push(
                      CustomNavigationHelper.onboardingDOBPath,
                        extra: UpdateProfileParams(name: contactController.text,
                            showTruncatedName: isTrue, locationCoordinates: [pos.latitude.toString(),
                              pos.longitude.toString()])
                    );
                  },
                  text: 'Next',
                  isEnabled: isButtonEnabled,
                  isLoading: isButtonLoading,
                ),
              ),
            ],
          )
          ,)
      ),
    );
  }
}
