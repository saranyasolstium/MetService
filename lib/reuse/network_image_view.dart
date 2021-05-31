import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageView extends StatelessWidget {
  final String? url;
  final String? placeholder;

  NetworkImageView(this.url, this.placeholder);
  @override
  Widget build(BuildContext context) {
    if (url != null && url != '') {
      return CachedNetworkImage(
        imageUrl: url!,
        placeholder: (con, url) => Image.asset(placeholder ?? ''),
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(placeholder ?? '');
    }
  }
}
