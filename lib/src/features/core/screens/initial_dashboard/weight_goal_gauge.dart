import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeightGoalGaugeCard extends StatelessWidget {
  final String weightGoal;

  const WeightGoalGaugeCard({
    Key? key,
    required this.weightGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pointerValue = _getPointerValueFromWeightGoal(weightGoal);

    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: -3,
                  maximum: 3,
                  interval: 1,
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: pointerValue,
                      needleColor: Colors.blue, // Color of the needle
                      needleLength: 0.6, // Length of the needle
                      needleStartWidth: 1, // Starting width of the needle
                      needleEndWidth: 5, // End width of the needle
                      knobStyle: KnobStyle(
                        knobRadius: 0.08, // Radius of the knob
                        color: Colors.white, // Color of the knob
                        borderColor: Colors.blue, // Border color of the knob
                        borderWidth: 0.05, // Border width of the knob
                      ),
                    ),
                  ],
                  showLabels: false, // Don't show labels
                  showTicks: false,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: -3, endValue: -2, color: Colors.redAccent),
                    GaugeRange(
                        startValue: -2, endValue: -1, color: Colors.orange),
                    GaugeRange(
                        startValue: -1, endValue: 0, color: Colors.yellow),
                    GaugeRange(
                        startValue: 0, endValue: 1, color: Colors.lightGreen),
                    GaugeRange(startValue: 1, endValue: 2, color: Colors.green),
                    GaugeRange(
                        startValue: 2, endValue: 3, color: Colors.greenAccent),
                  ],
                ),
              ],
            ),
            Text(
              weightGoal,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  double _getPointerValueFromWeightGoal(String weightGoal) {
    switch (weightGoal) {
      case 'WeightGoal.maintainWeight':
        return 0;
      case 'WeightGoal.mildWeightLoss':
        return -1;
      case 'WeightGoal.weightLoss':
        return -2;
      case 'WeightGoal.extremeWeightLoss':
        return -3;
      case 'WeightGoal.mildWeightGain':
        return 1;
      case 'WeightGoal.weightGain':
        return 2;
      case 'WeightGoal.extremeWeightGain':
        return 3;
      default:
        return 0; // Default case to handle unexpected values
    }
  }
}
