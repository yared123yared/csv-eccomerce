import 'package:app/Widget/invoice/search-client.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawer.dart';

class InvoiceClientSearch extends StatelessWidget {
  const InvoiceClientSearch({Key? key}) : super(key: key);
  static const routeName = "invoice_client_search";
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      drawer: AppDrawer(
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text(
          cubit.tInvoices(),
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
