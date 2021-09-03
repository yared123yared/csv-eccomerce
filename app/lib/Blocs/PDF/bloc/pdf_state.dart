part of 'pdf_bloc.dart';

@immutable
abstract class PdfState {}

class PdfInitial extends PdfState {}

class PdfLoadingState extends PdfState {}

class PdfSuccessState extends PdfState {
  final PdfModel pdfUrl;

  PdfSuccessState(this.pdfUrl);
}

class PdfErrorState extends PdfState {
  final String message;

  PdfErrorState(this.message);
}
