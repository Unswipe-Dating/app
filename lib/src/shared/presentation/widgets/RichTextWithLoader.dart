import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RichTextWithLoader extends StatefulWidget {
  final String text;
  final bool isLoading;

  const RichTextWithLoader({
    super.key,
    required this.text,
    this.isLoading = false,
  });

  @override
  State<RichTextWithLoader> createState() => _RichTextWithLoaderState();
}

class _RichTextWithLoaderState extends State<RichTextWithLoader> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading?LoadingAnimationWidget.prograssiveDots(
      color: Colors.black,
      size: 32,
    ):RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.text,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: 'lato',
                fontWeight:
                FontWeight.w500,
                fontSize: 14.0),
          ),
          const WidgetSpan(
            child: Icon(
                Icons
                    .keyboard_arrow_right,
                size: 14),
          ),
        ],
      ),
    );
  }
}