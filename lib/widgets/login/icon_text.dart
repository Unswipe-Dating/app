import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;

  const IconTextWidget({super.key, required this.iconData,
    required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Icon(
          iconData,
          size: 14,
          color: color,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              color: color
          ),
        ),
      ],
    );
  }
}
