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

  final FixedExtentScrollController _decimalScrollController =
      FixedExtentScrollController();

  final InitialSettingsController weightGoalController =
      Get.put(InitialSettingsController());

  int _selectedWeight = 50; // Default or initial age

  bool isKg = true;

  double _selectedDecimal = 0.0; // Default or initial decimal

  // Add a method to toggle the weight unit
  // void _toggleWeightUnit() {
  //   setState(() {
  //     isKg = !isKg;
  //     // Reset selected weight when switching units
  //     _selectedWeight =
  //         isKg ? 50 : 110; // Approximate conversion to keep the same weight
  //     _selectedDecimal = 0.0;
  //     // Also update the scroll controllers to jump back to initial value
  //     _scrollController
  //         .jumpToItem(isKg ? 30 : 60); // Default starting index for kg or lbs
  //     _decimalScrollController.jumpToItem(0);
  //   });
  // }

  void _toggleWeightUnit() {
    setState(() {
      isKg = !isKg;
      _selectedWeight = isKg ? 50 : 100; // Reset the weight when toggling units
      _selectedDecimal = 0.0;
      _scrollController
          .jumpToItem(0); // Adjust the index as necessary for your range
      _decimalScrollController.jumpToItem(0);
    });
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value: isKg,
                      onChanged: (value) {
                        _toggleWeightUnit();
                      },
                    ),
                    Text(
                      isKg ? 'kg' : 'lbs',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  height: 400,
                  child: isKg
                      ? Row(
                          // This row will place the two scroll wheels side by side
                          children: [
                            Expanded(
                              child: ListWheelScrollView.useDelegate(
                                controller: _scrollController,
                                useMagnifier: true,
                                magnification: 1.5,
                                itemExtent: 90,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedWeight = 20 +
                                        index; // Adjust this for kg increment
                                  });
                                },
                                perspective: 0.01,
                                diameterRatio: 2,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    final weight =
                                        20 + index; // kg range starting at 20
                                    final isSelected =
                                        _selectedWeight == weight;
                                    return Center(
                                      child: Text(
                                        weight
                                            .toString(), // Show kg next to the number
                                        style: TextStyle(
                                          fontSize: 55,
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: 161, // kg range from 20 - 180
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListWheelScrollView.useDelegate(
                                controller: _decimalScrollController,
                                useMagnifier: true,
                                magnification: 1.5,
                                itemExtent: 90,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedDecimal = index *
                                        0.1; // Adjust for decimal increment
                                  });
                                },
                                perspective: 0.01,
                                diameterRatio: 2,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    final decimal =
                                        index * 0.1; // Decimal values
                                    final isSelected =
                                        _selectedDecimal == decimal;
                                    return Center(
                                      child: Text(
                                        '.${(decimal * 10).toInt()}', // Show decimal part of kg
                                        style: TextStyle(
                                          fontSize: 55,
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                  childCount:
                                      10, // Decimals range from 0.0 - 0.9
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListWheelScrollView.useDelegate(
                          controller: _scrollController,
                          useMagnifier: true,
                          magnification: 1.5,
                          itemExtent: 90,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedWeight =
                                  50 + index; // Adjust this for lbs increment
                            });
                          },
                          perspective: 0.01,
                          diameterRatio: 2,
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              final weight =
                                  50 + index; // lbs range starting at 50
                              final isSelected = _selectedWeight == weight;
                              return Center(
                                child: Text(
                                  '$weight', // Show lbs next to the number
                                  style: TextStyle(
                                    fontSize: 55,
                                    color:
                                        isSelected ? Colors.blue : Colors.black,
                                  ),
                                ),
                              );
                            },
                            childCount: 351, // lbs range from 50 - 400
                          ),
                        ),
                )
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
                double weightValue;
                if (isKg) {
                  weightValue = _selectedWeight.toDouble() +
                      _selectedDecimal; // Weight is in kg
                } else {
                  weightValue = _selectedWeight.toDouble();
                }
                await InitialSettingsController.instance
                    .saveWeight(weightValue);

                await InitialSettingsController.instance.saveIsKg(isKg);
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
