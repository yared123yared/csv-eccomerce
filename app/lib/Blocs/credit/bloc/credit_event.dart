part of 'credit_bloc.dart';

abstract class CreditEvent extends Equatable {
  const CreditEvent();

  @override
  List<Object> get props => [];
}

class CreditInitialization extends CreditEvent {
  // final String credit;

  CreditInitialization();
}

class CreditUpdate extends CreditEvent {
  final int credit;
  CreditUpdate({required this.credit});
}
