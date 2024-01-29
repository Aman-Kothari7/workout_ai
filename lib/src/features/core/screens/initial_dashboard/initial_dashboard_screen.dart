import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/activity_level_screen.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/activity_level_card.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/bmi_gauge.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/calorie_bar_chart.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/macronutrient_chart.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/meal_plan_card.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/user_info_card.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/weight_goal_gauge.dart';
import 'package:login_flutter_app/src/features/core/screens/initial_dashboard/workout_plan_card.dart';
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
    loadGender();
    loadWeight();
    loadAge();
    loadWeightGoal();
    loadHeight();
    loadActivityLevel();
    super.initState();
  }

  String? weightGoal = 'WeightGoal.maintainWeight';
  int? age = 21;
  int? weight = 70;
  String? gender;
  int? height = 150;
  String? activityLevel;
  List<double>? macros;
  double? heightInCM = 150;
  String? heightDisplay;
  String weightDisplay =
      ''; // To hold the displayed weight (e.g., "70 kg" or "154 lbs")
  double weightInKg = 0.0; // To store the weight in kg for calculations
  // final int? netCalories = calculateCalories();

  void loadHeight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isCM = prefs.getBool('isCM') ?? true; // Get the selected unit

    if (isCM) {
      heightInCM = (prefs.getInt('heightCM') ?? 0).toDouble();
      heightDisplay = '$heightInCM cm';
    } else {
      final int heightInInches = prefs.getInt('heightInches') ?? 0;
      final int feet = heightInInches ~/ 12;
      final int inches = heightInInches % 12;
      heightInCM = (feet * 30.48 + inches * 2.54).toDouble();
      heightDisplay = '$feet ft $inches in';
    }

    setState(() {});
  }

  Future<void> loadWeight() async {
    final prefs = await SharedPreferences.getInstance();
    final isKg = prefs.getBool('isKg') ?? true; // Default to kg if not set

    if (isKg) {
      final double weightInKgStored = prefs.getDouble('weight') ?? 0.0;
      setState(() {
        weightDisplay = '$weightInKgStored kg'; // Display in kg
        weightInKg = weightInKgStored; // Store in kg for calculations
      });
    } else {
      final double weightInLbs = prefs.getDouble('weight') ?? 0.0;
      setState(() {
        weightDisplay = '$weightInLbs lbs'; // Display in lbs
        weightInKg = weightInLbs * 0.453592; // Convert to kg for calculations
      });
    }
  }

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

  // void loadWeight() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     weight = prefs.getInt('weight') ?? 0;
  //   });
  // }

  // void loadHeight() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     height = prefs.getInt('height') ?? 0;
  //   });
  // }

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

  List<double> calculateMacronutrients(double calories) {
    // Define the macronutrient percentages
    final proteinPercentage = 0.30;
    final carbPercentage = 0.40;
    final fatPercentage = 0.30;

    // Calculate grams of each macronutrient
    final proteinGrams = (calories * proteinPercentage / 4).toDouble();
    final carbGrams = (calories * carbPercentage / 4).toDouble();
    final fatGrams = (calories * fatPercentage / 9).toDouble();

    // Create and return an array of grams
    return [proteinGrams, carbGrams, fatGrams];
  }

  double calculateBMR() {
    if (gender == 'Male') {
      return 10 * weightInKg! + 6.25 * heightInCM! - 5 * age! + 5;
    } else if (gender == 'Female') {
      return 10 * weightInKg! + 6.25 * heightInCM! - 5 * age! - 161;
    } else {
      return 1;
    }
  }

  double calculateBMI() {
    double heightInMeters = heightInCM! / 100;
    return weightInKg / (heightInMeters * heightInMeters);
  }

  double calculateTotalCalories() {
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

    double totalCalories = bmr * activityFactor;

    return totalCalories;
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

  void _showSignUpDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('Please sign up to access this feature.'),
          actions: <Widget>[
            TextButton(
              child: Text('Sign Up'),
              onPressed: () {
                // TODO: Implement the sign-up action
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu), // Side panel menu icon
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userInfoCard(
              age: age,
              heightDisplay: heightDisplay,
              weightDisplay: weightDisplay,
              bmi: calculateBMI().toStringAsFixed(2),
            ),
            MacronutrientChartCard(
              proteinGrams: calculateMacronutrients(calculateCalories())[0],
              carbGrams: calculateMacronutrients(calculateCalories())[1],
              fatGrams: calculateMacronutrients(calculateCalories())[2],
              totalCalories: calculateCalories(),
            ),
            CalorieBarChartCard(
              consumedCalories: calculateCalories(),
              totalCalories: calculateTotalCalories(),
            ),
            WeightGoalGaugeCard(
              weightGoal: weightGoal!,
            ),
            MealPlanCard(
              onCardTap: () => _showSignUpDialog(context, 'Generate Meal Plan'),
            ),
            WorkoutPlanCard(
              onCardTap: () =>
                  _showSignUpDialog(context, 'Generate Workout Plan'),
            ),
            BmiGaugeCard(bmi: calculateBMI()),
            ActivityLevelCard(
              currentActivityLevel: activityLevel,
            )
          ],
        ),
      ),
    );
  }
}
