import 'dart:convert';
import 'dart:io';

import 'package:app/preferences/user_preference_data.dart';

import '../models/client.dart';
import 'package:http/http.dart' as http;

class ClientsDataProvider {
  final http.Client httpClient;
  final UserPreferences userPreferences;

  ClientsDataProvider(
      {required this.httpClient, required this.userPreferences});

  final String baseUrl = 'http://csv.jithvar.com/api/v1';

  Future<ClientAutogenerated> getClients(int page) async {
    ClientAutogenerated clientsPaginated;
    final urlCl = Uri.parse('${baseUrl}/paginated-clients?page=${page}');
    String? token = await this.userPreferences.getUserToken();

    try {
      print(token);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['draw'] = 0;
      data['length'] = 5;
      data['search'] = "";
      data['column'] = 0;
      data['field'] = "";
      data['relationship'] = false;
      data['relationship_field'] = "";
      data['dir'] = "";
      final response = await http.post(urlCl,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
          body: jsonEncode({
            "draw": 0,
            "length": 10,
            "search": "",
            "column": 0,
            "field": "",
            "relationship": false,
            "relationship_field": "",
            "dir": "asc",
          }));
      if (response.statusCode != 200) {
    
        throw HttpException('200');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        print(extractedData);
        clientsPaginated = ClientAutogenerated.fromJson(extractedData);

      }
    } catch (e) {
      throw e;
    }
    return clientsPaginated;
  }
  // Future<void> createClient()
}
