import 'package:app/Blocs/currency/bloc/currencysymbol_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPrice extends StatefulWidget {
  final String? productPrice;
  ProductPrice({required this.productPrice});

  @override
  State<ProductPrice> createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  late CurrencySymbolbloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CurrencySymbolbloc>(context);
    bloc.add(FeatchCurrencysymbolEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("+++++arrived at price widget");
    return BlocBuilder<CurrencySymbolbloc, CurrencysymbolState>(
      builder: (context, state) {
        if (state is CurrencysymbolLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CurrencysymbolSuccessState) {
          return Text(
            "\$${widget.productPrice}",
            style: TextStyle(fontWeight: FontWeight.w600),
          );
        }
        return Container();
      },
    );
  }
}
