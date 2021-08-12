import 'package:flutter/material.dart';

class ContainerSearchBorder extends StatelessWidget {
  final TextEditingController searchController;
  final String text;
  final double height;
  final double width;
  final Widget textNum;

  const ContainerSearchBorder({
    required this.searchController,
    required this.text,
    required this.height,
    required this.width,
    required this.textNum,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffd2dfea),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xff414e79),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(
                  fontSize: 20,
                  color: Color(0xffc3cbd5),
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xffd2dfea), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Container(
              child: textNum,
            ),
          ),
        ],
      ),
    );
  }
}
