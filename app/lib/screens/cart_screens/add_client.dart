import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';

import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Home/cart/add-client/Price-info.dart';
import 'package:app/Widget/Home/cart/add-client/next-button.dart';
import 'package:app/Widget/Home/cart/add-client/upper-container.dart';
import 'package:app/Widget/Home/cart/checkout-button.dart';
import 'package:app/Widget/Home/cart/payment/payment-container.dart';
import 'package:app/Widget/Home/cart/product-price-info.dart';
import 'package:app/Widget/Home/cart/single-cart-item.dart';
import 'package:app/logic/cart_logic.dart';
import 'package:app/models/request/payment.dart';
import 'package:app/screens/orders_screen/all_orders_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class AddClient extends StatefulWidget {
  static const routeName = '/cart/add-client';

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  bool nextChecked = false;
  bool isShowing = false;
  Payment payment = new Payment();
  late OrdersBloc ordersbloc;
  late CartBloc cartbloc;
  late ProductBloc productBloc;
  late AddClientBloc addClientBloc;
  @override
  Widget build(BuildContext context) {
    this.isShowing = false;
    ordersbloc = BlocProvider.of<OrdersBloc>(context);
    cartbloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    CartLogic cartLogic = new CartLogic(products: []);
    ScrollController _scrollController = ScrollController();
    TextEditingController payingTimeController = new TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(title: Text("Add Client")),
        // bottomNavigationBar: ,
        backgroundColor: Theme.of(context).accentColor,
        body: ProgressHUD(
          child: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is OrderIsBeingCreating) {
                final progress = ProgressHUD.of(context);
                // if (!isShowing) {
                //   if (progress != null) {
                //     setState(() {
                //       isShowing = true;
                //     });

                // }
                progress!.showWithText("Creating");
              } else if (state is OrderCreatedSuccess) {
                this.isShowing = false;
                cartbloc.add(InitializeCart());
                productBloc.add(FetchProduct());
                Navigator.popAndPushNamed(context, AllOrdersScreen.routeName);
                // return Container(child: Text("Created Successfully"));
              } else if (state is OrderCreatingFailed) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Order Creating failed',
                  desc: 'Fill all the information carefully!',
                  btnCancelOnPress: () {
                    Navigator.popAndPushNamed(context, AddClient.routeName);
                  },
                  btnOkOnPress: () {
                    Navigator.popAndPushNamed(context, AddClient.routeName);
                  },
                )..show();
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.82,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          child: Column(
                            children: [
                              UpperContainer(),
                              //
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),

                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                child: BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                    return ClientInfo(
                                      products: state.cartProducts,
                                    );
                                  },
                                ),
                              ),
                              PaymentContainer(
                                formKey: _formKey,
                                onStateChange: this.setPayment,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ConditionalButton(
                        name: "Order",
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            if (state.request.clientId != null) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.

                              print("Order method is invoked");
                              ordersbloc.add(
                                  CreateOrderEvent(request: state.request));
                              addClientBloc.add(ClientSearchEvent());
                              // ordersbloc
                              //     .add(PaymentAddEvent(payment: this.payment));

                              if (state is RequestUpdateSuccess) {
                                // ordersbloc.add(
                                //     CreateOrderEvent(request: state.request));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please Select Client')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Fill All the required fields')),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  void setPayment(Payment payment) {
    setState(() {
      this.payment = payment;
    });
  }
}
