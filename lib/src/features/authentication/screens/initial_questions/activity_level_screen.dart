import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/activity_level_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/height_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/weight_goal_screen.dart';

enum ActivityLevel {
  little,
  oneToThree,
  fourToFive,
  daily,
  intense,
  intenseDaily
}

class ActivityLevelScreen extends StatefulWidget {
  @override
  _ActivityLevelScreenState createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  final InitialSettingsController settingsController =
      Get.find<InitialSettingsController>();
  ActivityLevel? _selectedLevel = ActivityLevel.little;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Activity Level',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LinearProgressIndicator(
            value: 5 / 6, // This represents 1/4 progress
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What is your Activity Level?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This helps us create your personal plan',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
                height: 400,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    children: [
                      RadioListTile<ActivityLevel>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Little or no exercise',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: ActivityLevel.little,
                        groupValue: _selectedLevel,
                        onChanged: (ActivityLevel? value) {
                          setState(() {
                            _selectedLevel = value;
                          });
                        },
                      ),
                      RadioListTile<ActivityLevel>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Exercise 1-3 times/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: ActivityLevel.oneToThree,
                        groupValue: _selectedLevel,
                        onChanged: (ActivityLevel? value) {
                          setState(() {
                            _selectedLevel = value;
                          });
                        },
                      ),
                      RadioListTile<ActivityLevel>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Exercise 4-5 times/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: ActivityLevel.fourToFive,
                        groupValue: _selectedLevel,
                        onChanged: (ActivityLevel? value) {
                          setState(() {
                            _selectedLevel = value;
                          });
                        },
                      ),
                      RadioListTile<ActivityLevel>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Daily exercise or intense exercise 3-4 times/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: ActivityLevel.daily,
                        groupValue: _selectedLevel,
                        onChanged: (ActivityLevel? value) {
                          setState(() {
                            _selectedLevel = value;
                          });
                        },
                      ),
                      RadioListTile<ActivityLevel>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Intense exercise 6-7 times/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: ActivityLevel.intense,
                        groupValue: _selectedLevel,
                        onChanged: (ActivityLevel? value) {
                          setState(() {
                            _selectedLevel = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                settingsController.saveActivityLevel(_selectedLevel.toString());
                Get.to(() => WeightGoalScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
