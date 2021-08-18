// import 'package:app/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class DateCardSalesReport extends StatefulWidget {
//   final String selectedDate;

//   DateCardSalesReport({required this.selectedDate});
//   @override
//   _DateCardSalesReportState createState() => _DateCardSalesReportState();
// }

// class _DateCardSalesReportState extends State<DateCardSalesReport> {
//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     setState(() {
//       if (args.value is DateTime) {
//         widget.selectedDate =
//             DateFormat('dd/MM/yyyy').format(args.value).toString();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           margin: const EdgeInsets.fromLTRB(50, 150, 50, 20),
//           child: SfDateRangePicker(
//             view: DateRangePickerView.year,
//             onSelectionChanged: _onSelectionChanged,
//             showActionButtons: true,
//             backgroundColor: primaryColor,
//             monthCellStyle: DateRangePickerMonthCellStyle(
//               blackoutDateTextStyle: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             cancelText: 'CANCEL',
//             confirmText: 'OK',
//             selectionTextStyle: TextStyle(color: primaryColor),
//             headerStyle: DateRangePickerHeaderStyle(
//               backgroundColor: primaryColor,
//               textStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onCancel: () {
//               Navigator.pop(context);
//             },
//             onSubmit: (Object value) {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
