
import 'package:flutter/material.dart';
import 'package:macro_calculator/utils/enums.dart';
import 'package:provider/provider.dart';

import '../controllers/data_controller.dart';

Color getOverLayColor(BuildContext context, Color color) {
  return Color.alphaBlend(ElevationOverlay.overlayColor(context, 1), color);
}

Widget spacer({double height = 0, double width = 0}) {
  return SizedBox(height: height, width: width);
}

bool isThemeDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark ? true : false;
}

ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

extension StringExtension on String {
  String firstCapital() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String actLvl(ActivityLevel activityLevel){
  if (activityLevel == ActivityLevel.sedentary) {
    return 'sedentary';
  } else if (activityLevel == ActivityLevel.lightly) {
    return 'lightly';
  } else if (activityLevel == ActivityLevel.moderately) {
    return 'moderately';
  } else if (activityLevel == ActivityLevel.very) {
    return 'very';
  } else if (activityLevel == ActivityLevel.extremely){
    return 'extremely';
  }
  return '';
}

String goalFinder(Goal goal){
  if (goal == Goal.loose) {
    return 'loose';
  } else if (goal == Goal.maintain) {
    return 'maintain';
  } else if (goal == Goal.gain) {
    return 'gain';
  }
  return '';
}

String genderFinder(Gender gender){
  if (gender == Gender.male) {
    return 'male';
  } else {
    return 'female';
  }
}

int genderSetter(String gender,BuildContext context){
  var dataController = Provider.of<DataController>(context,listen: false);
  if (gender == 'male') {
    dataController.setGender(Gender.male);
  } else {
    dataController.setGender(Gender.female);
  }
  return 1;
}