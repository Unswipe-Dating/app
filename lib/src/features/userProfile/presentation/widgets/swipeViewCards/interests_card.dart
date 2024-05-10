import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InterestsCard extends StatelessWidget {
  final List<String> chipLabels;
  final String header;
  final bool isFilled;

  const InterestsCard({Key? key,
    required this.header,
    this.isFilled = true,
    required this.chipLabels}) : super(key: key);

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
             Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                header,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0),
              ),
            ),
            Wrap(
              spacing: 8.0, // Adjust spacing between chips as desired
              children: chipLabels
                  .map((label) => Chip(
                      side: BorderSide(color: isFilled ? Colors.transparent : Colors.grey),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      backgroundColor: isFilled ? Colors.black: Colors.white,
                      labelStyle:  TextStyle(
                          color: isFilled ? Colors.white: Colors.black,
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
