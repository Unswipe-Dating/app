import 'package:flutter/material.dart';

class CommunityTabPage extends StatelessWidget {
  const CommunityTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [

                Tab(text: "Statistics", ),
                Tab(text: "Contribute", ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}