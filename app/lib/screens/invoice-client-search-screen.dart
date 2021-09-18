import 'package:app/Widget/invoice/search-client.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class InvoiceClientSearch extends StatelessWidget {
  const InvoiceClientSearch({Key? key}) : super(key: key);
  static const routeName = "invoice_client_search";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      drawer: AppDrawer(
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text(
          'Invoices',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            InvoSearchClient(),
          ],
        ),
      ),
    );
  }
}
