import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LeadingImage extends StatelessWidget {
  final String image;
  LeadingImage({required this.image});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child:  CachedNetworkImage(
            imageUrl:image,
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.fill,
            placeholder: (context, url) => Container(
              color: Colors.white,
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.black,
              child: Icon(Icons.error),
            ),
          ),
        );
  }
}
