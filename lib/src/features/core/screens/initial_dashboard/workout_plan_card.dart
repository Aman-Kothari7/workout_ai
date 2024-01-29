import 'package:flutter/material.dart';

class WorkoutPlanCard extends StatelessWidget {
  final Function() onCardTap;

  const WorkoutPlanCard({Key? key, required this.onCardTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card configuration
      child: InkWell(
        onTap: onCardTap,
        // Rest of the InkWell and Card configuration
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Generate Workout Plan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
