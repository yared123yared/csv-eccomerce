// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class DailyChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // const cutOffYValue = 5.0;
//     const dateTextStyle = TextStyle(
//         fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold);

//     return AspectRatio(
//       aspectRatio: 2.4,
//       child: Padding(
//         padding: EdgeInsets.only(left: 12, right: 24),
//         child: LineChart(
//           LineChartData(
//             lineBarsData: [
//               LineChartBarData(
//                 spots: [
//                   FlSpot(0, 3.5),
//                   FlSpot(1, 4.5),
//                   FlSpot(2, 1),
//                   FlSpot(3, 4),
//                   FlSpot(4, 6),
//                   FlSpot(5, 6.5),
//                   FlSpot(6, 6),
//                 ],
//                 isCurved: true,
//                 barWidth: 2,
//                 colors: [
//                   Color(0xff2a244d),
//                 ],
//                 belowBarData: BarAreaData(
//                   show: true,
//                   colors: [
//                     Color(0xff858eab),
//                   ],
//                 ),
//                 dotData: FlDotData(
//                   show: true,
//                 ),
//               ),
//             ],
//             minY: 0,
//             titlesData: FlTitlesData(
//               show: true,
//               topTitles: SideTitles(showTitles: false),
//               rightTitles: SideTitles(showTitles: false),
//               bottomTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 14,
//                   interval: 1,
//                   getTextStyles: (context, value) => dateTextStyle,
//                   getTitles: (value) {
//                     switch (value.toInt()) {
//                       case 0:
//                         return '08/18';
//                       case 1:
//                         return '08/20';
//                       case 2:
//                         return '08/22';
//                       case 3:
//                         return '08/24';
//                       case 4:
//                         return '08/25';
//                       case 5:
//                         return '08/26';
//                       case 6:
//                         return '08/28';

//                       default:
//                         return '';
//                     }
//                   }),
//               leftTitles: SideTitles(
//                 showTitles: true,
//                 interval: 1,
//                 reservedSize: 40,
//                 getTitles: (value) {
//                   switch (value.toInt()) {
//                     case 1:
//                       return '5k';
//                     case 2:
//                       return '10k';
//                     case 3:
//                       return '15k';
//                     case 4:
//                       return '20k';
//                     case 5:
//                       return '25k';
//                     case 6:
//                       return '30k';
//                     case 7:
//                       return '35k';
//                     case 8:
//                       return '40k';
//                     case 9:
//                       return '45k';
//                     case 10:
//                       return '50k';
//                   }
//                   return '';
//                 },
//                 getTextStyles: (context, value) =>
//                     TextStyle(color: Colors.black, fontSize: 12.0),
//               ),
//             ),
//             // axisTitleData: FlAxisTitleData(
//             //   bottomTitle: AxisTitle(
//             //       showTitle: true,
//             //       margin: 0,
//             //       textStyle: dateTextStyle,
//             //       textAlign: TextAlign.right),
//             // ),
//             gridData: FlGridData(
//               show: true,
//               drawVerticalLine: false,
//               horizontalInterval: 1,
//               checkToShowHorizontalLine: (double value) {
//                 return value == 1 || value == 6 || value == 4 || value == 5;
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
