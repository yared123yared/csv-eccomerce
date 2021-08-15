import 'package:app/data_provider/product_data_provider.dart';
import 'package:app/models/product/data.dart';

class ProductRepository {
  late final ProductDataProvider productDataProvider;
  final int? categoryId;

  ProductRepository({required this.productDataProvider, this.categoryId});

  Future<List<Data>> getProducts(int page, int? catId) async {
    List<Data> data = await productDataProvider.getProducts(page, catId);
    print("Data arrived at the data provider $data");
    return data;
  }
}
