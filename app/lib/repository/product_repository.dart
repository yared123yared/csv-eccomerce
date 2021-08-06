import 'package:app/data_provider/product_data_provider.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:app/preferences/user_preference_data.dart';

class ProductRepository {
  late final ProductDataProvider productDataProvider;
  ProductRepository({
    required this.productDataProvider,
  });

  Future<List<Data>> getProducts(int page) async {
    List<Data> data = await productDataProvider.getProducts(page);
    print("Data arrived at the data provider $data");
    return data;
  }
}
