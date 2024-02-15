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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            SvgPicture.asset("assets/images/login_background.svg"),
            const CardView()
          ],
        ),
      ),
    );
  }

}


class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'UnSwipe',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Let's find your forever",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            buildTextFieldWithTitle('Email-ID', 'Enter your email'),
            const SizedBox(height: 16.0),
            buildTextFieldWithTitle('Verification Code', 'Enter verification code'),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldWithTitle(String title, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}