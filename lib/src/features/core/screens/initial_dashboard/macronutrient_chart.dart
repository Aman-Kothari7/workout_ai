// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class MacronutrientChart extends StatelessWidget {
//   final double proteinGrams;
//   final double carbGrams;
//   final double fatGrams;
//   final double totalCalories;

//   MacronutrientChart({
//     required this.proteinGrams,
//     required this.carbGrams,
//     required this.fatGrams,
//     required this.totalCalories,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SfCircularChart(
//       annotations: <CircularChartAnnotation>[
//         CircularChartAnnotation(
//           widget: Container(
//             child: Text(
//               totalCalories.toStringAsFixed(2),
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//       legend: Legend(
//         isVisible: false,
//         position: LegendPosition.left,
//         overflowMode: LegendItemOverflowMode.wrap,
//         iconHeight: 15,
//         iconWidth: 15,
//         textStyle: TextStyle(fontSize: 12), // Corrected TextStyle
//       ),
//       series: <CircularSeries>[
//         DoughnutSeries<ChartData, String>(
//           dataSource: <ChartData>[
//             ChartData('Protein', proteinGrams),
//             ChartData('Carbs', carbGrams),
//             ChartData('Fat', fatGrams),
//           ],
//           xValueMapper: (ChartData data, _) => data.category,
//           yValueMapper: (ChartData data, _) => data.value,
//           pointColorMapper: (ChartData data, _) => data.category == 'Protein'
//               ? Colors.green
//               : data.category == 'Carbs'
//                   ? Colors.blue
//                   : Colors.red,
//           // Update the dataLabelMapper to only return the value
//           dataLabelMapper: (ChartData data, _) =>
//               '${data.value.toStringAsFixed(2)}g',
//           radius: '60%', // Adjust the radius if needed
//           innerRadius: '55%', // Adjust the inner radius if needed
//           dataLabelSettings: DataLabelSettings(
//             isVisible: true,
//             labelPosition: ChartDataLabelPosition
//                 .inside, // This positions the labels inside the doughnut segments
//             textStyle: TextStyle(
//               color: Colors.white,
//               fontSize: 10, // Adjust the data label font size if needed
//             ),
//           ),
//           legendIconType: LegendIconType.circle,
//         ),
//       ],
//     );
//   }
// }

// class ChartData {
//   ChartData(this.category, this.value);

//   final String category;
//   final double value;
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MacronutrientChartCard extends StatelessWidget {
  final double proteinGrams;
  final double carbGrams;
  final double fatGrams;
  final double totalCalories;

  const MacronutrientChartCard({
    Key? key,
    required this.proteinGrams,
    required this.carbGrams,
    required this.fatGrams,
    required this.totalCalories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Container(
        padding:
            EdgeInsets.all(16), // Ensure no additional padding inside the Card
        child: Container(
          width: double.infinity,
          height: 150,
          child: SfCircularChart(
            margin: EdgeInsets.zero, // Set chart margin to zero
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: Container(
                  child: Text(
                    totalCalories.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            legend: Legend(
              isVisible: true,
              position: LegendPosition.left,
              orientation: LegendItemOrientation.vertical,
              overflowMode: LegendItemOverflowMode.scroll,
              iconHeight: 15,
              iconWidth: 15,
              textStyle: TextStyle(fontSize: 12),
            ),
            series: <DoughnutSeries<ChartData, String>>[
              DoughnutSeries<ChartData, String>(
                dataSource: <ChartData>[
                  ChartData('Protein', proteinGrams),
                  ChartData('Carbs', carbGrams),
                  ChartData('Fat', fatGrams),
                ],
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) =>
                    data.category == 'Protein'
                        ? Colors.green
                        : data.category == 'Carbs'
                            ? Colors.blue
                            : Colors.red,
                dataLabelMapper: (ChartData data, _) =>
                    '${data.value.toStringAsFixed(2)}g',
                radius: '80%', // Expand the doughnut to fill the container
                innerRadius: '60%', // Adjust the inner radius if needed

                dataLabelSettings: DataLabelSettings(
                  isVisible: true, // Show the data labels
                  labelPosition:
                      ChartDataLabelPosition.outside, // Position labels outside
                  textStyle: TextStyle(
                    fontSize: 14, // Adjust font size for labels
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
