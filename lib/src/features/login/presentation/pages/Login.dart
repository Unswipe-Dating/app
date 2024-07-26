import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unswipe/notification_services.dart';
import 'package:unswipe/src/chat/chat.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/domain/usecases/request_otp_use_case.dart';
import 'package:unswipe/src/features/login/domain/usecases/signup_login_usecase.dart';
import 'package:unswipe/src/features/login/domain/usecases/update_login_state_stream_usecase.dart';
import 'package:unswipe/src/features/login/domain/usecases/verify_otp_use_case.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:unswipe/src/features/onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import 'package:unswipe/src/features/splash/domain/usecases/meta_usecase.dart';
import 'package:unswipe/widgets/app/platform_dialog.dart';
import 'package:unswipe/widgets/login/icon_text.dart';
import 'package:unswipe/widgets/login/rounded_text_field.dart';

import '../../../../core/router/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _selectScreen() async {
    if (await Permission.contacts.isGranted) {
      CustomNavigationHelper.router.go(
        CustomNavigationHelper.blockContactPath,
      );
    } else {
      CustomNavigationHelper.router.go(
        CustomNavigationHelper.blockContactPermissionPath,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          'assets/images/crowd_bkgd.jpg',
        ),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocProvider(
          create: (BuildContext context) => LoginBloc(
            updateUserStateStreamUseCase:
                GetIt.I.get<UpdateUserStateStreamUseCase>(),
            requestOtpUseCase: GetIt.I.get<RequestOtpUseCase>(),
            verifyOtpUseCase: GetIt.I.get<VerifyOtpUseCase>(),
            updateOnboardingStateStreamUseCase:
                GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
            signUpUseCase: GetIt.I.get<SignUpUseCase>(),
            metaUseCase: GetIt.I.get<MetaUseCase>(),
          ),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.loaded) {
                if (state.onBoardingStatus == OnBoardingStatus.profile) {
                  CustomNavigationHelper.router.go(
                    CustomNavigationHelper.profilePath,
                  );
                } else {
                  _selectScreen();
                }
              } else if (state.status == LoginStatus.loadedChat) {
                CustomNavigationHelper.router.go(
                    CustomNavigationHelper.startChatPath,
                    extra: state.chatParams);
              } else if (state.status == LoginStatus.loadedExpiryTimer) {
                CustomNavigationHelper.router.go(
                    CustomNavigationHelper.profilePathHyperEx,
                    extra: state.profileMatchDuration);
              } else if (state.status == LoginStatus.errorAuth) {
                CustomNavigationHelper.router.go(
                  CustomNavigationHelper.loginPath,
                );
              } else if (state.status == LoginStatus.errorNetwork) {
                showAlertDialog(
                    context: context,
                    title: "Error",
                    content: "No Internet Available",
                    defaultActionText: "Okay");
              } else if (state.status == LoginStatus.loadedOtp) {
              } else if (state.status == LoginStatus.loadingResend) {
              } else if (state.status == LoginStatus.loadedResend) {
              } else if (state.status == LoginStatus.error &&
                  state.errorType == ErrorType.verifyOtp) {}
            },
            builder: (context, state) {
              return state.status == (LoginStatus.loadingSignup)
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        Center(
                          child: MyForm(),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({
    super.key,
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  NotificationServices services = NotificationServices();
  String fcmToken = "";
  TextEditingController contactController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  bool isButtonEnabled = false;
  bool isResendEnabled = false;
  bool isResendVisible = false;
  bool isOtpEnabled = false;
  bool toShowTimer = false;
  String emailError = "";
  Timer? timer;
  int _start = 60;

  @override
  void didUpdateWidget(MyForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(context.read<LoginBloc>().state.status == LoginStatus.loadedOtp
        || context.read<LoginBloc>().state.status == LoginStatus.loadingResend
            && toShowTimer ) {
      startTimer();
    }
    validateFields();
  }

  @override
  void initState() {
    super.initState();
    services.requestNotificationPermission();
    services.getDeviceToken().then((onValue) {
      fcmToken = onValue ?? "";
    });

    // Add listeners to the controllers to track changes in text fields
    codeController.text = "+91";

    contactController.addListener(validateFields);
    contactController.addListener(() {
      setState(() {
        emailError = "";
      });
    });
    otpController.addListener(() {
      context.read<LoginBloc>().add(OnUpdateErrorType());
    });
    otpController.addListener(validateFields);
  }

  void validateFields() {
    // Validate email and password
    bool isEmailValid = isValidContact(contactController.text);
    bool isPasswordValid = isValidPassword(otpController.text);

    // Enable or disable the button based on the validation status
    setState(() {
      isResendEnabled = !toShowTimer && contactController.text.isNotEmpty;
      isButtonEnabled = isButtonEnabledState(isEmailValid, isPasswordValid);
      isOtpEnabled =
          isEmailValid && context.read<LoginBloc>().state.isOtpLoaded;
    });
  }

  bool isValidContact(String contact) {
    // You can implement your own email validation logic here
    return contact.isNotEmpty && contact.length == 10;
  }

  bool isValidPassword(String password) {
    // You can implement your own password validation logic here
    return password.isNotEmpty && password.length >= 6;
  }

  bool isButtonEnabledState(bool email, bool password) {
    var status = context.read<LoginBloc>().state.status;
    switch (status) {
      case LoginStatus.loadedOtp:
      case LoginStatus.loadedResend:
        return email && password && context.read<LoginBloc>().state.isOtpLoaded;
      case LoginStatus.initial:
        return email;
      case LoginStatus.loadingVerification:
      case LoginStatus.loadingOTP:
      case LoginStatus.loadingResend:
        return false;
      default:
        return email;
    }
  }

  void onLoginClick(
    String email,
    String code,
  ) async {
    var isOtpLoaded = context.read<LoginBloc>().state.isOtpLoaded;
    if (!isOtpLoaded) {
      context.read<LoginBloc>().add(OnOtpRequested(OtpParams(
          phone: "${codeController.text}${contactController.text}",
          id: "${codeController.text}${contactController.text}")));
    } else {
      context.read<LoginBloc>().add(OnOtpVerificationRequest(OtpParams(
            phone: "${codeController.text}${contactController.text}",
            id: "${codeController.text}${contactController.text}",
            otp: otpController.text,
            fcmRegisterationToken: fcmToken,
          )));
    }
    validateFields();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          setState(() {
            toShowTimer = false;
            isResendVisible = true;
            isResendEnabled = true;
            _start = 60;
          });

        } else {
          _start--;
          setState(() {
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Unswipe',
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'Playfair',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Let's find your forever",
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: RoundedTextInput(
                    isCountryCode: true,
                    titleText: 'Code',
                    hintText: '',
                    controller: codeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 8,
                  child: RoundedTextInput(
                    titleText: 'Phone Number',
                    hintText: '10 digit no.',
                    controller: contactController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    errorString: emailError,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Opacity(
              opacity: isOtpEnabled ? 1 : 0.4,
              child: RoundedTextInput(
                titleText: 'Verification Code',
                hintText: 'Enter verification code',
                controller: otpController,
                keyboardType: TextInputType.visiblePassword,
                isEnabled: isOtpEnabled,
                errorString:  (context.read<LoginBloc>().state.status == LoginStatus.error
                    && context.read<LoginBloc>().state.errorType == ErrorType.verifyOtp) ? "Incorrect verification code": "",
              ),
            ),
            if (toShowTimer)
              IconTextWidget(
                iconData: Icons.timer,
                text: 'Time left: $_start seconds',
                color: const Color.fromARGB(97, 97, 97, 1),
              ),
            const SizedBox(height: 16.0),
            if (isResendVisible)
              CustomButton(
                  text: "Resend",
                  onPressed: () {
                    setState(() {
                      isResendEnabled = false;
                      toShowTimer = true;
                      validateFields();
                    });
                    context.read<LoginBloc>().add(OnOtpResendRequested(OtpParams(
                        phone:
                            "${codeController.text}${contactController.text}",
                        id: "${codeController.text}${contactController.text}")));
                  },
                  isLoading: context.watch<LoginBloc>().state.status ==
                      LoginStatus.loadingResend,
                  isEnabled: isResendEnabled),
            const SizedBox(height: 8.0),
            CustomButton(
                text: context.read<LoginBloc>().state.status.text,
                onPressed: () {
                  onLoginClick(contactController.text, otpController.text);
                  toShowTimer = !context.read<LoginBloc>().state.isOtpLoaded;
                  setState(() {
                    isButtonEnabled = false;
                  });
                },
                isEnabled: isButtonEnabled,
                isLoading: context.read<LoginBloc>().state.status == LoginStatus.loadingOTP
                    || context.read<LoginBloc>().state.status == LoginStatus.loadingVerification),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isEnabled ? widget.onPressed : null,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          disabledBackgroundColor: Colors.black.withOpacity(0.6),
          disabledForegroundColor: Colors.white.withOpacity(0.6),
          // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0), // Rounded corners
          ),
          minimumSize: const Size.fromHeight(48)),
      child: widget.isLoading
          ? LoadingAnimationWidget.prograssiveDots(
              color: Colors.white,
              size: 32,
            )
          : Text(widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
              )),
    );
  }
}

extension CustomButtonStateText on LoginStatus {
  String get text {
    switch (this) {
      case LoginStatus.initial:
        return "Send code";
      case LoginStatus.loadedOtp:
        return "Signup/Login";
      case LoginStatus.loadingOTP:
        return "Loading ...";
      default:
        return "Signup/Login";
    }
  }
}
