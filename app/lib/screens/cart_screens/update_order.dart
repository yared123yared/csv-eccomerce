import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:flutter/material.dart';

class UpdateOrder extends StatelessWidget {
  static const routeName = '/cart/order/update';
  final DataAllOrders? order;
  UpdateOrder({ this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Order"),
      ),
      body: Column(
        children:[
           Container(
                    // height: MediaQuery.of(context).size.height * 0.4,
                    // child: ListView.separated(
                    //   separatorBuilder: (BuildContext context, int index) {
                    //     return SizedBox(
                    //       height: 0,
                    //     );
                    //   },
                    //   itemBuilder: (context, index) =>
                    //       index >= state.cartProducts.length
                    //           ? Container(child: Text("The end"))
                    //           : SingleCartItem(
                    //               product: state.cartProducts[index],
                    //             ),
                    //   itemCount: state.cartProducts.length,
                    )
        ]
      )
    );
  }
}
