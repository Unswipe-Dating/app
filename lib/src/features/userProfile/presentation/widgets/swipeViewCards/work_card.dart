import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unswipe/widgets/login/icon_text.dart';

class WorkCard extends StatelessWidget {
  final String designation = "Software developer";
  final String company = "Google";
  final String highestEducation = "Postgraduate";
  final String school = "University of Manchester";

  const WorkCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    "Work",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0),
                  ),
                  SizedBox(width: 8,),
                  Icon(
                    Icons.verified,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            IconTextWidget(iconData: FontAwesomeIcons.suitcase,
                text: designation, color: Colors.black),
            SizedBox(height: 16,),
            IconTextWidget(iconData: FontAwesomeIcons.sheetPlastic,
                text: company, color: Colors.black),
            SizedBox(height: 16,),
            IconTextWidget(iconData: FontAwesomeIcons.graduationCap,
                text: highestEducation, color: Colors.black),
            SizedBox(height: 16,),
            IconTextWidget(iconData: FontAwesomeIcons.university,
                text: school, color: Colors.black),

          ],
        ),
      ),
    );
  }
}
