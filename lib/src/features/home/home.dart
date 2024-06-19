import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:go_router/go_router.dart';

import '../userProfile/presentation/pages/profile_view_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.child});

  final StatefulNavigationShell child;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Color> colors = [Colors.white,
    Colors.white,
    Colors.black,
    const Color(0xffFFDEC6)
  ];

  List<String> titles = ['Unswipe', 'Hyper Exclusive Requests', 'By & For U', 'Edit Profile'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: widget.child.currentIndex > 0,
          backgroundColor: colors[widget.child.currentIndex],
          title: Text(
                  titles[widget.child.currentIndex],
                  style:  TextStyle(
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: widget.child.currentIndex == 2 ? Colors.white : Colors.black
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
