import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
