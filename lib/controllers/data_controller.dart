import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_calculator/utils/enums.dart';

class DataController extends ChangeNotifier {
  Gender? gender;
  double? height;
  double? weight;
  double? waist;
  double? neck;
  double? hip;
  int? age;
  ActivityLevel? activityLevel;
  Goal? goal;

  Box box = Hive.box('data');

  DataController() {
    gender = Gender.values[box.get('gender') ?? 0];
    height = box.get('height') ?? 170;
    weight = box.get('weight') ?? 70;
    age = box.get('age') ?? 25;
    activityLevel = ActivityLevel.values[box.get('activityLevel') ?? 2];
    goal = Goal.values[box.get('goal') ?? 0];
    waist = box.get('waist') ?? 28;
    neck = box.get('neck') ?? 16;
    hip = box.get('hip') ?? 32;
  }

  void setGender(Gender? gender) async {
    this.gender = gender;
    box.put('gender', gender?.index);
    notifyListeners();
  }

  void setHeight(double? height) {
    this.height = height;
    box.put('height', height);
    notifyListeners();
  }

  void setWeight(double? weight) {
    this.weight = weight;
    box.put('weight', weight);
    notifyListeners();
  }

  void setAge(int? age) {
    this.age = age;
    box.put('age', age);
    notifyListeners();
  }

  void setActivityLevel(ActivityLevel? activityLevel) {
    this.activityLevel = activityLevel;
    box.put('activityLevel', activityLevel?.index);
    notifyListeners();
  }

  void setGoal(Goal? goal) {
    this.goal = goal;
    box.put('goal', goal?.index);

    notifyListeners();
  }

  void setWaist(double? waist) {
    this.waist = waist;
    box.put('waist', waist);
    notifyListeners();
  }

  void setHip(double? hip) {
    this.hip = hip;
    box.put('hip', hip);
    notifyListeners();
  }

  void setNeck(double? neck) {
    this.neck = neck;
    box.put('neck', neck);
    notifyListeners();
  }

}
