import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/activity_level_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class initialDashboardScreen extends StatefulWidget {
  initialDashboardScreen({super.key});

  @override
  State<initialDashboardScreen> createState() => _initialDashboardScreenState();
}

class _initialDashboardScreenState extends State<initialDashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadGender();
    loadWeight();
    loadAge();
    loadWeightGoal();
    loadHeight();
    loadActivityLevel();
  }

  String? weightGoal;
  int? age;
  int? weight;
  String? gender;
  int? height;
  String? activityLevel;
  // final int? netCalories = calculateCalories();

  void loadWeightGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      weightGoal = prefs.getString('weightGoal') ?? (' ');
    });
  }

  void loadAge() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      age = prefs.getInt('age') ?? 0;
    });
  }

  void loadWeight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      weight = prefs.getInt('weight') ?? 0;
    });
  }

  void loadHeight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      height = prefs.getInt('height') ?? 0;
    });
  }

  void loadGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gender = prefs.getString('gender') ?? (' ');
    });
  }

  void loadActivityLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      activityLevel = prefs.getString('activityLevel') ?? (' ');
    });
  }

  double calculateBMR() {
    if (gender == 'Male') {
      return 10 * weight! + 6.25 * height! - 5 * age! + 5;
    } else if (gender == 'Female') {
      return 10 * weight! + 6.25 * height! - 5 * age! - 161;
    } else {
      return 1;
    }
  }

  double calculateBMI() {
    double heightInMeters = height! / 100;
    return weight! / (heightInMeters * heightInMeters);
  }

  double calculateCalories() {
    double bmr = calculateBMR();
    double activityFactor = 1.2; // Default for 'Little or no exercise'

    if (activityLevel == 'ActivityLevel.oneToThree') {
      activityFactor = 1.375;
    } else if (activityLevel == 'ActivityLevel.fourToFive') {
      activityFactor = 1.55;
    } else if (activityLevel == 'ActivityLevel.daily') {
      activityFactor = 1.725;
    } else if (activityLevel == 'ActivityLevel.intense') {
      activityFactor = 1.9;
    }

    double calories = bmr * activityFactor;

    switch (weightGoal) {
      case 'WeightGoal.maintainWeight':
        break;
      case 'WeightGoal.mildWeightLoss':
        calories -= 250;
        break;
      case 'WeightGoal.weightLoss':
        calories -= 500;
        break;
      case 'WeightGoal.extremeWeightLoss':
        calories -= 1000;
        break;
      case 'WeightGoal.mildWeightGain':
        calories += 250;
        break;
      case 'WeightGoal.weightGain':
        calories += 500;
        break;
      case 'WeightGoal.extremeWeightGain':
        calories += 1000;
        break;
    }

    return calories;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu), // Side panel menu icon
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Handle action
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Action 1',
                child: Text('Action 1'),
              ),
              const PopupMenuItem<String>(
                value: 'Action 2',
                child: Text('Action 2'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Generate workout plan
            },
            child: Text('Generate Workout Plan'),
          ),
          ElevatedButton(
            onPressed: () {
              // Generate meal plan
            },
            child: Text('Generate Meal Plan'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('AGE\n $age'),
                Text('HEIGHT\n $height'),
                Text('WEIGHT\n $weight'),
                Text('BMI\n26.1'),
                Text(calculateBMI().toStringAsFixed(2))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Calories\n518 cal'),
                Text(calculateCalories().toStringAsFixed(2)),
                Text('Protein\n32 g'),
                Text('Net Carbs\n32 g'),
                Text('Fat\n25 g'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('HOME'),
            Text('WORKOUT'),
            Text('MEAL'),
          ],
        ),
      ),
    );
  }
}
