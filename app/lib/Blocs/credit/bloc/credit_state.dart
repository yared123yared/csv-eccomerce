part of 'credit_bloc.dart';

class CreditState {
  String? credit;
  String? creditLimitStartDate;
  String? creditLimitEndDate;

  CreditState(
      {required this.credit,
      this.creditLimitStartDate,
      this.creditLimitEndDate});
}

class CreditUpdated extends CreditState {
  final String credit;
  final String creditLimitStartDate;
  final String creditLimitEndDate;

  CreditUpdated(
      {required this.credit,
      required this.creditLimitStartDate,
      required this.creditLimitEndDate})
      : super(
            credit: credit,
            creditLimitEndDate: creditLimitEndDate,
            creditLimitStartDate: creditLimitStartDate);
}

class CreditUpdateLoading extends CreditState {
  CreditUpdateLoading() : super(credit: null, creditLimitEndDate: null, creditLimitStartDate: null);
 
}
