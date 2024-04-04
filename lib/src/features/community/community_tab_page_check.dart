import 'package:flutter/material.dart';
import 'package:unswipe/src/core/tabs/colors_transform.dart';
import 'package:unswipe/src/core/tabs/custom_indicator.dart';
import 'package:unswipe/src/core/tabs/flutter_custom_tab_bar.dart';
import 'package:unswipe/src/core/tabs/round_indicator.dart';


class RoundTabBarPage extends StatefulWidget {
  RoundTabBarPage({Key? key}) : super(key: key);

  @override
  _RoundTabBarPageState createState() => _RoundTabBarPageState();
}

class _RoundTabBarPageState extends State<RoundTabBarPage> {
  final int pageCount = 2;
  late PageController _controller = PageController(initialPage: 1);
  CustomTabBarController _tabBarController = CustomTabBarController();

  @override
  void initState() {
    super.initState();
  }

  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
        transform: ColorsTransform(
            highlightColor: Colors.white,
            normalColor: Colors.black,
            builder: (context, color) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                alignment: Alignment.center,
                constraints: BoxConstraints(minWidth: 60),
                child: (Text(
                  index == 1 ? 'Statistics' : 'Contribute',
                  style: TextStyle(
                      color: color,
                      fontFamily: 'lato',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0)
                )),
              );
            }),
        index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16,),
        CustomTabBar(
          width: MediaQuery.of(context).size.width * 0.65,
          pinned: true,
          tabBarController: _tabBarController,
          height: 50,
          itemCount: pageCount,
          builder: getTabbarChild,
          indicator: RoundIndicator(
            color: Colors.black,
            top: 2.5,
            bottom: 2.5,
            left: 2.5,
            right: 2.5,
            radius: BorderRadius.circular(25),
          ),
          pageController: _controller,
        ),
        Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: pageCount,
                itemBuilder: (context, index) {
                  return Icon(Icons.directions_car);
                })),
        TextButton(
            onPressed: () {
              _tabBarController.animateToIndex(3);
            },
            child: Text('gogogo'))
      ],
    ),
    );
  }
}