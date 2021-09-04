part of 'bankslip_bloc.dart';

@immutable
abstract class BankslipEvent {
  const BankslipEvent();
}

class FeatchBankslipEvent extends BankslipEvent {}

class SearchBankslipEvent extends BankslipEvent {
  final String searchAmount;

  SearchBankslipEvent(this.searchAmount);
}
