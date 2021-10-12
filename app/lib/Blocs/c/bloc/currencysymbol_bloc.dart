
import 'package:app/data_provider/currencySymbol/symbolDataProvider.dart';
import 'package:app/models/symbolModel/symbolModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'currencysymbol_event.dart';
part 'currencysymbol_state.dart';

class CurrencySymbolbloc
    extends Bloc<CurrencysymbolEvent, CurrencysymbolState> {
  final SymbolDataProvider symbolDataProvider;
  CurrencySymbolbloc(this.symbolDataProvider) : super(CurrencysymbolInitial());

  @override
  Stream<CurrencysymbolState> mapEventToState(
    CurrencysymbolEvent event,
  ) async* {
    if (event is FeatchCurrencysymbolEvent) {
      yield CurrencysymbolLoadingState();
      try {
        final symbol = await symbolDataProvider.getSymbol();
        yield CurrencysymbolSuccessState(symbol);
      } catch (e) {
        yield CurrencysymbolErrorState(e.toString());
      }
    }
  }
}
