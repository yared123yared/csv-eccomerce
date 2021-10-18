import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/client_address/address/bloc/address_id_bloc.dart';
import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Blocs/credit/bloc/credit_bloc.dart';
import 'package:app/Blocs/location/bloc/location_bloc.dart';

import 'package:app/Blocs/orders/bloc/orders_bloc.dart';

import 'package:app/Widget/Home/cart/add-client/Price-info.dart';
import 'package:app/Widget/Home/cart/add-client/next-button.dart';
import 'package:app/Widget/Home/cart/add-client/upper-container.dart';

import 'package:app/Widget/Home/cart/payment/payment-container.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';

import 'package:app/logic/cart_logic.dart';
import 'package:app/models/login_info.dart';
import 'package:app/models/request/payment.dart';
import 'package:app/models/users.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/screens/cart_screens/cart_screen.dart';
import 'package:app/screens/orders_screen/all_orders_screen.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sms/sms.dart';

import '../main_screen.dart';

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
  late CreditBloc creditBloc;
  late ClientsBloc clientBloc;
  int? adreessyy;
  @override
  Widget build(BuildContext context) {
    late AddressIdBloc bloc;

    final cubit = BlocProvider.of<LanguageCubit>(context);
    @override
    void initState() {
      bloc = BlocProvider.of<AddressIdBloc>(context);
      bloc.add(FeatchAddressIdEvent(cubit.addersIdy));

      super.initState();
    }

    // this.isShowing = false;
    clientBloc = BlocProvider.of<ClientsBloc>(context);

    creditBloc = BlocProvider.of<CreditBloc>(context);
    ordersbloc = BlocProvider.of<OrdersBloc>(context);
    cartbloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    CartLogic cartLogic = new CartLogic(products: []);
    ScrollController _scrollController = ScrollController();
    TextEditingController payingTimeController = new TextEditingController();
    ordersbloc.add(PaymentInitialization());
    clientBloc.add(FetchClientsEvent(loadMore: false));
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            cubit.tAddClient(),
          ),
        ),
        // bottomNavigationBar: ,
        backgroundColor: Theme.of(context).accentColor,
        body: ProgressHUD(
          child: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is OrderIsBeingCreating) {
                print("+++++++++++++OrderIsBeingCreating+++++++++++++++++");
                final progress = ProgressHUD.of(context);
                // if (!isShowing) {
                //   if (progress != null) {
                //     setState(() {
                //       isShowing = true;
                //     });

                // }
                setState(() {
                  isShowing = true;
                });

                if (isShowing == true) {
                  progress!.showWithText("Creating");
                }
              } else if (state is OrderCreatedSuccess) {
                // this.isShowing = false;
                print("Amount Paid: ${state.request.amountPaid}");
                creditBloc.add(CreditUpdate());
                String message = "This is a test message!";
                List<String> recipents = ["916897173", "0939546094"];

                _sendSMS(message, recipents);
                cartbloc.add(InitializeCart());
                productBloc.add(FetchProduct());
                Navigator.popAndPushNamed(context, AllOrdersScreen.routeName);
                // return Container(child: Text("Created Successfully"));
              } else if (state is OrderCreatingFailed) {
                print("+++++++++++++Order creatign failed++++++++");

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.BOTTOMSLIDE,
                  title: "Failed to create order",
                  desc:  state.message!=null? state.message:"There is not description",
                  // btnCancelOnPress: () {
                  //   Navigator.popAndPushNamed(context, AddClient.routeName);
                  //   //      setState(() {
                  //   //   isShowing = false;
                  //   // });
                  // },
                  btnOkOnPress: () {
                    Navigator.popAndPushNamed(context, MainScreen.routeName,
                        arguments: 2);
                    //      setState(() {
                    //   isShowing = false;
                    // });
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
                      BlocListener<AddressIdBloc, AddressIdState>(
                        listener: (context, statey) {
                          if (statey is AddressIdLoadedState) {
                            adreessyy = statey.addressesId[0].id;
                          }
                        },
                        child: ConditionalButton(
                          name: cubit.tOrder(),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              if (state.request.clientId != null) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                print("Order method is invoked");
                                // ordersbloc
                                    // .add(AddAddressIdEvent(id: adreessyy!));
                                // print(
                                //     "adreessyy adreessyy adreessyy adreessyy ");
                                // print(adreessyy);
                                // print(
                                //     "adreessyy adreessyy adreessyy adreessyy ");
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
                        ),
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

  void _sendSMS(String message, List<String> recipents) async {
    bool connected = await ConnectionChecker.CheckInternetConnection();
    if (!connected) {
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo loggedUserInfo =
          await userPreference.getUserInformation() as LoggedUserInfo;
      User user = loggedUserInfo.user as User;

      SmsSender sender = SmsSender();
      String address = user.company!.mobile as String;

      SmsMessage message = SmsMessage(address, 'New Order Created!');
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          print("SMS is sent!");
        } else if (state == SmsMessageState.Delivered) {
          print("SMS is delivered!");
        }
      });
      sender.sendSms(message);
    }
  }
}
