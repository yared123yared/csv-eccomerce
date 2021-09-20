import 'dart:convert';
import 'dart:io';
import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadSlipContainer extends StatefulWidget {
  @override
  _UploadSlipContainerState createState() => _UploadSlipContainerState();
}

class _UploadSlipContainerState extends State<UploadSlipContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
        final cubit = PaymentsCubit.get(context);
        final cubits = BlocProvider.of<LanguageCubit>(context);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
          ),
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cubit.isComeImageName
                        ? Expanded(
                            child: Text(
                              "${cubit.imageName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              Text(
                                cubits.tUploadSlip(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                ),
                              ),
                            ],
                          ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        minimumSize: const Size(90, 40),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        cubit.pickerCamera();
                      },
                      child: Text(
                        cubits.tBrowse(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
