import 'package:app/Blocs/currency/bloc/currencysymbol_bloc.dart';
import 'package:app/Widget/Home/product-detail/select_option.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailContainer extends StatefulWidget {
  final Data product;
  DetailContainer({required this.product});

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  late CurrencySymbolbloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CurrencySymbolbloc>(context);
    bloc.add(FeatchCurrencysymbolEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Column(
      children: [
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.02,
        // ),
        Row(
          children: [
            Text(
              cubit.tPRICE(),
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            BlocBuilder<CurrencySymbolbloc, CurrencysymbolState>(
              builder: (context, state) {
                if (state is CurrencysymbolSuccessState) {
                  return Text(
                    "${state.symbolModel.symbol}${widget.product.price}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            Text(
              "Model",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: AutoSizeText(
                "${widget.product.model}",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                maxLines: 1,
              ),
            ),
            // Text(
            //   "${product.model}",
            //   style: TextStyle(
            //       fontSize: 16,
            //       color: Colors.black,
            //       fontWeight: FontWeight.w300),
            // ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            Text(
              "SKU",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: AutoSizeText(
                "12",
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
