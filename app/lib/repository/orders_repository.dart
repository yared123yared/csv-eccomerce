import 'package:app/data_provider/orders_data_provider.dart';
import 'package:app/data_provider/product_data_provider.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/request.dart';
import 'package:app/models/response.dart';

class OrderRepository {
  late final OrderDataProvider orderDataProvider;
  late Request request;

  OrderRepository({required this.orderDataProvider});

  Future<APIResponse> createOrder(Request? request) async {
    // bool data = (await orderDataProvider.createOrder(request));
    // print("Data arrived at the data provider $data");
    return await orderDataProvider.createOrder(request);
  }

  Future<OrderDetail> OrderData(String id) async {
    return await orderDataProvider.OrderData(id);
  }

  Future<APIResponse> UpdateOrder(Request request) async {
    return await orderDataProvider.updateOrder(request);

  }
}
