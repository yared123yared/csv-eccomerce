part of 'custom_debt_bloc.dart';

@immutable
abstract class CustomDebtEvent {
  // List<Object> get props => [];
}

class FeatchCustomDebtEvent extends CustomDebtEvent {}

class SearchCustomDebtEvent extends CustomDebtEvent {
  final String searchName;

  SearchCustomDebtEvent(this.searchName);
}
