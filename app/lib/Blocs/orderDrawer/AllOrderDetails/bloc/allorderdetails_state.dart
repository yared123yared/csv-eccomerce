part of 'allorderdetails_bloc.dart';

@immutable
abstract class AllorderdetailsState {}

class AllorderdetailsInitial extends AllorderdetailsState {}

class OrderDetailsALoadingState extends AllorderdetailsState {}

class OrderDetailsASuccessState extends AllorderdetailsState {
  final OrderDetailsAllModel orderDetailsAll;

  OrderDetailsASuccessState(this.orderDetailsAll);
}

class OrderDetailsAErrorState extends AllorderdetailsState {
  final String error;

  OrderDetailsAErrorState(this.error);
}

