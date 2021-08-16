import 'package:app/data_provider/categories_data_provider.dart';
import 'package:app/data_provider/product_data_provider.dart';
import 'package:app/models/category/categories.dart';
import 'package:app/models/product/data.dart';

class CategoryRepository {
  late final CategoriesDataProvider categoryDataProvider;
  CategoryRepository({
    required this.categoryDataProvider,
  });

  Future<List<Categories>> getCategories() async {
    List<Categories> data = await categoryDataProvider.getCategories();
    print("Data arrived at the data provider $data");
    return data;
  }
}
