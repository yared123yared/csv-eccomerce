part of 'currencysymbol_bloc.dart';

@immutable
abstract class CurrencysymbolState {}

class CurrencysymbolInitial extends CurrencysymbolState {}

class CurrencysymbolLoadingState extends CurrencysymbolState {}

class CurrencysymbolSuccessState extends CurrencysymbolState {
  final SymbolModel symbolModel;

  CurrencysymbolSuccessState(this.symbolModel);
}

class CurrencysymbolErrorState extends CurrencysymbolState {
  final String error;

  CurrencysymbolErrorState(this.error);
}

