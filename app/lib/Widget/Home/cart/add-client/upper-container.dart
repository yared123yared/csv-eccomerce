import 'package:app/Widget/Home/cart/add-client/client-title.dart';
import 'package:app/Widget/Home/cart/add-client/search-bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'client-display.dart';

class UpperContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 1,
            color: Colors.white,
            child: Container(
              // margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              // width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.37,
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Search Client",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: AutoSizeText(
                                'Showing 1 to 5 entries of 5 entries',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 10)),
                          ),
                          Container(
                            child: SearchBar(),
                          )
                        ]),
                  ),
                  ClientListTitle(),
                  ClientsDisplay(),
                ],
              ),
            )));
  }
}
