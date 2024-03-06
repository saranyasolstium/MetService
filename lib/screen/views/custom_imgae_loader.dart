import 'package:eagle_pixels/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageLoader extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  CustomImageLoader({required this.imageUrl, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    // Check if the image is an SVG
    if (imageUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        fit: fit,
        placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
      );
    }
    // For PNG, JPG, or other image types
    else {
      return Image.network(
        imageUrl,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return   Image.network(kCameraPlaceholder);// Fallback icon in case of error
        },
      );
    }
  }
}
