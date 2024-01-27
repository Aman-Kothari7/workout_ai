

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

  final FixedExtentScrollController _ftScrollController =
      FixedExtentScrollController();

  final FixedExtentScrollController _inchesScrollController =
      FixedExtentScrollController();

  final InitialSettingsController heightController =
      Get.put(InitialSettingsController());

  int _selectedHeightCM = 120;
  int _selectedHeightFT = 5; // Default to 5 feet
  int _selectedHeightInches = 6; // Default to 6 inches

  bool isCM = true;

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
            value: 3 / 6, // This represents 1/4 progress
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value: isCM,
                      onChanged: (value) {
                        _toggleHeightUnit();
                      },
                    ),
                    Text(
                      isCM ? 'cm' : 'ft',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  height: 400,
                  child: isCM
                      ? ListWheelScrollView.useDelegate(
                          controller: _scrollController,
                          useMagnifier: true,
                          magnification: 1.5,
                          itemExtent: 90,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedHeightCM = 60 + index;
                            });
                          },
                          perspective: 0.01,
                          diameterRatio: 2,
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              final height = 60 + index;
                              final isSelected = _selectedHeightCM == height;
                              return Center(
                                child: Text(
                                  height.toString(),
                                  style: TextStyle(
                                    fontSize: 55,
                                    color:
                                        isSelected ? Colors.blue : Colors.black,
                                  ),
                                ),
                              );
                            },
                            childCount: 181, // cm range from 60 - 240
                          ),
                        )
                      : Row(
                          // This row will place the two scroll wheels side by side
                          children: [
                            Expanded(
                              child: ListWheelScrollView.useDelegate(
                                controller: _ftScrollController,
                                useMagnifier: true,
                                magnification: 1.5,
                                itemExtent: 90,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedHeightFT = 2 + index;
                                  });
                                },
                                perspective: 0.01,
                                diameterRatio: 2,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    final heightFT = 2 + index;
                                    final isSelected =
                                        _selectedHeightFT == heightFT;
                                    return Center(
                                      child: Text(
                                        heightFT.toString(),
                                        style: TextStyle(
                                          fontSize: 55,
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: 6, // feet range from 2 - 7
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListWheelScrollView.useDelegate(
                                controller: _inchesScrollController,
                                useMagnifier: true,
                                magnification: 1.5,
                                itemExtent: 90,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedHeightInches = 1 + index;
                                  });
                                },
                                perspective: 0.01,
                                diameterRatio: 2,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    final heightInches = 1 + index;
                                    final isSelected =
                                        _selectedHeightInches == heightInches;
                                    return Center(
                                      child: Text(
                                        heightInches.toString(),
                                        style: TextStyle(
                                          fontSize: 55,
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: 11, // inches range from 1 - 11
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          //Fix next button not cutting out
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () async {
                if (isCM) {
                  await InitialSettingsController.instance
                      .saveHeightCM(_selectedHeightCM);
                  await InitialSettingsController.instance.saveIsCM(isCM);
                } else {
                  final heightInInches =
                      _selectedHeightFT * 12 + _selectedHeightInches;
                  await InitialSettingsController.instance
                      .saveHeightInches(heightInInches);
                  await InitialSettingsController.instance.saveIsCM(isCM);
                }
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

  void _toggleHeightUnit() {
    setState(() {
      isCM = !isCM;
    });
  }
}
