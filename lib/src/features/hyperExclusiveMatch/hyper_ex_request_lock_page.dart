import 'package:flutter/material.dart';

class HyperExclusiveRequestLockScreen extends StatelessWidget {
  const HyperExclusiveRequestLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Text
              Text(
                "This is the top text",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),

              // Image with square aspect ratio
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset('assets/images/profilePictures/profile_1.jpg'),
              ),
              SizedBox(height: 20),

              // Bottom Text
              Text(
                "This is another text",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Countdown Text with rounded border
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "00:00:00", // Replace with your countdown logic
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Final Text
              Text(
                "This is the final text",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
    );
  }
}