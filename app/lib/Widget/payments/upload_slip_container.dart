import 'dart:convert';
import 'dart:io';
import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
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
  // File? file;

  // Future pickerCamera() async {
  //   final myFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     file = File(myFile!.path);
  //   });
  // }

  // Future uploadImage() async {
  //   if (file == null) return;

  //   String base64 = base64Encode(file!.readAsBytesSync());
  //   String imageName = file!.path.split("/").last;
  //   //print(base64);
  //   final url = Uri.parse('http://csv.jithvar.com/api/v2/user-cash');
  //   await http.post(url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization':
  //             'Bearer 2608|xAcZUbFNkZpRW4l3nNDv8D27PpNZ7Jn1497j8KUm',
  //       },
  //       body: jsonEncode({
  //         "amount": 9939,
  //         "date": "2021-08-23",
  //         "uploaded_photo": "data:image/jpeg;base64,$base64"
  //       }));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
        final cubit = PaymentsCubit.get(context);
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
                                "Upload Slip",
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
                      child: const Text(
                        "Browse",
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
