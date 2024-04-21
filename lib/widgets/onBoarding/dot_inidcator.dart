// Dot indicator widget
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        border: isActive ? null : Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}


class FlatIndicator extends StatelessWidget {
  const FlatIndicator({
    this.isActive = false,
    this.width = 24,
    this.height = 8,
    super.key,
  });

  final bool isActive;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0x80FFFFFF),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}