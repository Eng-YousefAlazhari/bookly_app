import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBookIamgeItem extends StatelessWidget {
  const CustomBookIamgeItem({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 2.5 / 4,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          errorWidget: (context, url, error) => const Icon(
            Icons.error_outline,
          ),
        ),

        // child: Container(
        //   width: 100,
        //   height: 40,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       fit: BoxFit.fill,
        //       image: NetworkImage(imageUrl),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
