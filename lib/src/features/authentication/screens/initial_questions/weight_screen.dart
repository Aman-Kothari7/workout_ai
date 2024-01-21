import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/height_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/weight_goal_screen.dart';

class WeightSelectionScreen extends StatefulWidget {
  @override
  _WeightSelectionScreenState createState() => _WeightSelectionScreenState();
}

class _WeightSelectionScreenState extends State<WeightSelectionScreen> {
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  final InitialSettingsController weightGoalController =
      Get.put(InitialSettingsController());

  int _selectedWeight = 50; // Default or initial age

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
          'Weight',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: 2 / 6, // This represents 1/4 progress
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'What is your weight?',
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
                        _selectedWeight = 20 + index;
                      });
                    },
                    perspective: 0.01,
                    diameterRatio: 2,
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final weight = 20 + index;
                        final isSelected = _selectedWeight == weight;
                        return Center(
                          child: Text(
                            weight.toString(),
                            style: TextStyle(
                              fontSize: 55,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                        );
                      },
                      childCount: 130,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Fix next button next cutting out
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () async {
                await InitialSettingsController.instance
                    .saveWeight(_selectedWeight);
                Get.to(() => HeightSelectionScreen());
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
