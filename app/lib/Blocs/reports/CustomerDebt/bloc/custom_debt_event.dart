part of 'custom_debt_bloc.dart';

@immutable
abstract class CustomDebtEvent {
  const CustomDebtEvent();
}

class FeatchCustomDebtEvent extends CustomDebtEvent {}

class SearchCustomDebtEvent extends CustomDebtEvent {
  final String searchName;

  SearchCustomDebtEvent(this.searchName);
}
