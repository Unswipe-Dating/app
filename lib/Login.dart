import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unswipe/viewmodels/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:unswipe/widgets/login/icon_text.dart';
import 'package:unswipe/widgets/login/rounded_text_field.dart';


class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginScreen({super.key,
    required this.onLogin});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: SvgPicture.asset("assets/images/login_background.svg"),
          ),
           Center(
            child: MyForm(onLogin: widget.onLogin),
          )
        ],
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  final VoidCallback onLogin;

  const MyForm({super.key,
    required  this.onLogin});
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  late CustomButtonState buttonState;

  bool isCodeRequested = false;
  bool isButtonEnabled = false;
  bool isOtpEnabled = false;
  bool toShowTimer = false;
  String emailError = "";
  String codeError = "";
  late Timer _timer;
  int _start = 9;

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers to track changes in text fields
    buttonState = CustomButtonState.code;
    emailController.addListener(validateFields);
    emailController.addListener(() {
      setState(() {
        emailError = "";
      });
    });
    otpController.addListener((){
      setState(() {
        codeError = "";
      });
    });
    otpController.addListener(validateFields);
  }

  void validateFields() {
    // Validate email and password
    bool isEmailValid = isValidEmail(emailController.text);
    bool isPasswordValid = isValidPassword(otpController.text);

    // Enable or disable the button based on the validation status
    setState(() {
      isButtonEnabled = isButtonEnabledState(isEmailValid, isPasswordValid);
      isOtpEnabled = isEmailValid && isCodeRequested;
    });
  }

  bool isValidEmail(String email) {
    // You can implement your own email validation logic here
    return email.isNotEmpty && email.contains('@');
  }

  bool isValidPassword(String password) {
    // You can implement your own password validation logic here
    return password.isNotEmpty && password.length >= 6;
  }

  bool isButtonEnabledState(bool email, bool password) {
    switch (buttonState) {
      case CustomButtonState.loading:
        return true; // we need to change it according to start api and update it on api response
      case CustomButtonState.code:
        return email;
      case CustomButtonState.signup:
        return email && password && isCodeRequested;
    }
  }

  void onButtonClick(
    String email,
    String code,
  ) async {
    switch (buttonState) {
      case CustomButtonState.loading:{
        //state when either api is called or timer is on.

      }
      case CustomButtonState.code:{
          //buttonState = CustomButtonState.loading;
          //some api code to request otp/code,
          //update buttonState to code again
          isCodeRequested = true;
          startTimer();
          buttonState = CustomButtonState.signup;
        }
      case CustomButtonState.signup:{
        if(email != "abc@xyz.com") {
          emailError = "some error";
        }

        if(code != "12345678") {
          codeError = "some error";
        }

        if(email == "abc@xyz.com" && code == "12345678") {
          final authViewModel = context.read<AuthViewModel>();
          final result = await authViewModel.login();
          if (result == true) {
            widget.onLogin();
          } else {
            authViewModel.logingIn = false;
          }

        }
        }
    }
    validateFields();

  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    toShowTimer = true;
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            toShowTimer = false;
            _start = 9;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
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
            const SizedBox(height: 16.0),
            RoundedTextInput(
              titleText: 'E-mail ID',
              hintText: 'Enter your email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              errorString: emailError,
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
                errorString: codeError,
              ),
            ),
            if (toShowTimer)
              IconTextWidget(iconData: Icons.timer,
                  text: 'Time left: $_start seconds',
                  color: const Color.fromARGB(97, 97, 97, 1),
              ),
            const SizedBox(height: 16.0),
            CustomButton(
              text: buttonState.text,
              onPressed: () {
                onButtonClick(emailController.text, otpController.text);
              },
              isEnabled: isButtonEnabled,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

}

class CustomButton extends StatefulWidget  {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const CustomButton(
      {super.key, required this.text, this.onPressed, this.isEnabled = true});

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
      child: Text(widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
          )),
    );
  }
}




enum CustomButtonState { code, signup, loading }

extension CustomButtonStateText on CustomButtonState {
  String get text {
    switch (this) {
      case CustomButtonState.code:
        return "Send code";
      case CustomButtonState.signup:
        return "Signup/Login";
      case CustomButtonState.loading:
        return "Resend code";
    }
  }
}
