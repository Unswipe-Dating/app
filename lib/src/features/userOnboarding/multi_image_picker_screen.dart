import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';
import 'multi_image_picker_files/multi_image_picker_controller.dart';
import 'multi_image_picker_files/multi_image_picker_view.dart';
import 'multi_image_picker_files/picker.dart';


class ProfileImagePickerScreen extends StatefulWidget {
  const ProfileImagePickerScreen({super.key});

  @override
  _ProfileImagePickerScreenState createState() => _ProfileImagePickerScreenState();
}

class _ProfileImagePickerScreenState extends State<ProfileImagePickerScreen> {
  final controller = MultiImagePickerController(
      maxImages: 10,
      picker: (allowMultiple) async {
        return await pickImagesUsingImagePicker(allowMultiple);
      });


  var request = [];


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text(""),),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: 0.1, // Set the progress to 10%
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add 6 photos',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Playfair',
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: ElevatedButton(
                  onPressed: () {



                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      disabledBackgroundColor: Colors.black.withOpacity(0.6),
                      disabledForegroundColor: Colors.white.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(8.0), // Rounded corners
                      ),
                      minimumSize:
                      const Size.fromHeight(48) // Set button text color
                  ),
                  child: const Text(
                    'You need to upload at least 3 photos',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    child: MultiImagePickerView(
                      controller: controller,
                      padding: const EdgeInsets.all(10),
                    ) // Set a background color
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: ElevatedButton(
                  onPressed: () {
                    CustomNavigationHelper.router.push(
                        CustomNavigationHelper.onboardingNamePath,);
                  },
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
        ),
    );
  }
}
