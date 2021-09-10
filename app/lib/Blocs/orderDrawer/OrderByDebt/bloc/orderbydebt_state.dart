part of 'orderbydebt_bloc.dart';

@immutable
abstract class OrderbydebtState {}

class OrderbydebtInitial extends OrderbydebtState {}

class OrderbydebtLoadingState extends OrderbydebtState {}

class OrderbydebtSuccessState extends OrderbydebtState {
  final List<DataOrderByDebt> orderbydept;
  final List<double> grandTotalInt;
  final List<double> debtTotalInt;

  OrderbydebtSuccessState(
    this.orderbydept,
    this.grandTotalInt,
    this.debtTotalInt,
  );
}

class OrderbydebtErrorState extends OrderbydebtState {
  final String message;

  OrderbydebtErrorState(this.message);
}

class SearchOrderByDebtLoading extends OrderbydebtState {}

class SearchOrderByDebtSccessState extends OrderbydebtState {
  final List<double> searchgrandTotalInt;
  final List<double> searchdebtTotalInt;

  final List<DataOrderByDebt> searchOrderByDebt;

  SearchOrderByDebtSccessState(
    this.searchOrderByDebt,
    this.searchdebtTotalInt,
    this.searchgrandTotalInt,
  );
}
