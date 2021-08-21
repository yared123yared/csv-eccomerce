import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
        final cubit = PaymentsCubit.get(context);
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              height: 40,
              child: TextFormField(
                controller: cubit.searchController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (String value) {},
                onChanged: (String value) {},
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
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
