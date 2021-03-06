import 'package:app/Widget/Orders/allOrders/Pdf/pdf_screen.dart';
import 'package:app/models/client.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class InvoicesScreen extends StatelessWidget {
  final Client client;
  InvoicesScreen({Key? key, required this.client}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Orders> orders = [];
  @override
  Widget build(BuildContext context) {
    orders = this.client.orders ?? [];
    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text(
          'Invoices',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      //         height: MediaQuery.of(context).size.height -
      // AppBar().preferredSize.height -
      // 90,

      body: Container(
        color: Color(0xFFf2f6f9),
        child: orders.length == 0
            ? Center(
                child: Text(
                  "NO ORDER",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext ctx, i) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        if (this.client.orders![i].id != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PdafScreen(this.client.orders![i].id!)));
                        }
                      },
                      leading: Image.asset("assets/images/pdf.jpeg"),
                      title: Text(
                        "Invoice Number #${this.client.orders![i].id}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          //to color
                        ),
                      ),
                      subtitle: Text(
                          "Order Total : \$ ${this.client.orders![i].total}"),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
