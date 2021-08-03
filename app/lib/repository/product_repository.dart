import 'package:app/data_provider/product_data_provider.dart';
import 'package:app/models/product/product.dart';
import 'package:app/preferences/user_preference_data.dart';

class ProductRepository {
  final ProductDataProvider? productDataProvider;
  ProductRepository({
    required this.productDataProvider,
  });

  Future<Products> getProducts() async {
    return await productDataProvider!.getProducts();
  }
}
