import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
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
    loadWeight();
    loadAge();
    loadWeightGoal();
  }

  String? weightGoal;
  int? age;
  int? weight;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('$weightGoal'), Text('$age'), Text('$weight')],
        ),
      ),
    );
  }
}
