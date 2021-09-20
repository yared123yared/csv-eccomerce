import 'dart:typed_data';

import 'package:app/Blocs/Payments/bloc/bankslip_bloc.dart';
import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/payment/payment_container_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DataPaymentsContainer extends StatefulWidget {
  @override
  _DataPaymentsContainerState createState() => _DataPaymentsContainerState();
}

class _DataPaymentsContainerState extends State<DataPaymentsContainer> {
  late BankslipBloc bloc;
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  List<DataPayment> dataPayment = [];
  List<DataPayment> searchDataPayment = [];

  int start = 0;
  int end = 0;
  int total = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<BankslipBloc>(context);
    bloc.add(FeatchBankslipEvent());
    super.initState();
    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (dataPayment.isNotEmpty) {
              if (dataPayment.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );
    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (searchDataPayment.isNotEmpty) {
              if (searchDataPayment.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );
  }

  //Dowanload Image

  saveImage(String url) async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Column(
      children: [
        BlocBuilder<BankslipBloc, BankslipState>(
          builder: (context, state) {
            if (state is BankslipSuccessState) {
              return Text(
                "${cubit.tshowing()}  ${start} ${cubit.tTo()} ${total} ${cubit.tOf()} ${total} ${cubit.tentries()}",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else if (state is SearchBankslipSuccessState) {
              return Text(
                "${cubit.tshowing()} ${start} to ${cubit.tTo()} ${cubit.tOf()} ${total} ${cubit.tentries()}",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else {
              return Text(
                "Showing 1 to 5 of 5 entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        BlocBuilder<BankslipBloc, BankslipState>(
          builder: (context, state) {
            if (state is BankslipInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BankslipLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BankslipSuccessState) {
              dataPayment = state.bankslip;
              if (state.bankslip.isNotEmpty) {
                total = state.bankslip.length;
              }
              return Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.bankslip.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      child: Container(
                        width: 400,
                        height: 210,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buildrowData(
                                text: cubit.tDATE(),
                                dateApi: "${state.bankslip[index].date}"),
                            buildrowData(
                                text: cubit.tAMOUNT(),
                                dateApi: "${state.bankslip[index].amount}"),
                            builDowanloadImage(
                              slip: cubit.tSLIP(),
                              onpress: () {
                                saveImage(
                                    "https://csv.jithvar.com/storage/${state.bankslip[index].photo!.filePath}");

                                Fluttertoast.showToast(
                                    msg: cubit.tSuccessfulDownload(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                            ),
                            buildrowData(
                              text: cubit.tSTATUS(),
                              dateApi: "${state.bankslip[index].status}",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 20),
                                  child: Container(
                                    height: 25,
                                    width: 150,
                                    color: Colors.white,
                                    child: Text(
                                      cubit.tDENYREASON(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (state.bankslip[index].reasonDenied == null)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 15),
                                    child: Container(
                                      height: 25,
                                      width: 150,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 15),
                                    child: Container(
                                      height: 25,
                                      width: 150,
                                      child: Text(
                                        "${state.bankslip[index].reasonDenied}",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is SearchBankslipLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SearchBankslipSuccessState) {
              searchDataPayment = state.searchBankslip;
              if (state.searchBankslip.isNotEmpty) {
                total = state.searchBankslip.length;
              }
              return Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.searchBankslip.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      child: Container(
                        width: 400,
                        height: 210,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buildrowData(
                                text: cubit.tDATE(),
                                dateApi: "${state.searchBankslip[index].date}"),
                            buildrowData(
                                text: cubit.tAMOUNT(),
                                dateApi:
                                    "${state.searchBankslip[index].amount}"),
                            BlocBuilder<PaymentsCubit, PaymentsState>(
                              builder: (context, state) {
                                final cubits = PaymentsCubit.get(context);
                                return builDowanloadImage(
                                  slip: cubit.tSLIP(),
                                  onpress: () {
                                    cubits.saveImage(index: index);
                                    if (cubits.isImageLoding = true) {
                                      Fluttertoast.showToast(
                                          msg: cubit.tSuccessfulDownload(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                );
                              },
                            ),
                            buildrowData(
                              text: cubit.tSTATUS(),
                              dateApi: "${state.searchBankslip[index].status}",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 20),
                                  child: Container(
                                    height: 25,
                                    width: 150,
                                    color: Colors.white,
                                    child: Text(
                                      cubit.tDENYREASON(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (state.searchBankslip[index].reasonDenied ==
                                    null)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 15),
                                    child: Container(
                                      height: 25,
                                      width: 150,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 15),
                                    child: Container(
                                      height: 25,
                                      width: 150,
                                      child: Text(
                                        "${state.searchBankslip[index].reasonDenied}",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is BankslipErrorState) {
              return ErrorWidget(state.message.toString());
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget buildrowData({
    required String text,
    required String dateApi,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20),
            child: Container(
              height: 25,
              width: 150,
              color: Colors.white,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 15),
            child: Container(
              height: 25,
              width: 150,
              child: Text(
                dateApi,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );

  Widget builDowanloadImage(
          {required Function onpress, required String slip}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20),
            child: Container(
              height: 25,
              width: 150,
              color: Colors.white,
              child: Text(
                slip,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff2bce89),
                minimumSize: const Size(2, 4),
                shape: StadiumBorder(),
              ),
              onPressed: () {
                onpress();
              },
              icon: Icon(
                Icons.download,
              ),
              label: Text(""),
            ),
          ),
        ],
      );
}
