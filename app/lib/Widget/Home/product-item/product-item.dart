import 'dart:ffi';

import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/models/product/attributes.dart';
import 'package:app/models/product/data.dart';
import 'package:app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'conditional.dart';

class ProductItem extends StatefulWidget {
  final Data product;

  // final VoidCallback onPressed;

  ProductItem({required this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
    String image =
        'https://csv.jithvar.com/storage/${this.widget.product.photos![0].filePath.toString()}';
    // print(image);
    return InkWell(
      onTap: () {
        Data product = new Data(
            attributes: widget.product.attributes,
            categories: widget.product.categories,
            currencyId: widget.product.currencyId,
            id: widget.product.id,
            manufacturerId: widget.product.manufacturerId,
            model: widget.product.model,
            name: widget.product.name,
            photos: widget.product.photos,
            price: widget.product.price,
            quantity: widget.product.quantity,
            status: widget.product.status,
            // photos:
            // data.photos,
            selectedAttributes: widget.product.selectedAttributes!
                .map((e) => new Attributes(
                      companyId: e.companyId,
                      createdAt: e.createdAt,
                      id: e.id,
                      name: e.name,
                      pivot: e.pivot,
                      updatedAt: e.updatedAt,
                    ))
                .toList());
        Navigator.pushNamed(context, ProductDetail.routeName, arguments: [
          product,
          this.onClicked,
        ]);
        // setState(() {
        //   // product.id = widget.products.id;
        //   // product.copyWith(widget.product);

        // });
        // cartBloc.add(AddProduct(singleProduct: widget.product));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 1,
          margin: EdgeInsets.all(10),
          child: Conditional(
            name: this.widget.product.name.toString(),
            image: image,
            value: this.widget.product.order,
            product: this.widget.product,
            onClick: this.onClicked,
          ),
        ),
      ),
    );
  }

  void onClicked() {
    print("item add method have called");
    setState(() {
      print("Products: ${widget.product.attributes!.length}");
      widget.product.order += 1;
    });
  }
}
