import 'dart:ui';
import 'package:unswipe/src/features/community/stats_activity_card.dart';
import 'package:flutter/material.dart';
import 'package:unswipe/src/features/community/stats_earnings_card.dart';
import 'package:unswipe/src/features/community/stats_reward_card.dart';

class StatisticsCommunityPage extends StatelessWidget {
  const StatisticsCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(24.0),
            child: const Column(
              children: [
                Text(
                  "Number of couples who found their partner on the app ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "2661",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          StatActivityCard(),
          SizedBox(height: 16.0),
          StatEarningsCard(),
          SizedBox(height: 16.0),
          StatRewardCard(),

        ],
      ),
    ),
    );
  }
}
