import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';

class WeightGoalScreen extends StatelessWidget {
  final InitialSettingsController weightGoalController =
      Get.put(InitialSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Weight Goal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('What is your weight goal?', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: weightGoalController.weightTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight Goal', // Edit to take weight goal
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final auth = AuthenticationRepository.instance;
                weightGoalController.saveWeightGoal();
                await auth.decideInitialScreen(auth.firebaseUser);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
