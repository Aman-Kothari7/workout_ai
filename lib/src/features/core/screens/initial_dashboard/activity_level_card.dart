import 'package:flutter/material.dart';

enum ActivityLevel {
  little,
  oneToThree,
  fourToFive,
  daily,
  intense,
}

class ActivityLevelCard extends StatelessWidget {
  final String? currentActivityLevel;

  const ActivityLevelCard({super.key, required this.currentActivityLevel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActivityIcon(
                  activityLevel: "ActivityLevel.little",
                  iconData: Icons.chair,
                ),
                _buildActivityIcon(
                  activityLevel: "ActivityLevel.oneToThree",
                  iconData: Icons.directions_walk,
                ),
                _buildActivityIcon(
                  activityLevel: "ActivityLevel.fourToFive",
                  iconData: Icons.directions_run,
                ),
                _buildActivityIcon(
                  activityLevel: "ActivityLevel.daily",
                  iconData: Icons.directions_bike,
                ),
                _buildActivityIcon(
                  activityLevel: "ActivityLevel.intense",
                  iconData: Icons.fitness_center,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              currentActivityLevel.toString(),
              // _getActivityLevelText(currentActivityLevel!),
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

  Widget _buildActivityIcon({
    required String activityLevel,
    required IconData iconData,
  }) {
    bool isSelected = activityLevel == currentActivityLevel;
    double iconSize = isSelected ? 40 : 30;
    Color iconColor = isSelected ? Colors.blue : Colors.black;

    return Icon(
      iconData,
      size: iconSize,
      color: iconColor,
    );
  }

  // String _getActivityLevelText(String activityLevel) {
  //   switch (activityLevel) {
  //     case "ActivityLevel.little":
  //       return "Little Activity";
  //     case "ActivityLevel.oneToThree":
  //       return "1-3 Times a Week";
  //     case "ActivityLevel.fourToFive":
  //       return "4-5 Times a Week";
  //     case "ActivityLevel.daily":
  //       return "Daily Activity";
  //     case "ActivityLevel.intense":
  //       return "Intense Exercise";
  //     default:
  //       return "";
  //   }
  // }
}
