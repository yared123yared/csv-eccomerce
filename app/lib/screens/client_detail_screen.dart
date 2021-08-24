import 'package:app/Widget/clients/client_profile/basic_info.dart';
import 'package:app/Widget/clients/client_profile/menu.dart';
import 'package:app/Widget/clients/client_profile/orders_table.dart';
import 'package:app/Widget/clients/client_profile/table_header.dart';
import 'package:app/models/client.dart';
import 'package:app/models/navigation/order.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:flutter/material.dart';


class ClientDetailScreen extends StatefulWidget {
  final Client client;

  ClientDetailScreen({
      required this.client,
  });
  static const routeName = 'client_detail';

  @override
  _ClientDetailScreenState createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<Orders> orders=[];
    if(widget.client.orders!=null){
      orders=widget.client.orders!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clients Profile',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ClientBasicProfile(
              client: ClientProfileData(
                name: '${widget.client.firstName} ${widget.client.lastName}',
                credit: 0,
                level: 'Premiem',
                email: '${widget.client.email}',
                phone: '${widget.client.mobile}',

              ),
            ),
            MenuItem(
              title: 'Order',
              childrens: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TableHeader(start: 1, end: 5, total: 5),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Orderstable(
                    orders: orders,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            MenuItem(
              title: 'Document',
              childrens: [],
            ),
            SizedBox(
              height: 10.0,
            ),
            MenuItem(
              title: 'Shipping Addresses',
              childrens: [],
            ),
            SizedBox(
              height: 10.0,
            ),
            MenuItem(
              title: 'Billing Addresses',
              childrens: [],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
