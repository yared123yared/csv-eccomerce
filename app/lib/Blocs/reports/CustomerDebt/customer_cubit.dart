import 'package:app/Blocs/reports/CustomerDebt/customer_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDebtCubit extends Cubit<CustomerDebttState> {
  CustomerDebtCubit() : super(CustomerDebtInitialState());

  static CustomerDebtCubit get(BuildContext context) =>
      BlocProvider.of(context);
}
