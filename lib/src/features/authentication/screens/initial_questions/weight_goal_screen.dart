import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';

enum WeightGoal {
  maintainWeight,
  mildWeightLoss,
  weightLoss,
  extremeWeightLoss,
  mildWeightGain,
  weightGain,
  extremeWeightGain
}

class WeightGoalScreen extends StatefulWidget {
  @override
  _WeightGoalScreenState createState() => _WeightGoalScreenState();
}

class _WeightGoalScreenState extends State<WeightGoalScreen> {
  final InitialSettingsController settingsController =
      Get.find<InitialSettingsController>();
  WeightGoal? _selectedGoal = WeightGoal.mildWeightLoss;

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
          'Weight Goal',
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
            value: 6 / 6, // This represents 1/4 progress
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What is your weight goal?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This helps us create your personal plan',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
                height: 400,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    children: [
                      RadioListTile<WeightGoal>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Maintain Weight',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: WeightGoal.maintainWeight,
                        groupValue: _selectedGoal,
                        onChanged: (WeightGoal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                      ),
                      RadioListTile<WeightGoal>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Mild Weight loss 0.25kg/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: WeightGoal.mildWeightLoss,
                        groupValue: _selectedGoal,
                        onChanged: (WeightGoal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                      ),
                      RadioListTile<WeightGoal>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Weight loss 0.5kg/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: WeightGoal.weightLoss,
                        groupValue: _selectedGoal,
                        onChanged: (WeightGoal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                      ),
                      RadioListTile<WeightGoal>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Extreme weight loss 1kg/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: WeightGoal.extremeWeightLoss,
                        groupValue: _selectedGoal,
                        onChanged: (WeightGoal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                      ),
                      RadioListTile<WeightGoal>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Mild weight gain of 0.25kg/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: WeightGoal.mildWeightGain,
                        groupValue: _selectedGoal,
                        onChanged: (WeightGoal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                      ),
                      RadioListTile<WeightGoal>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Weight gain of 0.5kg/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: WeightGoal.weightGain,
                        groupValue: _selectedGoal,
                        onChanged: (WeightGoal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                      ),
                      RadioListTile<WeightGoal>(
                        contentPadding: EdgeInsets.all(12),
                        title: const Text(
                          'Extreme weight gain of 1kg/week',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: WeightGoal.extremeWeightGain,
                        groupValue: _selectedGoal,
                        onChanged: (WeightGoal? value) {
                          setState(() {
                            _selectedGoal = value;
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
            height: 60,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () async {
                final auth = AuthenticationRepository.instance;
                settingsController.saveWeightGoal(_selectedGoal.toString());
                await auth.decideInitialScreen(auth.firebaseUser);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
