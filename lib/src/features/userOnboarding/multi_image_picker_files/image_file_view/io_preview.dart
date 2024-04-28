import 'dart:io';
import 'package:flutter/material.dart';
import 'package:unswipe/src/features/userOnboarding/multi_image_picker_files/image_file_view/error_preview.dart';
import '../image_file.dart';

class ImageFileView extends StatelessWidget {
  final ImageFile imageFile;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final ImageErrorWidgetBuilder? errorBuilder;

  const ImageFileView(
      {super.key,
      required this.imageFile,
      this.fit = BoxFit.cover,
      this.borderRadius,
      this.errorBuilder,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.background,
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      child: Image.file(
        File(imageFile.path!),
        fit: fit,
        errorBuilder: errorBuilder ??
            (context, error, stackTrace) {
              return ErrorPreview(imageFile: imageFile);
            },
      ),
    );
  }
}
