import 'package:app/Widget/clients/client_profile/address_info.dart';
import 'package:app/Widget/clients/client_profile/basic_info.dart';
import 'package:app/Widget/clients/client_profile/menu.dart';
import 'package:app/Widget/clients/client_profile/orders_table.dart';
import 'package:app/Widget/clients/client_profile/table_header.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/client.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    List<Orders> orders = [];
    List<AddressInfo> shippingAddresses = [];
    List<AddressInfo> billingAddresses = [];
    if (widget.client.orders != null) {
      orders = widget.client.orders!;
    }
    if (widget.client.addresses != null) {
      widget.client.addresses!.forEach((address) {
        if (address.isBilling != null) {
          if (address.isBilling == true) {
            billingAddresses.add(AddressInfo(address: address));
          } else {
            shippingAddresses.add(AddressInfo(address: address));
          }
        } else {
          shippingAddresses.add(AddressInfo(address: address));
        }
      });
    }

    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text(
          cubit.tClientProfile(),
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
                credit: "${widget.client.debts==null?0: widget.client.debts == null}",
                level: 'Premiem',
                email: '${widget.client.email}',
                phone: '${widget.client.mobile}',
                creditLimitEndDate: "",
                creditLimitStartDate: "",
                photoPath: "${widget.client.photo?.filePath ?? ""}",
              ),
            ),
            MenuItem(
              title: cubit.tOrder(),
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
              title: cubit.tShippingAddresses(),
              childrens: [...shippingAddresses],
            ),
            SizedBox(
              height: 10.0,
            ),
            MenuItem(
              title: cubit.tBillingAddresses(),
              childrens: [...billingAddresses],
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
