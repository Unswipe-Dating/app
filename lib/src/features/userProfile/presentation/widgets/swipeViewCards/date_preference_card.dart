import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePreferenceCard extends StatelessWidget {
  final List<String> chipLabels;

  const DatePreferenceCard({Key? key, required this.chipLabels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(0xffFFDEC6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Prefers to date",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0),
              ),
            ),
            Wrap(
              spacing: 8.0, // Adjust spacing between chips as desired
              children: chipLabels
                  .map((label) => Chip(
                      side: const BorderSide(color: Colors.transparent),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      backgroundColor: Colors.black,
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                      label: Text(label)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
