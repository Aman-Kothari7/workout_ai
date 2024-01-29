import 'package:flutter/material.dart';

class userInfoCard extends StatelessWidget {
  const userInfoCard({
    super.key,
    required this.age,
    required this.heightDisplay,
    required this.weightDisplay,
    required this.bmi,
  });

  final int? age;
  final String? heightDisplay;
  final String weightDisplay;
  final String? bmi;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: 100,
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Center(child: Text('AGE\n$age')),
              Center(child: Text('HEIGHT\n$heightDisplay')),
              Center(child: Text('WEIGHT\n$weightDisplay')),
              Center(child: Text('BMI\n$bmi')),
              Center(child: Text('AGE\n $age')),
              Center(child: Text('HEIGHT\n$heightDisplay')),
              Center(child: Text('WEIGHT\n$weightDisplay')),
              Center(child: Text('BMI\n$bmi')),
            ],
          ),
        ),
      ),
    );
  }
}
