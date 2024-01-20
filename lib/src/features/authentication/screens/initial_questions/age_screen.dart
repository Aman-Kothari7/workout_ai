import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/weight_goal_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/weight_screen.dart';

class AgeSelectionScreen extends StatefulWidget {
  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  final InitialSettingsController weightGoalController =
      Get.put(InitialSettingsController());

  int _selectedAge = 18; // Default or initial age

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle the back action
          },
        ),
        title: Text(
          'Age',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text('1/4')),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: 0.25, // This represents 1/4 progress
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'What is your age?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This helps us create your personal plan',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 32),
                Container(
                  height: 400,
                  child: ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    useMagnifier: true,
                    magnification: 1.5,
                    itemExtent: 90,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedAge = 18 + index;
                      });
                    },
                    perspective: 0.01,
                    diameterRatio: 2,
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final age = 18 + index;
                        final isSelected = _selectedAge == age;
                        return Center(
                          child: Text(
                            age.toString(),
                            style: TextStyle(
                              fontSize: 55,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                        );
                      },
                      childCount: 100, // Adjust the range of ages as needed
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () async {
                await InitialSettingsController.instance.saveAge(_selectedAge);
                Get.to(() => WeightSelectionScreen());
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
