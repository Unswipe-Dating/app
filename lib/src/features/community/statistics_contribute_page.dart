import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:unswipe/src/features/community/stats_activity_card.dart';
import 'package:flutter/material.dart';
import 'package:unswipe/src/features/community/stats_earnings_card.dart';
import 'package:unswipe/src/features/community/stats_reward_card.dart';

class StatisticsContributePage extends StatelessWidget {
  const StatisticsContributePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child:Column(children: [Container(
        // Adjust as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.blue,
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/stat_contribute.svg"),
            SizedBox(height: 16.0),

            Text(
              "Be an active part of the community, voice your opinions and vote for what you want.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'lato',
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Rounded corners
                    ),
                    minimumSize: const Size.fromHeight(
                        48) // Set button text color
                ),
                child: const Text(
                  'Join Telegram',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato', 
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0),
                ),
              ),
            ),

          ],
        ),
      ),
    ]
      ),

    );
  }
}
