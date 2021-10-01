import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
        final cubit = PaymentsCubit.get(context);
        // final cubits = BlocProvider.of<LanguageCubit>(context);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
          ),
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cubit.isFormDate
                    ? Text(
                        cubit.dateFromText,
                        //"${cubit.dateForm.day.toString()}-${cubit.dateForm.month.toString()}-${cubit.dateForm.year.toString()}",
                        //"${cubit.dateFromText}",
                        style: TextStyle(
                          color: Color(0xff414e79),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    : Row(
                        children: [
                          Text(
                            "Date",
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
                TextButton.icon(
                  onPressed: () {
                    cubit.selectFormTimePicker(context);
                    cubit.uploadImage(
                      date: cubit.dateFromText,
                      
                     
                    );
                  },
                  icon: Image.asset(
                    'assets/images/date.png',
                    width: 30,
                    height: 30,
                  ),
                  label: Text(
                    '',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
