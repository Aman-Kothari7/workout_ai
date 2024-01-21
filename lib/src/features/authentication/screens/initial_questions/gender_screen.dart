import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/activity_level_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/height_screen.dart';

class GenderSelectionScreen extends StatefulWidget {
  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  final InitialSettingsController settingsController =
      Get.find<InitialSettingsController>();
  String _selectedGender = 'Male'; // Default or initial gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Use GetX navigation method to go back
          },
        ),
        title: Text(
          'Select Gender',
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
            value: 4 / 6, // This represents 1/4 progress
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What is your gender?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This helps us create your personal plan',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 50),
                Container(
                  height: 400,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _selectedGender = 'Male';
                            });
                          },
                          backgroundColor: _selectedGender == 'Male'
                              ? Colors.blue
                              : Colors.grey[200],
                          heroTag: 'male',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.male,
                                  size: 70,
                                  color: _selectedGender == 'Male'
                                      ? Colors.white
                                      : Colors.black),
                              Text(
                                'Male', // The text to display
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _selectedGender == 'Male'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _selectedGender = 'Female';
                            });
                          },
                          backgroundColor: _selectedGender == 'Female'
                              ? Colors.purple
                              : Colors.grey[200],
                          heroTag: 'female',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.female,
                                  size: 70,
                                  color: _selectedGender == 'Female'
                                      ? Colors.white
                                      : Colors.black),
                              Text(
                                'Female', // The text to display
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _selectedGender == 'Male'
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                settingsController
                    .saveGender(_selectedGender); // Save the selected gender
                Get.to(
                    () => ActivityLevelScreen()); // Navigate to the next screen
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
