import 'package:app/Widget/Home/product-detail/select_option.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDescription extends StatelessWidget {
  final Data product;
  ProductDescription({required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Text(cubit.tDescriptioncomeshere());
  }
}
