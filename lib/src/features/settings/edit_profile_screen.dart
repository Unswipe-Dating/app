import 'package:flutter/material.dart';

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
                style:  TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0)),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: const [
                    GridItem(icon: Icons.photo, text: 'Photos'),
                    GridItem(icon: Icons.contacts, text: 'Basics'),
                    GridItem(icon: Icons.work, text: 'Work'),
                    GridItem(icon: Icons.remove_red_eye, text: 'Values'),
                    GridItem(icon: Icons.nightlife, text: 'Lifestyle'),
                    GridItem(icon: Icons.message, text: 'Prompt'),
                  ],
                ),
              )
            ]),
          )),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const GridItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: const Color(0xffFDFDFD),
      elevation: 8,
      child: Padding(
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
      ),
    );
  }
}
