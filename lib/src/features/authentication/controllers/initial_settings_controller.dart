import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialSettingsController extends GetxController {
  static InitialSettingsController get instance => Get.find();

  var weightTextController = TextEditingController();

  @override
  void onClose() {
    weightTextController.dispose();
    super.onClose();
  }

  Future<void> saveAge(int age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', age);
  }

  Future<void> saveWeightGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('weightGoal', weightTextController.text);
  }

  Future<void> saveHeight(int height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('height', height);
  }

  Future<void> saveWeight(int weight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('weight', weight);
  }

  Future<void> saveGender(String gender) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', gender);
  }

  Future<void> saveActivityLevel(String activityLevel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('activityLevel', activityLevel);
  }
}
