import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/homePage/dart_swiper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.child});

  final StatefulNavigationShell child;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white,
        primaryColor: Colors.white, // Set the primary color
        appBarTheme: const AppBarTheme(
          color: Colors.white, // Set the appbar background colo
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Unswipe",
                  style: TextStyle(
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                Icon(Icons.notifications),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: widget.child,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.child.currentIndex,
          onTap: (index) {
            widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            );
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_search,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.person_search,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.public,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.public,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: '',
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
