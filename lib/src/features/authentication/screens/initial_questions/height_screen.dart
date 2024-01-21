import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/activity_level_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/gender_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/initial_questions/weight_goal_screen.dart';

class HeightSelectionScreen extends StatefulWidget {
  @override
  _HeightSelectionScreenState createState() => _HeightSelectionScreenState();
}

class _HeightSelectionScreenState extends State<HeightSelectionScreen> {
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  final InitialSettingsController weightGoalController =
      Get.put(InitialSettingsController());

  int _selectedHeight = 120; 

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
          'Height',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: 3/6,// This represents 1/4 progress
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'What is your height?',
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
                        _selectedHeight = 60 + index;
                      });
                    },
                    perspective: 0.01,
                    diameterRatio: 2,
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final height = 60 + index;
                        final isSelected = _selectedHeight == height;
                        return Center(
                          child: Text(
                            height.toString(),
                            style: TextStyle(
                              fontSize: 55,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                        );
                      },
                      childCount: 200,
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
                    .saveHeight(_selectedHeight);
                Get.to(() => GenderSelectionScreen());
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
