import 'package:app/Blocs/Payments/bloc/bankslip_bloc.dart';
import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DataPaymentsContainer extends StatefulWidget {
  @override
  _DataPaymentsContainerState createState() => _DataPaymentsContainerState();
}

class _DataPaymentsContainerState extends State<DataPaymentsContainer> {
  late BankslipBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<BankslipBloc>(context);
    bloc.add(FeatchBankslipEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BankslipBloc, BankslipState>(
      builder: (context, state) {
        if (state is BankslipInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BankslipLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BankslipSuccessState) {
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
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
                          text: 'DATE',
                          // dateApi:
                          //     "${cubit.payMentContainerModel.data![index].date}",
                          dateApi: "${state.bankslip[index].date}"),
                      buildrowData(
                          text: 'AMOUNT',
                          // dateApi:
                          //     "${cubit.payMentContainerModel.data![index].amount}",
                          dateApi: "${state.bankslip[index].amount}"),
                      // buildrowData(
                      //   text: 'SLIP',
                      //   dateApi: "",
                      // ),

                      BlocBuilder<PaymentsCubit, PaymentsState>(
                        builder: (context, state) {
                          final cubits = PaymentsCubit.get(context);
                          return builDowanloadImage(
                            onpress: () {
                              cubits.saveImage(index: index);
                              if (cubits.isImageLoding = true) {
                                Fluttertoast.showToast(
                                    msg: "Successful Download",
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
                        text: 'STATUS',
                        // dateApi:
                        //     '${cubit.payMentContainerModel.data![index].status}',
                        dateApi: "${state.bankslip[index].status}",
                      ),
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
                                'DENY REASON',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // if (cubit.payMentContainerModel.data![index]
                          //         .reasonDenied ==
                          //     null)
                          if (state.bankslip[index].reasonDenied == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 15),
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
                              padding: const EdgeInsets.only(top: 8, left: 15),
                              child: Container(
                                height: 25,
                                width: 150,
                                child: Text(
                                  // "${cubit.payMentContainerModel.data![index].reasonDenied}",
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
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: state.bankslip.length,
          );
        } else if (state is BankslipErrorState) {
          return ErrorWidget(state.message.toString());
        }
        return Container();
      },
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

  Widget builDowanloadImage({required Function onpress}) => Row(
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
                "SLIP",
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
