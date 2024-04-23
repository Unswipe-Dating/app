import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HyperExclusiveRequestLockScreen extends StatelessWidget {
  const HyperExclusiveRequestLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[200], // Set background color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center content
        children: [
          Center(
            child: Column(
              children: [
                SvgPicture.asset("assets/images/request_permission_bg.svg"),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Avoiding certain people?',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                ),

            const Text(
              'You get to decide who amongst your contacts can discover your profile.',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'latp',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0),
            ),
        ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
// Handle button press
            },
            child: const Text('Block Contact'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // Set button background color
              foregroundColor: Colors.black, // Set button text color
            ),
          ),
        ],
      ),
    );
  }
}
