import 'dart:convert';
import 'dart:io';
import 'package:app/models/client.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/request.dart';
import 'package:app/models/response.dart';
import 'package:app/preferences/user_preference_data.dart';

import 'package:http/http.dart' as http;

class OrderDetail {
  List<OrderToBeUpdated> data;
  Client? client;
  int? addressId;
  OrderDetail({
    required this.data,
    this.addressId,
    this.client,
  });
}

class OrderDataProvider {
  final http.Client httpClient;
  final UserPreferences userPreferences;

  OrderDataProvider({required this.httpClient, required this.userPreferences});

  Future<APIResponse> createOrder(Request? request) async {
    String? token = await this.userPreferences.getUserToken();
    // late List<Data> products_return = [];
    // print(
    //     "+++++++++++++++++++++++++This is the cart:${request!.cart![0].selectedAttributes}");
    print(
        "+++++++++______++++++Data Entered  To Order Data Provider_________+++++++");
    print("Data: ${request!.toJson()}");
    print(
        "________++++++++_______:::::Cart: ${request.cart!.toList().map((e) => e.toJson())}");
    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders');

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "total": request.total,
            "payment_when": request.paymentWhen,
            "payment_method": request.paymentMethod,
            "type_of_wallet": request.typeOfWallet,
            "transaction_id": request.transactionId,
            "amount_paid": request.amountPaid,
            "amount_remaining": request.amountRemaining,
            "address_id": request.addressId,
            "client_id": request.clientId,
            "cart": request.cart
          }));

      print(
          "Http response ${response.statusCode} and response body ${response.body}");
      if (response.statusCode == 201) {

         return APIResponse(
            IsSuccess: true, Message: "ORDER CREATED SUCCESSFULLY");
      } else {
        // print(response.body);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
          return APIResponse(IsSuccess: false, Message: extractedData["message"]);
        // throw Exception('Failed to load courses');
        


      }
    } catch (e) {
      print("Exception throuwn $e");
    }

      return APIResponse(IsSuccess: false, Message: "Failed To Create Order");
  }

  Future<APIResponse> updateOrder(Request req) async {
    String? token = await this.userPreferences.getUserToken();
    print("---update order data provider");
    print("req--id--${req.id}");
    try {
      print(jsonEncode(req));
      print("------------");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
        'PUT',
        Uri.parse(
          'https://csv.jithvar.com/api/v1/orders/${req.id}',
        ),
      );
      request.body = json.encode(req);
      request.headers.addAll(headers);
      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        return APIResponse(
            IsSuccess: true, Message: "ORDER UPDATED SUCCE SSFULLY");

      } else {
        print("failed to update order");
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        print(response.statusCode);
        print(extractedData.toString());
        print(response.reasonPhrase);
        return APIResponse(IsSuccess: false, Message: extractedData["message"]);
      }
    } catch (e) {
      print("Exception thrown $e");
      
    }
    return APIResponse(IsSuccess: false, Message: "Failed To Update Order");
  }

  Future<OrderDetail> OrderData(String id) async {
    String? token = await this.userPreferences.getUserToken();
    List<OrderToBeUpdated> data = [];
    int? addressId;
    Client? client;
    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/${id}');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print("---fetch--order--detail---");
      print(
          "Http response ${response.statusCode} and response body ${response.body}");
      if (response.statusCode != 200) {
        print("---48");
        throw HttpException('200');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        print(extractedData);
        addressId = extractedData["address"]["id"];
        client = Client.fromJson(extractedData["client"]);
        if (extractedData['products'] != null) {
          extractedData['products'].forEach((v) {
            if (v != null) {
              if (v["product"] != null) {
                // print("data----");
                Data x = Data.fromJson(v["product"]);
                // print(jsonEncode(x).toString());
                x.quantity = v["quantity"];
                x.order = v["order"]["id"];
                int cartId = v["order"]["id"];
                int quantity = v["quantity"];
                double price = double.parse(v["price"]);
                double total = double.parse(v["total"]);
                // double remaining = double.parse(v["amount_remaining"]);
                // double paid = double.parse(v["amount_paid"]);

                OrderToBeUpdated cartX = new OrderToBeUpdated(
                  cartId: cartId,
                  data: x,
                  quantity: quantity,
                  total: total,
                  price: price,
                  // amountRemaining: remaining,
                );
                data.add(cartX);
              }
            }
          });
        }
        // print("----ordered product items---");
        // print(json.encode(data).toString);
        // print(data.length);
        return OrderDetail(data: data, addressId: addressId, client: client);
      }
    } catch (e) {
      print("Exception fetching order detail");
      print(e);
    }
    return OrderDetail(data: data, addressId: addressId, client: client);
  }
}
