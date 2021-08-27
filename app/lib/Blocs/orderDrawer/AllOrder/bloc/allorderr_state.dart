part of 'allorderr_bloc.dart';

@immutable
abstract class AllorderrState {}

class AllorderrInitial extends AllorderrState {}

class AllOrderrLoadingState extends AllorderrState {}

class AllOrdersSuccessState extends AllorderrState {
  final List<DataAllOrders> allorderdata;

  AllOrdersSuccessState(this.allorderdata);
}

class AllorderrErrorState extends AllorderrState {
  final String message;

  AllorderrErrorState(this.message);
}

class SearchAllOrderLoading extends AllorderrState {}

class SearchDataSccessState extends AllorderrState {
  final List<DataAllOrders> searchallorderdata;

  SearchDataSccessState(this.searchallorderdata);
}
