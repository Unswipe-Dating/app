import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Progress Example'),
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: 0.1, // Set the progress to 10%
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('This is some text'),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: ElevatedButton(
                onPressed: () {



                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    disabledBackgroundColor: Colors.black.withOpacity(0.6),
                    disabledForegroundColor: Colors.white.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(2.0), // Rounded corners
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
                color: Colors.grey[200], // Set a background color
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: ElevatedButton(
                onPressed: () {



                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey[200],
                    disabledBackgroundColor: Colors.black.withOpacity(0.6),
                    disabledForegroundColor: Colors.white.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(2.0), // Rounded corners
                    ),
                    minimumSize:
                    const Size.fromHeight(48) // Set button text color
                ),
                child: const Text(
                  'Photo guidelines',
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
      ),
    );
  }
}