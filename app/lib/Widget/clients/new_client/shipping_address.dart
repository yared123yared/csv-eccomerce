import 'package:app/Blocs/location/bloc/location_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:geocoding/geocoding.dart';

class Shipping extends StatefulWidget {
  List<Widget> textInput;
  Function onNextPressed;
  Function onDefaultAddressPressed;
  Function onBillingAddressPressed;
  Function onAddNewPressed;
  Function prevAdressHandler;
  Function nextAddressHandler;
  Function onCurrrentAddressFetchSuccessState;
  bool isDefault;
  bool isBilling;
  final bool isCreating;
  Shipping({
    required this.textInput,
    required this.onNextPressed,
    required this.onDefaultAddressPressed,
    required this.onBillingAddressPressed,
    required this.onAddNewPressed,
    required this.isDefault,
    required this.isBilling,
    required this.nextAddressHandler,
    required this.prevAdressHandler,
    required this.onCurrrentAddressFetchSuccessState,
    required this.isCreating,
  });

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  bool isShowing = false;
  Placemark? p;
  bool isSuccess = false;

  // @override
  // void initState() {
  //   super.initState();
  //   if (isSuccess) {
  //     if (WidgetsBinding.instance != null) {
  //       WidgetsBinding.instance!.addPostFrameCallback((_) {
  //         print("hi---");
  //         widget.onCurrrentAddressFetchSuccessState(p);
  //       });
  //     }
  //   }
  // }
  Map<String, dynamic> initialValues={
    'state':'',
    'city':'',
    'country':'',
    'street_adress':'',
    'zip_code':'',
    'locality':''
  };
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (widget.isCreating) {
          print("creating");
          final progress = ProgressHUD.of(context);
          if (state is LocationFetchingState) {
            print("lock fetching");

            if (!isShowing) {
              if (progress != null) {
                setState(() {
                  isShowing = true;
                });
                print("---start showing--");
                progress.showWithText('Fetching current location!');
                print("---started--");
              }
            }
          } else if (state is LocationFetchingSuccessState) {
            print("location fetch success");
            if (progress != null) {
              setState(() {
                isShowing = false;
              });
              progress.dismiss();
            }
            // widget.onCurrrentAddressFetchSuccessState(state.p);
          } else if (state is LocationFetchingFailedState) {
            print("location fetch failed");

            // if (isShowing) {
            setState(() {
              isShowing = false;
            });
            if (progress != null) {
              progress.dismiss();
              //     // progress.dispose();
            }
            AwesomeDialog(
              context: context,
              dialogType: DialogType.NO_HEADER,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Failed to fetch location info',
              desc: 'Please fill the form manually',
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
        } else {
          print("not creating");
        }
      },
      // listenWhen: (prevState, currentState) {
      //   print("hash codes");
      //   print(prevState.hashCode);
      //   print(currentState.hashCode);
      //   return true;
      // },
      builder: (context, state) {
        // if (widget.isCreating) {
        //   // print("creating");
        //   // final progress = ProgressHUD.of(context);
        //   // if (state is LocationFetchingState) {
        //   //   print("lock fetching");

        //   //   if (!isShowing) {
        //   //     if (progress != null) {
        //   //       setState(() {
        //   //         isShowing = true;
        //   //       });
        //   //       print("---start showing--");
        //   //       progress.showWithText('Fetching current location!');
        //   //       print("---started--");
        //   //     }
        //   //   }
        //   // } else
        if (state is LocationFetchingSuccessState) {
          //     // print("location fetch success");
          //     // if (progress != null) {
          //     //   setState(() {
          //     //     isShowing = false;
          //     //   });
          //     //   progress.dismiss();
          //     // }
              widget.onCurrrentAddressFetchSuccessState(state.p);
          //   }
          print(state.status);
          p = state.p;
          isSuccess = true;
        }
        return ProgressHUD(
          child: Column(
            children: [
              ...this.widget.textInput.map(
                    (e) => Column(
                      children: [
                        e,
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Switch(
                        value: this.widget.isBilling,
                        onChanged: (val) =>
                            this.widget.onBillingAddressPressed(),
                      ),
                      Text(
                        'Billing Address',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => this.widget.prevAdressHandler(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () => this.widget.nextAddressHandler(),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Switch(
                        value: this.widget.isDefault,
                        onChanged: (val) =>
                            this.widget.onDefaultAddressPressed(),
                      ),
                      Text(
                        'Default Address',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => this.widget.onAddNewPressed(),
                    child: Text(
                      'Add New',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
