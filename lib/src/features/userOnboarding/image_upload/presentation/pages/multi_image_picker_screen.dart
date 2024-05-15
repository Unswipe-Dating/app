import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unswipe/src/features/userOnboarding/image_upload/domain/usecase/image_upload_usecase.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../bloc/image_upload_bloc.dart';
import '../widgets/multi_image_picker_files/multi_image_picker_controller.dart';
import '../widgets/multi_image_picker_files/multi_image_picker_view.dart';
import '../widgets/multi_image_picker_files/picker.dart';

class ProfileImagePickerScreen extends StatefulWidget {
  const ProfileImagePickerScreen({super.key});

  @override
  _ProfileImagePickerScreenState createState() =>
      _ProfileImagePickerScreenState();
}

class _ProfileImagePickerScreenState extends State<ProfileImagePickerScreen> {
  final controller = MultiImagePickerController(
      maxImages: 6,
      picker: (allowMultiple) async {
        return await pickImagesUsingImagePicker(allowMultiple);
      });
  bool isButtonEnabled = false;

  var request = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      isButtonEnabled = controller.images.length >= 3;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(""),
        ),
        body: BlocProvider(
          create: (BuildContext context) => ImageUploadBloc(
              updateOnboardingStateStreamUseCase:
                  GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
              getAuthStateStreamUseCase: GetIt.I.get<GetAuthStateStreamUseCase>(),
              imageUploadUseCase: GetIt.I.get<ImageUploadUseCase>()
          ),
          child: BlocConsumer<ImageUploadBloc, ImageUploadState>(
              listener: (context, state) {
            if (state.status == ImageUploadStatus.loaded) {
              CustomNavigationHelper.router.push(
                CustomNavigationHelper.onboardingNamePath,
              );
            }
          }, builder: (context, state) {
            return state.status == ImageUploadStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                          flex: 9,
                          child: LinearProgressIndicator(
                            color: Colors.black,

                            value: 0, // Set the progress to 10%
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.start,
                          '0%',
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
                      'Add 6 photos',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Playfair',
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          disabledBackgroundColor:
                              Colors.black.withOpacity(0.6),
                          disabledForegroundColor:
                              Colors.white.withOpacity(0.6),
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
                      initialWidget: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            )),
                        height: 100,
                        width: 100,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              controller.pickImages();
                            },
                          ),
                        ),
                      ),
                      addMoreButton: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            )),
                        height: 100,
                        width: 100,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              controller.pickImages();
                            },
                          ),
                        ),
                      ),
                    ) // Set a background color
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                        context.read<ImageUploadBloc>().add(OnImageUploadRequested(controller.images.toList()));

                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          disabledBackgroundColor:
                              Colors.black.withOpacity(0.6),
                          disabledForegroundColor:
                              Colors.white.withOpacity(0.6),
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
            );
          }),
        ),
      ),
    );
  }
}
