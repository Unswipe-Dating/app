import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardContent extends StatefulWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  late final String image;
  late final String title;
  late final String description;

  @override
  State<OnBoardContent> createState() => _OnBoardContentState();
}

class _OnBoardContentState extends State<OnBoardContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(widget.image),
        const Spacer(),
        const Spacer(),
        Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Playfair',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          widget.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Lato',
          ),
        ),
        const Spacer(),
      ],
    );
  }
}