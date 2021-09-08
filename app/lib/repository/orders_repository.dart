import 'package:app/data_provider/orders_data_provider.dart';
import 'package:app/data_provider/product_data_provider.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/request.dart';

class OrderRepository {
  late final OrderDataProvider orderDataProvider;
  late Request request;

  OrderRepository({required this.orderDataProvider});

  Future<bool> createOrder(Request? request) async {
    bool data = (await orderDataProvider.createOrder(request));
    print("Data arrived at the data provider $data");
    return data;
  }

  Future<List<OrderToBeUpdated>> OrderData(String id) async {
    return await orderDataProvider.OrderData(id);
  }

  Future<bool> UpdateOrder(Request request) async {
    return await orderDataProvider.updateOrder(request);

  }
}
