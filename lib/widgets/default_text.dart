import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  const DefaultText(
    this.text, {
    Key? key,
    this.fontWeight = FontWeight.w400,
    this.size = 14,
    this.color = Colors.black,
    this.isCenter = false,
    this.maxLines,
    this.overflow,
    this.textDecoration,
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;
  final double size;
  final Color color;
  final bool isCenter;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
        decoration: textDecoration,
      ),
    );
  }
}
