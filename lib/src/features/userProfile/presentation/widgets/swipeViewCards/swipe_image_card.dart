import 'package:flutter/material.dart';
import 'package:unswipe/widgets/onBoarding/dot_inidcator.dart';

class SwipeImageGallery extends StatefulWidget {
  final List<String> imageUrls;

  const SwipeImageGallery({Key? key, required this.imageUrls})
      : super(key: key);

  @override
  State<SwipeImageGallery> createState() => _SwipeImageGalleryState();
}

class _SwipeImageGalleryState extends State<SwipeImageGallery> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              onPageChanged: (value) => setState(() => currentIndex = value),
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                var image =  Image.network(
                  widget.imageUrls[index],
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
                );
                    return FadeInImage.assetNetwork(
                      placeholder:'assets/profile_pic_loader.png',
                      image: widget.imageUrls[index],
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        fit: BoxFit.cover,
                    );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  widget.imageUrls.length,
                      (index) => Padding(
                    padding: const EdgeInsets.only(right: 4, top: 16),
                    child: FlatIndicator(
                      isActive: index == currentIndex,
                      width: (MediaQuery.of(context).size.width * 0.8)/widget.imageUrls.length
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
