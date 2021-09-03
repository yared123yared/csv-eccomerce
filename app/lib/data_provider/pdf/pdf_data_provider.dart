import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/models/pdf/pdf_model.dart';
import 'package:app/preferences/user_preference_data.dart';

class PdfDataProvider {
  final UserPreferences userPreferences;

  PdfDataProvider(this.userPreferences);

  Future<PdfModel> getPdfScreen(int pdfId) async {
    String? token = await this.userPreferences.getUserToken();
    late PdfModel pdfScreen;
    try {
      final url = Uri.parse("http://csv.jithvar.com/api/v1/orders/pdf");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"id": pdfId}),
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        // print("================");
        // print(extractedData);
        // print("================");
        pdfScreen = PdfModel.fromJson(extractedData);
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return pdfScreen;
  }
}
