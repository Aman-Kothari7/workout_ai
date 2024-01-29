import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalorieBarChartCard extends StatelessWidget {
  final double consumedCalories;
  final double totalCalories;

  const CalorieBarChartCard({
    Key? key,
    required this.consumedCalories,
    required this.totalCalories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double remainingCalories = totalCalories - consumedCalories;
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          annotations: <CartesianChartAnnotation>[
            CartesianChartAnnotation(
              widget: Container(
                child: Text(
                  'Deficit: ${remainingCalories.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              coordinateUnit: CoordinateUnit.point,
              x: 'Calories',
              y: consumedCalories + remainingCalories / 2,
            ),
          ],
          series: <StackedColumnSeries<ChartData, String>>[
            StackedColumnSeries<ChartData, String>(
              dataSource: [ChartData('Calories', consumedCalories)],
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              name: 'Consumed',
              color: Colors.blue,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle: TextStyle(fontSize: 10),
              ),
            ),
            //Sometimes following series taking value 0
            StackedColumnSeries<ChartData, String>(
              dataSource: [ChartData('Calories', remainingCalories)],
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              name: 'Remaining',
              color: Colors.grey,
              dataLabelSettings: DataLabelSettings(
                isVisible: false,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle: TextStyle(fontSize: 10),
              ),
            ),
          ],
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
