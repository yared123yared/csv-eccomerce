import 'dart:convert';

import 'package:app/models/client_address_id/address_Id_model.dart';
import 'package:app/models/client_address_id/clients_address_id.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class ClientAddressDataProvider {
  final UserPreferences userPreferences;

  ClientAddressDataProvider(this.userPreferences);

  Future<List<ClientsAddressIdModel>> getClientAddressId() async {
    String? token = await this.userPreferences.getUserToken();
    late List<ClientsAddressIdModel> clientsAddressId = [];

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/clients');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData['clients'];
        return data
            .map((clientaddressId) => clientsAddressId
                .add(ClientsAddressIdModel.fromJson(clientaddressId)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return clientsAddressId;
  }

  Future<List<AddressIdModel>> getAddressId(int id) async {
    String? token = await this.userPreferences.getUserToken();
    late List<AddressIdModel> clientsAddressId = [];

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/clients/${id}');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData['addresses'];
        return data
            .map((addressId) =>
                clientsAddressId.add(AddressIdModel.fromJson(addressId)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return clientsAddressId;
  }
}
