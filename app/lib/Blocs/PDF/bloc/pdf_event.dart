part of 'pdf_bloc.dart';

@immutable
abstract class PdfEvent {
  // const PdfEvent();
}

class FeatchPdfEvent extends PdfEvent {
  final int pdfId;

  FeatchPdfEvent(this.pdfId);
}
