class PdfModel {
  late String pdfUrlString;

  PdfModel.fromJson(Map<String, dynamic> json) {
    pdfUrlString = json['url'];
  }
}
