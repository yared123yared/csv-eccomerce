part of 'bankslip_bloc.dart';

@immutable
abstract class BankslipState {}

class BankslipInitial extends BankslipState {}

class BankslipLoadingState extends BankslipState {}

class BankslipSuccessState extends BankslipState {
  final List<DataPayment> bankslip;

  BankslipSuccessState(this.bankslip);
}

class BankslipErrorState extends BankslipState {
  final String message;

  BankslipErrorState(this.message);
}

class SearchBankslipLoadingState extends BankslipState {}

class SearchBankslipSuccessState extends BankslipState {
  final List<DataPayment> searchBankslip;

  SearchBankslipSuccessState(this.searchBankslip);
}
