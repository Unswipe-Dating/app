import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../login/domain/usecases/update_login_state_stream_usecase.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';
import '../../../userOnboarding/profile_update/domain/usecases/update_user_use_case.dart';
import '../../../userOnboarding/profile_update/presentation/bloc/profile_update_bloc.dart';
import '../../domain/usecases/get_settings_profile_usecase.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: const Color(0xffFFDEC6), // Set app-wide background color
        appBarTheme: const AppBarTheme(
            // Apply theme to AppBar
            backgroundColor: Color(0xffFFDEC6) // Set AppBar background color
            ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xffFFDEC6),
        body:  Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 60, bottom: 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: [
                              GridItem(icon: Icons.photo, text: 'Photos', onClick: () {
                                CustomNavigationHelper.router.push(
                                    CustomNavigationHelper.uploadImagePath,
                                );
                              }),
                              GridItem(icon: Icons.contacts, text: 'Basics', onClick: () {
                                CustomNavigationHelper.router.push(
                                  CustomNavigationHelper.settingsPathBasic);
                              },
                              ),
                              GridItem(icon: Icons.work, text: 'Work', onClick: () {
                                CustomNavigationHelper.router.push(
                                    CustomNavigationHelper.settingsPathWork,
                                );
                              }),
                              GridItem(
                                  icon: Icons.remove_red_eye, text: 'Values', onClick: () {
                                CustomNavigationHelper.router.push(
                                    CustomNavigationHelper.settingsPathValues,
                                );
                              }),
                              GridItem(
                                  icon: Icons.nightlife, text: 'Lifestyle', onClick: () {
                                CustomNavigationHelper.router.push(
                                    CustomNavigationHelper.settingsPathLifeStyle,
                                );
                              }),
                              GridItem(icon: Icons.message, text: 'Prompt', onClick: () {}),
                            ],
                          ),
                        )
                      ]),
                ),

            ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onClick;

  const GridItem({super.key, required this.icon,
    required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: const Color(0xffFDFDFD),
      elevation: 8,
      child:InkWell(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36),
              const SizedBox(
                height: 16,
              ),
              Text(text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0)),
            ],
          ),
        ),
      ), onTap: () => onClick(),)
    );
  }
}
