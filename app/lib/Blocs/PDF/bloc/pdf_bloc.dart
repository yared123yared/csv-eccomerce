import 'dart:async';

import 'package:app/data_provider/pdf/pdf_data_provider.dart';
import 'package:app/models/pdf/pdf_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final PdfDataProvider pdfDataProvider;
  PdfBloc(this.pdfDataProvider) : super(PdfInitial());

  @override
  Stream<PdfState> mapEventToState(
    PdfEvent event,
  ) async* {
    if (event is FeatchPdfEvent) {
      yield PdfLoadingState();
      try {
        final pdfUrl = await pdfDataProvider.getPdfScreen(event.pdfId);
        yield PdfSuccessState(pdfUrl);
      } catch (e) {
        yield PdfErrorState(e.toString());
      }
    }
  }
}
