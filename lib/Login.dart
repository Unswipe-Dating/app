import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState()  => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: SvgPicture.asset("assets/images/login_background.svg"),

          ),
          const Center(
            child: MyForm(),
          )
        ],
      ),
    );
  }

}


class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isButtonEnabled = false;
  bool isOtpEnabled = false;

  late Timer _timer;
  int _start = 90;

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers to track changes in text fields
    emailController.addListener(validateFields);
    otpController.addListener(validateFields);
  }

  void validateFields() {
    // Validate email and password
    bool isEmailValid = isValidEmail(emailController.text);
    bool isPasswordValid = isValidPassword(otpController.text);

    // Enable or disable the button based on the validation status
    setState(() {
      isButtonEnabled = isEmailValid && isPasswordValid;
      isOtpEnabled = isEmailValid;
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

  void onSentOtpClick(String email) {
    // some action to perform
    setState(() {
    });
  }



  void startTimer() {
    const oneSec = Duration(seconds: 90);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
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
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Unswipe',
              style: TextStyle(
                fontSize: 24.0,
                fontFamily:'Playfair',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Let's find your forever",
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 16.0),
            RoundedTextInput(
                titleText:'Email-ID',
                hintText: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress
            ),
            const SizedBox(height: 16.0),
            Opacity(
              opacity: 1,
              child: RoundedTextInput(
                  titleText: 'Verification Code',
                  hintText: 'Enter verification code',
                  controller: otpController,
                  keyboardType: TextInputType.visiblePassword
              ),
            ),
            const SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }


  void _onSubmit() {
    // Handle the submit logic here
    print('Email: ${emailController.text}');
    print('Password: ${otpController.text}');
  }
}


class RoundedTextInput extends StatefulWidget {
  final String titleText;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool isEnabled;

  const RoundedTextInput({super.key,
    required this.titleText,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
  });


  @override
  State<RoundedTextInput> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextInput> {
  final ValueNotifier<bool> _textFiledIsFocused = ValueNotifier(false);
  late final FocusNode focusNode = FocusNode();



  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      _textFiledIsFocused.value = focusNode.hasFocus;
    });
  }


  @override
  void dispose() {
    focusNode.dispose();
    _textFiledIsFocused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: widget.titleText,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0
              ),
              children: const [
                TextSpan(
                    text: ' *',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                    )
                )
              ]
          ),
        ),
        const SizedBox(height: 8.0),
        ValueListenableBuilder(
            valueListenable: _textFiledIsFocused,
            builder: (context, value, child) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: value ? Border.all(color: Colors.black): Border.all(color: Colors.transparent),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled: widget.isEnabled,
                focusNode: focusNode,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    border:InputBorder.none
                ),
              ),

            )
        ),
      ],
    );
  }

}



