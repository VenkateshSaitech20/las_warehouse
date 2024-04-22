 

// import 'package:flutter/material.dart';
// import 'package:las_warehouse/app/data/my_colors.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class chart_screen extends StatefulWidget {
//   const chart_screen({super.key});

//   @override
//   State<chart_screen> createState() => _chart_screenState();
// }

// class _chart_screenState extends State<chart_screen> {
//   @override
//   Widget build(BuildContext context) {
//     const List<ChartData> chartData = [
//       ChartData('Jan', 30, 40, 70, 80),
//       ChartData('Feb', 20, 40, 73, 81),
//       ChartData('Mar', 27, 40, 74, 82),
//       ChartData('Apr', 57, 40, 75, 83),
//       ChartData('May', 30, 40, 77, 84),
//       ChartData('Jly', 41, 40, 80, 85),
//       ChartData('Aug', 45, 40, 80, 86),
//       ChartData('Sep', 48, 40, 80, 87),
//       ChartData('Oct', 61, 40, 80, 88),
//       ChartData('Nov', 65, 40, 80, 89),
//       ChartData('Dec', 68, 40, 80, 90),
//     ];

//     return Scaffold(
//         body: SafeArea(
//       child: Column(
//         children: [
//           Card(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Text(
//                     "BOOKINGS PER MONTH",
//                     style: TextStyle(color: MyColors.grey),
//                   ),
//                 ),
//                 Container(
//                   child: SfCartesianChart(
//                     primaryXAxis: CategoryAxis(interval: 20),
//                     annotations: const <CartesianChartAnnotation>[],
//                     series: <ChartSeries<ChartData, String>>[
//                       ColumnSeries<ChartData, String>(
//                           dataSource: chartData,
//                           xValueMapper: (ChartData data, _) => data.x,
//                           yValueMapper: (ChartData data, _) => data.y,
//                           color: MyColors.primarypurple),
//                       ColumnSeries<ChartData, String>(
//                           dataSource: chartData,
//                           xValueMapper: (ChartData data, _) => data.x,
//                           yValueMapper: (ChartData data, _) => data.y1,
//                           color: MyColors.primaryGreen),
//                       ColumnSeries<ChartData, String>(
//                           dataSource: chartData,
//                           xValueMapper: (ChartData data, _) => data.x,
//                           yValueMapper: (ChartData data, _) => data.y2,
//                           color: MyColors.primaryLight),
//                       ColumnSeries<ChartData, String>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.x,
//                         yValueMapper: (ChartData data, _) => data.y3,
//                         color: MyColors.grey,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         child: Container(
//                           color: Colors.green,
//                           width: MediaQuery.of(context).size.width / 5,
//                           child: Text(
//                             "Roadways",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.primaryLight),
//                           ),
//                         ),
//                         onTap: (() {
//                           //print("hi");
//                         }),
//                       ),
//                       InkWell(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 5,
//                           child: Text(
//                             "Seaways",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.primaryGreen),
//                           ),
//                         ),
//                         onTap: () {
//                           //print("hello");
//                         },
//                       ),
//                       InkWell(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 5,
//                           child: Text(
//                             "Airways",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.primarypurple),
//                           ),
//                         ),
//                         onTap: (() {
//                           //print("test");
//                         }),
//                       ),
//                       InkWell(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 5,
//                           child: Text(
//                             "Railways",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey),
//                           ),
//                         ),
//                         onTap: (() {
//                           //print("demo");
//                         }),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// class ChartData {
//   const ChartData(this.x, this.y, this.y1, this.y2, this.y3);
//   final String x;
//   final int y;
//   final int y1;
//   final int y2;
//   final int y3;
// }
