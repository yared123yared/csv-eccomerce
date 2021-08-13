import 'dart:convert';
import 'dart:io';

import 'package:app/models/search.dart';
import 'package:app/preferences/user_preference_data.dart';

import '../models/client.dart';
import 'package:http/http.dart' as http;

class ClientsDataProvider {
  final http.Client httpClient;
  final UserPreferences userPreferences;

  ClientsDataProvider(
      {required this.httpClient, required this.userPreferences});

  final String baseUrl = 'http://csv.jithvar.com/api/v1';

  Future<ClientAutogenerated> getClients(
      SearchData searchData, int page) async {
    print("client fetching");

    ClientAutogenerated clientsPaginated;
    final urlCl = Uri.parse('${baseUrl}/paginated-clients?page=${page}');
    String? token = await this.userPreferences.getUserToken();

    try {
      // print(token);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['draw'] = 0;
      data['length'] = 5;
      data['search'] = "";
      data['column'] = 0;
      data['field'] = "";
      data['relationship'] = false;
      data['relationship_field'] = "";
      data['dir'] = "asc";
      final response = await http.post(urlCl,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
          body: jsonEncode(searchData));

      print("getting clients-1---,${response.statusCode}");

      if (response.statusCode != 200) {
        print("---48");
        throw HttpException('200');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        // print(extractedData);
        clientsPaginated = ClientAutogenerated.fromJson(extractedData);
        print("getting clients-1---,${extractedData.length}");
      }
    } catch (e) {
      print("---58");
      print(e);
      throw e;
    }
    return clientsPaginated;
  }

  Future<void> deleteClient(String id) async {
    final urlDl = Uri.parse('${baseUrl}/clients/${id}}');
    String? token = await this.userPreferences.getUserToken();
    try {
      final response = await http.delete(
        urlDl,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      print("response---${response.statusCode}");
      // print(jsonDecode(response.body)['message']);
      if (response.statusCode != 204) {
        throw HttpException(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<void> createClient(CreateEditData data) async {
    final String urlCreate = '${baseUrl}/clients';
    String? token = await this.userPreferences.getUserToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(urlCreate),
    );

    request.headers['Authorization'] = "Bearer $token";
    request.headers['Accept'] = "application/json";
    print("first_name");
    print(data.firstName);
    try {
      request.fields['first_name'] = data.firstName;
      request.fields['last_name'] = data.lastName;
      request.fields['mobile'] = data.mobile;
      request.fields['email'] = data.email;
      if (data.uploadedPhoto != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'uploaded_photo', data.uploadedPhoto!));
      }
      if (data.documents != null && data.uploadedPhoto != '') {
        for (var doc in data.documents!) {
          if(doc.path !=''){
            request.files.add(await http.MultipartFile.fromPath(
                'documents[${doc.name}]', doc.path));
          }

        }
      }

      if (data.addresses != null) {
        int i = 1;
        for (var address in data.addresses) {
          String x =
              '{"id":"","street_number":"${address.streetAddress}","sublocality_level_1":"${address.locality}","locality":"${address.locality}","administrative_area_level_1":"${address.state}","country":"${address.country}","postal_code":"${address.zipCode}","is_billing":${address.isBilling},"is_default":${address.isDefault}}';
          request.fields['addresses[$i]'] = x;
          i++;
        }
      }

      var res = await request.send();
      final respStr = await res.stream.bytesToString();
      print('---create client--${res.statusCode}');
      print(respStr);
      print("--create client");
      if (res.statusCode != 201) {
        throw HttpException('Error Occured While Creating User');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateClient(CreateEditData data) async {
    final String urlUpdate = '${baseUrl}/clients/${data.id}';
    String? token = await this.userPreferences.getUserToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(urlUpdate),
    );

    request.headers['Authorization'] = "Bearer $token";
    request.headers['Accept'] = "application/json";

    try {
      print("9999");

      request.fields['first_name'] = data.firstName;
      request.fields['last_name'] = data.lastName;
      request.fields['mobile'] = data.mobile;
      request.fields['email'] = data.email;
      request.fields['id'] = data.id as String;
      request.fields['_method'] = 'PUT';
      if (data.uploadedPhoto != null && data.uploadedPhoto != '') {
        request.files.add(await http.MultipartFile.fromPath(
            'uploaded_photo', data.uploadedPhoto!));
      }
      if (data.documents != null) {
        for (var doc in data.documents!) {
          request.files.add(await http.MultipartFile.fromPath(
              'documents[${doc.name}]', doc.path));
        }
      }

      if (data.addresses != null) {
        int i = 1;
        for (var address in data.addresses) {
          String x =
              '{"id":"","street_number":"${address.streetAddress}","sublocality_level_1":"${address.locality}","locality":"${address.locality}","administrative_area_level_1":"${address.state}","country":"${address.country}","postal_code":"${address.zipCode}","is_billing":${address.isBilling},"is_default":${address.isDefault}}';
          request.fields['addresses[$i]'] = x;
          i++;
        }
      }

      var res = await request.send();
      final respStr = await res.stream.bytesToString();
      print('---update client--${res.statusCode}');
      print(respStr);
      print("--update client");
      if (res.statusCode != 200) {
        throw HttpException('Error Occured While Updating User');
      }
    } catch (e) {
      throw e;
    }
  }
}

class PostClientData {
  String? id;
  String? streetNumber;
  String? sublocality1;
  String? locality;
  String? administrativeAreaLevel;
  String country;
  String? postalCode;
  bool? is_billing;
  bool? is_default;
  PostClientData({
    required this.country,
    this.administrativeAreaLevel,
    this.id,
    this.is_billing,
    this.is_default,
    this.locality,
    this.postalCode,
    this.streetNumber,
    this.sublocality1,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street_number'] = this.streetNumber;
    data['sublocality_level_1'] = this.sublocality1;
    data['locality'] = this.locality;
    data['administrative_area_level_1'] = this.administrativeAreaLevel;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['is_billing'] = this.is_billing;
    data['is_default'] = this.is_default;
    return data;
  }
}

// {"id":"",
// "street_number":"",
// "sublocality_level_1":"",
// "locality":"SanJose",
// "administrative_area_level_1":"CA",
// "country":"UnitedStates",
// "postal_code":"",
// "is_billing":true,
// "is_default":false}
