import 'package:flutter/material.dart';

class LeadingImage extends StatelessWidget {
  final String image;
  LeadingImage({required this.image});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          height: MediaQuery.of(context).size.height * 0.17,
          width: MediaQuery.of(context).size.width * 0.3,
          fit: BoxFit.fill,
          image: NetworkImage(
            image,
          ),
        ));
  }
}
