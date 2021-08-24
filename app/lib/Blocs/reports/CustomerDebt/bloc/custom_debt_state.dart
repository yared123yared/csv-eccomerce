part of 'custom_debt_bloc.dart';

@immutable
abstract class CustomDebtState {}

class CustomDebtInitial extends CustomDebtState {}

class CustomDebtLoadingState extends CustomDebtState {}

class CustomDebtSuccessState extends CustomDebtState {
  final List<DataCustomReport> customDebtData;

  CustomDebtSuccessState(this.customDebtData);
}

class CustomDebtErrorState extends CustomDebtState {
  final String message;

  CustomDebtErrorState(this.message);
}
