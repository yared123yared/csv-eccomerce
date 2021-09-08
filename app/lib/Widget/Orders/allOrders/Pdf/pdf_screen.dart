import 'dart:convert';
import 'package:app/preferences/user_preference_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:http/http.dart' as http;

class PdafScreen extends StatefulWidget {
  static const routeName = "/PdafScreen";
  final int pdfNumberId;

  PdafScreen(this.pdfNumberId);

  @override
  _PdafScreenState createState() => _PdafScreenState();
}

class _PdafScreenState extends State<PdafScreen> {
  late PdfViewerController _pdfViewerController;

  Map<String, dynamic>? urlImagePdf;
  bool isComeData = false;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();

    getPdfScreen(widget.pdfNumberId);

    super.initState();
  }

  @override
  void dispose() {
    // bloc.close();
    super.dispose();
  }

  final UserPreferences userPreferences = UserPreferences();

  Future getPdfScreen(int pdfId) async {
    String? token = await userPreferences.getUserToken();

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
        setState(() {
          isComeData = false;
        });
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        urlImagePdf = extractedData;

        //pdfScreen = PdfModel.fromJson(extractedData);
      } else {
        setState(() {
          isComeData = true;
        });

        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CSV",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _pdfViewerController.zoomLevel = 1.25;
            },
            icon: Icon(Icons.zoom_in),
          ),
        ],
      ),
      body: urlImagePdf == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SfPdfViewer.network(
              "https://csv.jithvar.com${urlImagePdf!['url']}",
              controller: _pdfViewerController,
            ),
    );
  }
}
