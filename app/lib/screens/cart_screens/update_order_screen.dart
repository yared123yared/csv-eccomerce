import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/cart/add-client/next-button.dart';
import 'package:app/Widget/Home/cart/add-client/upper-container.dart';
import 'package:app/Widget/Home/cart/payment/payment-container.dart';
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
  // late OrdersBloc ordersBloc;
  List<OrderToBeUpdated> orderToBeUpdated = [];
  List<Data> data = [];
  double price = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.isShowing = false;
    ordersbloc = BlocProvider.of<OrdersBloc>(context);
    cartbloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    allorderrBloc = BlocProvider.of<AllorderrBloc>(context);
    ordersbloc.add(CartCheckoutEvent(cartProducts: data));
    // CartLogic cartLogic = new CartLogic(products: []);
    // ScrollController _scrollController = ScrollController();
    // TextEditingController payingTimeController = new TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: ProgressHUD(
        child: BlocConsumer<OrdersBloc, OrdersState>(
          listener: (context, state) {
            final progress = ProgressHUD.of(context);

            if (state is OrderUpdating) {
              // if (!isShowing) {
              //   if (progress != null) {
              //     setState(() {
              //       isShowing = true;
              //     });

              // }
              progress?.showWithText("Updating");
            } else if (state is OrderUpdateSuccess) {
              print("order update success");
              this.isShowing = false;
              // cartbloc.add(InitializeCart());
              progress?.dismiss();

              dialog..dismiss();
              dispose();
              productBloc.add(FetchProduct());
              allorderrBloc.add(FeatcAllorderrEvent());
              Navigator.popAndPushNamed(context, AllOrdersScreen.routeName);
              // return Container(child: Text("Created Successfully"));
              return;
            } else if (state is OrderUpdatingFailed) {
              print("order update fail");

              progress?.dismiss();
              dialog..show();
            } else if (state is FetchingOrderToBeUpdatedSuccess) {
              print("--success--");
              // data = state.data;
              orderToBeUpdated = state.data;
              for (var item in orderToBeUpdated) {
                data.add(item.data);
              }
              for (var item in orderToBeUpdated) {
                setState(() {
                  price += item.price;
                });
                ordersbloc.add(
                  AddToCart(
                    cart: CartItem(
                      quantity: item.quantity,
                      id: item.cartId,
                      productId: item.data.id,
                    ),
                  ),
                );
              }
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
            } else if (state is FetchingOrderToBeUpdatedSuccess) {
              // data = state.data;
              // for (var item in data) {
              //   ordersbloc.add(
              //     AddToCart(
              //       cart: Cart(
              //           amountInCart:1,
              //           id: item.id,
              //           prodID: item.id),
              //     ),
              //   );
              // }
              print("from ---bloc");
              print(data.length);
            }
            print("--current--update--order----state");
            print(state);
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                              itemBuilder: (context, index) => index >=
                                      orderToBeUpdated.length
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
                    MenuItem(
                      title: 'Shipping Addresses',
                      childrens: [...shippingAddresses],
                    ),
                    PaymentContainer(
                      formKey: _formKey,
                      onStateChange: this.setPayment,
                    ),
                    ConditionalButton(
                      name: "Order",
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          if (state.request.clientId != null) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            int total =price.toInt();
                            ordersbloc.add(AddTotalEvent(total: total));
                            print("Order method is invoked");
                            // Request request = state.request;
                            // if (request.cart != null) {
                            // request.total =
                            //     );
                            ordersbloc
                                .add(UpdateOrderEvent(request: state.request));
                            addClientBloc.add(ClientSearchEvent());
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(content: Text('Cart is empty')),
                            //   );
                            // }

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
                                content: Text('Fill All the required fields')),
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
      ),
    );
  }

  void addPrice(double priceX) {
    setState(() {
      price += priceX;
    });
  }

  void decreasePrice(double priceX) {
    setState(() {
      price -= priceX;
    });
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

    double taxedValue = total - 20;
    return taxedValue;
  }

  void setPayment(Payment payment) {
    setState(() {
      this.payment = payment;
    });
  }
}