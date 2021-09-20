import 'package:app/Widget/Home/cart/add-client/search-bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'client-display.dart';
import 'client-title.dart';

class InvoSearchClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0,
        color: Theme.of(context).accentColor,
        child: Container(
          // margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          // width: double.infinity,
          // height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  // Visibility(
                  //   visible: state.request.clientId == null?true:false,
                  //   child: BlinkText("*Required",
                  //       style: TextStyle(
                  //           color:Colors.red,
                  //           fontWeight:FontWeight.bold
                  //             )),
                  // ),
                  SearchBar(),
                ],
              ),

              // padding: const EdgeInsets.all(8.0),

              ClientListTitle(),
              ClientsDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}
