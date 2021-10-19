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
import 'package:app/constants/constants.dart';
import 'package:app/data_provider/orders_data_provider.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
// import 'package:app/logic/cart_logic.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/models/product/attributes.dart';
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
  List<OrderToBeUpdated> orderToBeUpdated = [];
  List<ProductAttribute> productAttributed = [];
  List<Data> data = [];
  double price = 0;
  int paid = 0;
  int previosPaid = 0;
  int currentPaid = 0;
  PaymentValues values = new PaymentValues(Remaining: 0);
  late Request request;
  String title = "Order Updating failed";
  String desc = "Fill all the information carefully!";
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
    AwesomeDialog dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnCancelOnPress: () {
        // Navigator.popAndPushNamed(context, AddClient.routeName);
      },
      btnOkOnPress: () {
        // Navigator.popAndPushNamed(context, AddClient.routeName);
      },
    );
    final cubit = BlocProvider.of<LanguageCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(cubit.tUpdateOrder()),
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
              cartbloc.add(InitializeCart());
              Navigator.popAndPushNamed(context, AllOrdersScreen.routeName);
              return;
            } else if (state is OrderUpdatingFailed) {
              print("order update fail");
              progress?.dismiss();
              setState(() {
                desc = state.message;
              });
              dialog..show();
              BlocProvider.of<AddClientBloc>(context)
                  .add(ClientDisplayEvent(client: widget.order.client!));
              ordersbloc.add(SetRequestEvent(request: request));
            } else if (state is FetchingOrderToBeUpdatedSuccess) {
              request = state.request;
              progress?.dismiss();
              orderToBeUpdated = state.data.data;
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
                        productId: item.data.id,
                        slectedIds: getSelectedAttrId2(item.productAttributes)),
                  ),
                );
              }
              List<Data> cartData = cartbloc.state.cartProducts;
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
                  List<int> itemSelectedIds =
                      getSelectedAttrId1(item.selectedAttributes);
                  print("item ---selected --ids");
                  print(itemSelectedIds);
                  for (var i = 0; i < orderToBeUpdated.length; i++) {
                    List<int> selectedIds = getSelectedAttrId2(
                        orderToBeUpdated[i].productAttributes);
                    print("here ---selected --ids---");
                    print(selectedIds);
                    if (orderToBeUpdated[i].data.id == item.id &&
                        selectedIds == itemSelectedIds) {
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
                      productAttributes: getProductAttribute(item),
                    ));
                  }
                  ordersbloc.add(
                    AddToCart(
                      cart: CartItem(
                        quantity: item.order,
                        id: -1,
                        productId: item.id,
                        slectedIds: itemSelectedIds,
                      ),
                    ),
                  );
                }
              }
              addClientBloc.add(ClientDisplayEvent(client: state.client!));
              ordersbloc.add(ClientAddEvent(client: state.client!));
              ordersbloc.add(AddPaidAmountEvent(
                amount: state.request.amountPaid?.toInt() ?? 0,
              ));
              setState(() {
                paid = state.request.amountPaid?.toInt() ?? 0;
              });
              ordersbloc.add(AddRemainingAmountEvent(
                  amount: (price - paid - currentPaid).toInt()));
              int addrId = 0;
              if (state.addressId != null) {
                addrId = state.addressId!;
              }
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
                            cubit.tCART(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.popAndPushNamed(
                                  context,
                                  MainScreen.routeName,
                                  arguments: 1,
                                );
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
                                  cubit.tAdd(),
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
                                          attribute: getAttribute(
                                              orderToBeUpdated[index]
                                                      .productAttributes ??
                                                  []),
                                          remove: remove,
                                          decreasePrice: decreasePrice,
                                          increasePrice: addPrice,
                                          order: orderToBeUpdated[index],
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
                    UpdatePaymentContainer(
                      formKey: _formKey,
                      onAddPaidPressed: this.addPaidAmount,
                    ),
                    state.request.paymentWhen == "now"
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
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
                                        cubit.tRemainingAmount(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text('${state.request.amountRemaining}')
                                    ],
                                  ),
                                ),
                              ), // ClientDataRow(
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    ConditionalButton(
                      name: cubit.tUPDATEORDER(),
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            if (state.request.clientId != null) {
                              int total = price.toInt();
                              ordersbloc.add(AddTotalEvent(total: total));
                              print("Order method is invoked");
                              ordersbloc.add(AddRemainingAmountEvent(
                                  amount: values.Remaining.toInt()));

                              ordersbloc.add(
                                  UpdateOrderEvent(request: state.request));
                              addClientBloc.add(ClientSearchEvent());
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
    ordersbloc.add(
        AddRemainingAmountEvent(amount: (price - paid - currentPaid).toInt()));
  }

  void remove(OrderToBeUpdated data, double priceY) {
    orderToBeUpdated.remove(data);
    decreasePrice(priceY);
  }

  void decreasePrice(double priceX) {
    setState(() {
      price -= priceX;
    });
    ordersbloc.add(AddTotalEvent(total: price.toInt()));
    ordersbloc.add(AddRemainingAmountEvent(amount: (price - paid).toInt()));
  }

  void addPaidAmount(String value) async {
    if (value == "") {
      value = "0";
    }
    double val = 0;
    try {
      setState(() {
        currentPaid = double.parse(value).toInt();
      });
    } catch (e) {
      print(e);
    }
    val = price - paid - currentPaid;
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

List<ProductAttribute> getProductAttribute(Data product) {
  List<ProductAttribute> attr = [];
  for (int i = 0; i < product.selectedAttributes!.length; i++) {
    List<Attributes> attributes =
        product.selectedAttributes as List<Attributes>;
    attr.add(ProductAttribute(
      id: attributes[i].id ?? 0,
      name: attributes[i].name ?? "",
      value: attributes[i].pivot?.value ?? "",
    ));
  }
  return attr;
}

class Attribute {
  String color;
  String size;
  Attribute({
    required this.color,
    required this.size,
  });
}

Attribute getAttribute(List<ProductAttribute> attributes) {
  String selectedColor = '';
  String size = '';
  for (int i = 0; i < attributes.length; i++) {
    if (attributes[i].name == "Color") {
      selectedColor = attributes[i].value;
    } else if (attributes[i].name == "Size") {
      size = attributes[i].value;
    }
  }
  return Attribute(color: selectedColor, size: size);
}

List<int> getSelectedAttrId1(List<Attributes>? atr) {
  List<int> ids = [];
  if (atr != null) {
    for (var item in atr) {
      if (item.id != null) {
        ids.add(item.id as int);
      }
    }
  }
  return ids;
}

List<int> getSelectedAttrId2(List<ProductAttribute>? atr) {
  List<int> ids = [];
  if (atr != null) {
    for (var item in atr) {
      ids.add(item.id);
    }
  }
  return ids;
}
