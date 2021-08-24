import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
        final cubit = PaymentsCubit.get(context);
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              height: 50,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextFormField(
                  //controller: cubit.searchController,

                  keyboardType: TextInputType.text,

                  onFieldSubmitted: (String value) {
                    cubit.amount = int.parse(value);
                    cubit.uploadImage(
                      date: "",
                    );
                  },
                  onChanged: (String value) {},
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 10,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
