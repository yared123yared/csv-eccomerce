import 'package:app/Blocs/currency/bloc/currencysymbol_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TitleContainers extends StatefulWidget {
  final String text;
  final String number;
  final String image;
  final Color color;
  final Color imagebackgroundcolor;
  final double fontValue;
  final double fonttext;

  const TitleContainers({
    required this.text,
    required this.number,
    required this.image,
    required this.color,
    required this.imagebackgroundcolor,
    required this.fontValue,
    required this.fonttext,
  });

  @override
  State<TitleContainers> createState() => _TitleContainersState();
}

class _TitleContainersState extends State<TitleContainers> {
  late CurrencySymbolbloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<CurrencySymbolbloc>(context);
    bloc.add(FeatchCurrencysymbolEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  backgroundColor: widget.imagebackgroundcolor,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    width: 32,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.fonttext,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: BlocBuilder<CurrencySymbolbloc, CurrencysymbolState>(
              builder: (context, state) {
                if (state is CurrencysymbolLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CurrencysymbolSuccessState) {
                  return Text(
                    "${state.symbolModel.symbol} ${widget.number}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.fontValue,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
