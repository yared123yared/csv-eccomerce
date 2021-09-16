import 'dart:io';

import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/cart/add-client/next-button.dart';
import 'package:app/Widget/Home/cart/add-client/upper-container.dart';
import 'package:app/Widget/Home/cart/payment/payment-container.dart';
import 'package:app/Widget/Home/cart/update-payment/payment-container.dart';
import 'package:app/Widget/Home/update_order/update-product-price-info.dart';
import 'package:app/Widget/Home/update_order/update-single-cart-item.dart';
import 'package:app/Widget/clients/client_profile/address_info.dart';
import 'package:app/Widget/clients/client_profile/menu.dart';
// import 'package:app/logic/cart_logic.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/cart.dart';
import 'package:app/models/request/payment.dart';
import 'package:app/models/request/request.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/orders_screen/all_orders_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class UpdateOrder extends StatefulWidget {
  static const routeName = '/cart/order/update';
  final DataAllOrders order;
  UpdateOrder({required this.order});

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  List<AddressInfo> shippingAddresses = [];

  bool nextChecked = false;
  bool isShowing = false;
  Payment payment = new Payment();
  late OrdersBloc ordersbloc;
  late CartBloc cartbloc;
  late ProductBloc productBloc;
  late AddClientBloc addClientBloc;
  late AllorderrBloc allorderrBloc;
  // late CartBloc allorderrBloc;
  List<OrderToBeUpdated> orderToBeUpdated = [];
  List<Data> data = [];
  double price = 0;
  PaymentValues values = new PaymentValues(Remaining: 0);
  late Request request;
  @override
  void initState() {
    ordersbloc = BlocProvider.of<OrdersBloc>(context);
    cartbloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    allorderrBloc = BlocProvider.of<AllorderrBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    // ordersbloc.close();
    // cartbloc.close();
    // productBloc.close();
    // addClientBloc.close();
    // allorderrBloc.close();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    this.isShowing = false;
    ordersbloc = BlocProvider.of<OrdersBloc>(context);
    cartbloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    allorderrBloc = BlocProvider.of<AllorderrBloc>(context);
    // ordersbloc.add(CartCheckoutEvent(cartProducts: data));
    // ordersbloc.add(PaymentInitialization());

    // this.isShowing = false;

    // CartLogic cartLogic = new CartLogic(products: []);
    // ScrollController _scrollController = ScrollController();
    // TextEditingController payingTimeController = new TextEditingController();
    AwesomeDialog dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Order Updating failed',
      desc: 'Fill all the information carefully!',
      btnCancelOnPress: () {
        // Navigator.popAndPushNamed(context, AddClient.routeName);
      },
      btnOkOnPress: () {
        // Navigator.popAndPushNamed(context, AddClient.routeName);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Order"),
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, AllOrdersScreen.routeName);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: ProgressHUD(
        child: BlocConsumer<OrdersBloc, OrdersState>(
          listener: (context, state) {
            final progress = ProgressHUD.of(context);

            if (state is OrderUpdating) {
              progress?.dismiss();
              progress?.showWithText("Updating");
              request = state.request;
            } else if (state is OrderUpdateSuccess) {
              print("order update success");
              this.isShowing = false;
              progress?.dismiss();
              dialog..dismiss();
              productBloc.add(FetchProduct());
              allorderrBloc.add(FeatcAllorderrEvent());
              Navigator.popAndPushNamed(context, AllOrdersScreen.routeName);
              return;
            } else if (state is OrderUpdatingFailed) {
              print("order update fail");
              progress?.dismiss();
              dialog..show();
              BlocProvider.of<AddClientBloc>(context)
                  .add(ClientDisplayEvent(client: widget.order.client!));
              // ordersbloc.add(PaymentInitialization());
              // request = state.request;
              ordersbloc.add(SetRequestEvent(request: request));
            } else if (state is FetchingOrderToBeUpdatedSuccess) {
              request = state.request;
              progress?.dismiss();
              // print("--success--");
              // data = state.data;
              orderToBeUpdated = state.data;
              ordersbloc.add(
                SetRequestEvent(
                  request: Request(
                    id: widget.order.id,
                    amountPaid: state.request.amountPaid?.toInt() ?? 0,
                    //double.parse(state.allorderdata[index].amountRemaining).round()
                    amountRemaining:
                        state.request.amountRemaining?.toInt() ?? 0,
                    transactionId: "4545",
                    paymentWhen: 'now',
                    paymentMethod: "wallet",
                    typeOfWallet: "smilepay",
                    cart: [],
                    cartItem: [],
                    clientId: state.client?.id ?? 0,
                    addressId: state.addressId ?? 0,
                    total: 0,
                  ),
                ),
              );
              for (var item in orderToBeUpdated) {
                data.add(item.data);
              }
              for (var item in orderToBeUpdated) {
                setState(() {
                  price += item.price * item.quantity;
                });
                ordersbloc.add(
                  AddToCart(
                    cart: CartItem(
                      quantity: item.quantity,
                      id: -1,
                      // id: item.cartId,
                      productId: item.data.id,
                    ),
                  ),
                );
              }
              List<Data> cartData = cartbloc.state.cartProducts;
              // print("cart--data");
              // print(cartData.length);
              if (cartData.length > 0) {
                for (var item in cartData) {
                  data.add(item);
                }
                double cartItemPrice = 0.0;
                for (var item in cartData) {
                  if (item.price != null) {
                    setState(() {
                      try {
                        cartItemPrice = double.parse(item.price!);
                        price += double.parse(item.price!) * item.order;
                      } catch (e) {
                        print(e);
                      }
                    });
                  }

                  bool itemFoundInOrderToBeUpdated = false;
                  for (var i = 0; i < orderToBeUpdated.length; i++) {
                    if (orderToBeUpdated[i].data.id == item.id) {
                      int quant = orderToBeUpdated[i].quantity + item.order;
                      orderToBeUpdated[i].quantity = quant;
                      double tot = (quant.toDouble() * cartItemPrice);
                      orderToBeUpdated[i].total = tot;
                      itemFoundInOrderToBeUpdated = true;
                    }
                  }
                  if (!itemFoundInOrderToBeUpdated) {
                    orderToBeUpdated.add(OrderToBeUpdated(
                      cartId: -1,
                      data: item,
                      price: cartItemPrice,
                      total: cartItemPrice * item.order,
                      quantity: item.order,
                    ));
                  }
                  ordersbloc.add(
                    AddToCart(
                      cart: CartItem(
                        quantity: item.order,
                        id: -1,
                        productId: item.id,
                      ),
                    ),
                  );
                }
              }
              addClientBloc.add(ClientDisplayEvent(client: state.client!));
              // print("111");
              ordersbloc.add(ClientAddEvent(client: state.client!));

              // ordersbloc.add(AddPaymentWhenEvent(
              //   when: 'Pay Now',
              // ));
              ordersbloc.add(AddPaidAmountEvent(
                amount: state.request.amountPaid?.toInt() ?? 0,
              ));
              ordersbloc.add(AddRemainingAmountEvent(
                amount: state.request.amountRemaining?.toInt() ?? 0,
              ));
              int addrId = 0;
              if (state.addressId != null) {
                addrId = state.addressId!;
              }
              // print("address---id");
              // print(addrId);
              ordersbloc.add(AddAddressIdEvent(id: addrId));
              ordersbloc.add(AddTotalEvent(total: price.toInt()));
            }
          },
          builder: (context, state) {
            if (state is FetchingOrderToBeUpdated) {
              return Center(
                child: CircularProgressIndicator(
                    semanticsLabel: "Fetching order Detail"),
              );
            } else if (state is FetchingOrderToBeUpdatedFailed) {
              return Center(
                child: Text(
                  "Failed to Fetch Order Detail",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            print("--current--update--order----state");
            print(state);
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CART",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.popAndPushNamed(
                                    context, MainScreen.routeName,
                                    arguments: 1);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.16,
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    orderToBeUpdated.length > 0
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 0,
                                );
                              },
                              itemBuilder: (context, index) =>
                                  index >= orderToBeUpdated.length
                                      ? Container(child: Text("The end"))
                                      : UpdateSingleCartItem(
                                          decreasePrice: decreasePrice,
                                          increasePrice: addPrice,
                                          order: orderToBeUpdated[index],
                                          // product: orderToBeUpdated[index].data,
                                          // cartID: orderToBeUpdated[index].cartId,
                                          // price: orderToBeUpdated[index].price,
                                          // quantity:
                                          // orderToBeUpdated[index].quantity,
                                          // total: orderToBeUpdated[index].total,
                                        ),
                              itemCount: orderToBeUpdated.length,
                            ),
                          )
                        : Container(),
                    data.length > 0
                        ? UpdateProductPriceInfo(
                            price: price,
                          )
                        : Container(),
                    UpperContainer(),
                    //
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    // MenuItem(
                    //   title: 'Shipping Addresses',
                    //   childrens: [...shippingAddresses],
                    // ),
                    UpdatePaymentContainer(
                      formKey: _formKey,
                      onAddPaidPressed: this.addPaidAmount,
                      // paymentValues: values,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          // padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  "    Remaining Amount:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('${state.request.amountRemaining}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ConditionalButton(
                      name: "UPDATE ORDER",
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            if (state.request.clientId != null) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              int total = price.toInt();
                              ordersbloc.add(AddTotalEvent(total: total));
                              print("Order method is invoked");
                              // Request request = state.request;
                              // if (request.cart != null) {
                              // request.total =
                              //     );
                              ordersbloc.add(AddRemainingAmountEvent(
                                  amount: values.Remaining.toInt()));

                              ordersbloc.add(
                                  UpdateOrderEvent(request: state.request));
                              addClientBloc.add(ClientSearchEvent());
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Cart is empty')),
                              //   );
                              // }

                              // ordersbloc
                              //     .add(PaymentAddEvent(payment: this.payment));

                              // if (state is RequestUpdateSuccess) {
                              // ordersbloc.add(
                              //     CreateOrderEvent(request: state.request));
                              // }
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
                        } else {
                          print("form is null");
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void addPrice(double priceX) {
    setState(() {
      price += priceX;
    });
    ordersbloc.add(AddTotalEvent(total: price.toInt()));
  }

  void decreasePrice(double priceX) {
    setState(() {
      price -= priceX;
    });
    ordersbloc.add(AddTotalEvent(total: price.toInt()));
  }

  void addPaidAmount(String value) async {
    if (value == "") {
      value = "0";
    }
    double val = 0;
    double paid = 0;
    try {
      paid = double.parse(value);
    } catch (e) {
      print(e);
    }
    val = price - paid;
    print("-------");
    print(val.toInt());
    ordersbloc.add(AddPaidAmountEvent(amount: int.parse(value)));
    ordersbloc.add(AddRemainingAmountEvent(amount: val.toInt()));
  }

  double getTotalPrice(List<CartItem> carts) {
    double total = 0;

    for (int i = 0; i < carts.length; i++) {
      // String value = products[i].price as String;
      // total += double.parse(value) * products[i].order;
      for (int j = 0; j < data.length; j++) {
        if (carts[i].id == data[j].id) {
          if (data[j].price != null) {
            if (carts[i].quantity != null) {
              total += double.parse(data[j].price!) * carts[i].quantity;
            }
          }
        }
      }
    }

    // double taxedValue = total - 20;
    return total;
  }

  void setPayment(Payment payment) {
    setState(() {
      this.payment = payment;
    });
  }
}
