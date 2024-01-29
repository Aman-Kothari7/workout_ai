import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiGaugeCard extends StatelessWidget {
  final double bmi;

  const BmiGaugeCard({
    Key? key,
    required this.bmi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String rangeName = _getRangeName(bmi);

    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SfLinearGauge(
              minimum: 10,
              maximum: 40,
              interval: 5,
              showLabels: true,
              showTicks: true,
              axisTrackStyle: LinearAxisTrackStyle(thickness: 8),
              markerPointers: [LinearShapePointer(value: bmi)],
              ranges: [
                LinearGaugeRange(
                  startValue: 10,
                  endValue: 18.5,
                  color: Colors.blueAccent,
                  startWidth: 8,
                  endWidth: 8,
                ),
                LinearGaugeRange(
                  startValue: 18.5,
                  endValue: 24.9,
                  color: Colors.green,
                  startWidth: 8,
                  endWidth: 8,
                ),
                LinearGaugeRange(
                  startValue: 24.9,
                  endValue: 29.9,
                  color: Colors.orange,
                  startWidth: 8,
                  endWidth: 8,
                ),
                LinearGaugeRange(
                  startValue: 29.9,
                  endValue: 40,
                  color: Colors.red,
                  startWidth: 8,
                  endWidth: 8,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              rangeName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRangeName(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 24.9) {
      return 'Healthy Weight';
    } else if (bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}
