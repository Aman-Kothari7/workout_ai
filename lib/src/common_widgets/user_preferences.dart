import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Function to store weight
  Future<void> setWeight(double weight) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble('weight', weight);
  }

  // Function to retrieve weight
  Future<double?> getWeight() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble('weight');
  }

  // Function to store height
  Future<void> setHeight(double height) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble('height', height);
  }

  // Function to retrieve height
  Future<double?> getHeight() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble('height');
  }

  // Function to store primary goal
  Future<void> setPrimaryGoal(String primaryGoal) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('primaryGoal', primaryGoal);
  }

  // Function to retrieve primary goal
  Future<String?> getPrimaryGoal() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('primaryGoal');
  }

  // Function to store activity level
  Future<void> setActivityLevel(String activityLevel) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('activityLevel', activityLevel);
  }

  // Function to retrieve activity level
  Future<String?> getActivityLevel() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('activityLevel');
  }

  // Function to store age
  Future<void> setAge(int age) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt('age', age);
  }

  // Function to retrieve age
  Future<int?> getAge() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('age');
  }

  // Function to store gender
  Future<void> setGender(String gender) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('gender', gender);
  }

  // Function to retrieve gender
  Future<String?> getGender() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('gender');
  }

  // Function to clear all stored preferences (optional)
  Future<void> clearPreferences() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }
}
