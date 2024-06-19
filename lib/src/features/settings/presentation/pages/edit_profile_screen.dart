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

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: const Color(0xffFFDEC6), // Set app-wide background color
        appBarTheme: const AppBarTheme(
            // Apply theme to AppBar
            backgroundColor: Color(0xffFFDEC6) // Set AppBar background color
            ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xffFFDEC6),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w700,
                  fontSize: 22.0)),
        ),
        body: BlocProvider(
            create: (BuildContext context) => UpdateProfileBloc(
                updateOnboardingStateStreamUseCase:
                    GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
                getAuthStateStreamUseCase:
                    GetIt.I.get<GetAuthStateStreamUseCase>(),
                updateProfileUseCase: GetIt.I.get<UpdateProfileUseCase>(),
                createProfileUseCase: GetIt.I.get<CreateProfileUseCase>(),
                updateUserStateStreamUseCase:
                    GetIt.I.get<UpdateUserStateStreamUseCase>(),
                getSettingsProfileUseCase:
                    GetIt.I.get<GetSettingsProfileUseCase>())
            ..add(OnStartGettingProfile()),
            child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
              listener: (context, state) {
                if (state.status == UpdateProfileStatus.loadedProfile) {

                }
              },
              builder: (context, state) {
                return Padding(
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
                                CustomNavigationHelper.router.go(
                                    CustomNavigationHelper.uploadImagePath,
                                    extra: state.responseProfileList
                                );
                              }),
                              GridItem(icon: Icons.contacts, text: 'Basics', onClick: () {
                                CustomNavigationHelper.router.go(
                                  CustomNavigationHelper.settingsPathBasic,
                                  extra: state.responseProfileList
                                );
                              }, ),
                              GridItem(icon: Icons.work, text: 'Work', onClick: () {}),
                              GridItem(
                                  icon: Icons.remove_red_eye, text: 'Values', onClick: () {}),
                              GridItem(
                                  icon: Icons.nightlife, text: 'Lifestyle', onClick: () {}),
                              GridItem(icon: Icons.message, text: 'Prompt', onClick: () {}),
                            ],
                          ),
                        )
                      ]),
                );
              },
            )),
      ),
    );
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
