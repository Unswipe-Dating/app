import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unswipe/src/core/router/app_router.dart';

class HyperExclusiveRequestPage extends StatelessWidget {
  String? uri;

  HyperExclusiveRequestPage({super.key, this.uri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding( padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (uri != null)
            Image.network(
              uri!,
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
            ),
          const SizedBox(height: 20),

          // Bottom Text
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
            textAlign: TextAlign.center,
            "You've given up browsing profiles for A",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Playfair',
                fontWeight: FontWeight.w600,
                fontSize: 24.0),
          )
          ),
          const SizedBox(height: 10),
          const Text(
            "  You can get out of this if A declines your request or after",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
                fontSize: 14.0),
          ),
          const SizedBox(height: 10),
          // Countdown Text with rounded border
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),

            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                textAlign: TextAlign.center,
                "23h 59m 59s", // Replace with your countdown logic
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 10),
      const Text(
        "I feel it",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
            fontSize: 12.0),
      ),

        ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey[200],
                  backgroundColor: Colors.grey[400],
                  // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0), // Rounded corners
                  ),
                  minimumSize: const Size.fromHeight(48)),
              child: const Text(
                "I feel it",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w200,
                    fontSize: 12.0),
              )),
        ],
      ),
      ),
    );
  }
}
