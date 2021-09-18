import 'package:flutter/material.dart';

class TitleContainers extends StatelessWidget {
  final String text;
  final String number;
  final String image;
  final Color color;
  final Color imagebackgroundcolor;
  final double fontValue;
  final double fonttext;

  const TitleContainers({
    required this.text,
    required this.number,
    required this.image,
    required this.color,
    required this.imagebackgroundcolor,
    required this.fontValue,
    required this.fonttext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  backgroundColor: imagebackgroundcolor,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: 32,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fonttext,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontValue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
