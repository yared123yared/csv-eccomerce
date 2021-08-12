import 'package:app/Blocs/reports/cubit/report_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitialState());

  static ReportCubit get(BuildContext context) => BlocProvider.of(context);

  bool isFormDate = false;
  bool isToDate = false;
  bool isDate = false;

  DateTime dateForm = DateTime.now();
  DateTime dateTo = DateTime.now();
  DateTime dateDATE = DateTime.now();

  Future<Null> selectFormTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateForm,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateForm) {
      dateForm = picked;
      isFormDate = true;
    }
    emit(SelectFormTimePickerState());
  }

  Future<Null> selectToTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTo,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateTo) {
      dateTo = picked;

      isToDate = true;
    }
    emit(SelectToTimePickerState());
  }

  Future<Null> selectDateTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateDATE,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateDATE) {
      dateDATE = picked;

      isDate = true;
    }
    emit(SelectDateTimePickerState());
  }
  //DropItem

  //Search Controller
  TextEditingController orderController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  TextEditingController debtController = TextEditingController();

  //clear
  void clearAll() {
    isFormDate = false;
    isToDate = false;
    isDate = false;
    orderController.clear();
    clientNameController.clear();
    totalController.clear();
    paidController.clear();
    debtController.clear();
    emit(ClearAllButtonState());
  }

  void clearDateOnly() {
    isDate = false;
    emit(ClearDateOnlyState());
  }
}
