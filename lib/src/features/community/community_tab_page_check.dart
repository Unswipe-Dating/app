import 'package:flutter/material.dart';
import 'package:unswipe/src/features/community/statistics_community_page.dart';


class RoundTabBarPage extends StatefulWidget {
  RoundTabBarPage({Key? key}) : super(key: key);

  @override
  _RoundTabBarPageState createState() => _RoundTabBarPageState();
}

class _RoundTabBarPageState extends State<RoundTabBarPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16,),
        TabBar(
          tabAlignment: TabAlignment.center,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          isScrollable: true,
          padding: const EdgeInsets.all(16),
          labelPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(32),
          ),
          tabs: const [
            Tab(
              text: "Statistics",
            ),
            Tab(
              text: "Contribute",
            ),
          ],
        ),
        const Expanded(
          child: TabBarView(
            children: [
              StatisticsCommunityPage(),
              StatisticsCommunityPage(),
            ],
          ),
        )
      ],
    ),
    );
  }
}