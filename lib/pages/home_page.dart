import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/controllers/data_controller.dart';
import 'package:macro_calculator/controllers/theme_controller.dart';
import 'package:macro_calculator/pages/results_page.dart';
import 'package:macro_calculator/utils/enums.dart';
import 'package:macro_calculator/utils/helpers.dart';
import 'package:macro_calculator/utils/textStyles.dart';
import 'package:macro_calculator/data/calculator.dart';
import 'package:macro_calculator/widgets/my_button.dart';
import 'package:macro_calculator/widgets/my_drop_down_menu.dart';
import 'package:macro_calculator/widgets/slider.dart';
import 'package:macro_calculator/widgets/tile.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:macro_calculator/SQL/sqlutil.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {

  const HomePage({Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var dataController = Provider.of<DataController>(context);
    String user = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Macro Calculator"),
        actions: [
          IconButton(
            tooltip: isThemeDark(context) ? 'Light Mode' : 'Dark Mode',
            icon: Icon(
              isThemeDark(context) ? EvaIcons.sunOutline : EvaIcons.moonOutline,
            ),
            onPressed: () =>
                Provider.of<ThemeController>(context, listen: false)
                    .toggleTheme(),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(6.0),
        children: [
          Tile(
            color: const Color(0x66999999),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        icon: Icons.male,
                        title: isThemeDark(context) ? const Text(
                            'Male',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 18,
                                )) : const Text(
                            'Male',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 18,
                                )),
                        selected: dataController.gender == Gender.male,
                        onTap: () => dataController.setGender(Gender.male),
                      ),
                    ),
                    spacer(width: 12),
                    Expanded(
                      child: MyButton(
                        icon: Icons.female,
                        title: isThemeDark(context) ? const Text(
                            'Female',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                            )) : const Text(
                            'Male',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18,
                            )),
                        selected: dataController.gender == Gender.female,
                        onTap: () => dataController.setGender(Gender.female),
                      ),
                    ),
                  ],
                ),

                spacer(height: 12),

                //! height slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Height",
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.height!.toStringAsFixed(0),
                          style: MyTextStyles(context).homeCardValue,
                        ),
                        Text(
                          "cm",
                          style: MyTextStyles(context).homeCardText,
                        ),
                      ],
                    ),
                  ],
                ),
                MyCustomSlider(
                  value: dataController.height!,
                  minValue: 100,
                  maxValue: 220,
                  onChanged: (value) => dataController.setHeight(value),
                ),

                //! weight slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Weight",
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.weight!.toStringAsFixed(0),
                          style: MyTextStyles(context).homeCardValue,
                        ),
                        Text(
                          "kg",
                          style: MyTextStyles(context).homeCardText,
                        ),
                      ],
                    ),
                  ],
                ),
                MyCustomSlider(
                  value: dataController.weight!,
                  minValue: 40,
                  maxValue: 150,
                  onChanged: (value) => dataController.setWeight(value),
                ),
                // age number picker
                Text(
                  "Age",
                  style: MyTextStyles(context).cardTitle,
                ),
                Center(
                  child: NumberPicker(
                    minValue: 12,
                    maxValue: 80,
                    itemCount: 7,
                    itemWidth: 47.2,
                    selectedTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textStyle: TextStyle(color: colorScheme(context).tertiary),
                    value: dataController.age!,
                    axis: Axis.horizontal,
                    onChanged: (value) => dataController.setAge(value),
                  ),
                )
              ],
            ),
          ),

          Tile(
            color: const Color(0x66999999),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Waist",
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.waist!.toStringAsFixed(0),
                          style: MyTextStyles(context).homeCardValue,
                        ),
                        Text(
                          "in",
                          style: MyTextStyles(context).homeCardText,
                        ),
                      ],
                    ),
                  ],
                ),
                MyCustomSlider(
                  value: dataController.waist!,
                  minValue: 20,
                  maxValue: 60,
                  onChanged: (value) => dataController.setWaist(value),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Neck",
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.neck!.toStringAsFixed(0),
                          style: MyTextStyles(context).homeCardValue,
                        ),
                        Text(
                          "in",
                          style: MyTextStyles(context).homeCardText,
                        ),
                      ],
                    ),
                  ],
                ),
                MyCustomSlider(
                  value: dataController.neck!,
                  minValue: 5,
                  maxValue: 30,
                  onChanged: (value) => dataController.setNeck(value),
                ),

                dataController.gender == Gender.female ?  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Hip",
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.hip!.toStringAsFixed(0),
                          style: MyTextStyles(context).homeCardValue,
                        ),
                        Text(
                          "in",
                          style: MyTextStyles(context).homeCardText,
                        ),
                      ],
                    ),
                  ],
                ) : const SizedBox(width: 0),
                dataController.gender == Gender.female ? MyCustomSlider(
                  value: dataController.hip!,
                  minValue: 20,
                  maxValue: 60,
                  onChanged: (value) => dataController.setHip(value),
                ) : const SizedBox(width: 0),
              ],
            )
          ),

          //! second container
          Tile(
            color: const Color(0x66999999),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Activity level",
                  style: MyTextStyles(context).cardTitle,
                ),
                MyDropDownMenu<ActivityLevel>(
                  items: ActivityLevel.values,
                  value: dataController.activityLevel!,
                  onChanged: (value) => dataController.setActivityLevel(value),
                ),
                const SizedBox(height: 8),
                Text(
                  "Goal",
                  style: MyTextStyles(context).cardTitle,
                ),
                MyDropDownMenu<Goal>(
                  items: Goal.values,
                  value: dataController.goal!,
                  onChanged: (value) => dataController.setGoal(value),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Calculate',
        heroTag: 'fab',
        icon: const Icon(Icons.done),
        label: const Text('Calculate'),
        onPressed: () async{
          Gender gender = dataController.gender!;
          double waist = dataController.waist!;
          double neck = dataController.neck!;
          double hip = dataController.hip!;
          double weight = dataController.weight!;
          double height = dataController.height!;
          int age = dataController.age!;
          ActivityLevel actlvl = dataController.activityLevel!;
          Goal goal = dataController.goal!;


          Calculator calculator = Calculator(
            gender: gender,
            height: height,
            weight: weight,
            age: age,
            activityLevel: actlvl,
            goal: goal,
            waist: waist,
            hip: hip,
            neck: neck,
          );

          double bfper = calculator.bfper();
          double tcal = calculator.totalCalories();
          double carb = calculator.carb();
          double protein = calculator.protein();
          double fat = calculator.fat();
          double bmi = calculator.bmi();
          double tdee = calculator.tdee();
          String bmiscale = calculator.bmiScale();

          String date = DateFormat('yyyy-MM-dd').format(DateTime.now()) ;
          int dob = (int.parse(DateFormat('yyyy').format(DateTime.now())) - age);
          var measurement = {'waist':waist,'neck':neck,'hip':hip};

          await SQLhelper.insertdetail(user, genderFinder(gender), dob , actLvl(actlvl), goalFinder(goal));
          await SQLhelper.insertdata(user, tcal, bfper, carb, protein, fat, tdee, bmi, genderFinder(gender),bmiscale);
          await SQLhelper.insertrecord(user, weight, height, bfper, date, genderFinder(gender), measurement);

          var list = await SQLhelper.fetchdata(user);
          print(list);
          list = await SQLhelper.fetchrecord(user);
          print(list);
          list = await SQLhelper.fetchdetail(user);
          print(list);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                username :user,
                bfper : bfper,
                totalCalories: tcal,
                carbs: carb,
                protein: protein,
                fats: fat,
                bmi: bmi,
                tdee: tdee,
                bmiScale: bmiscale,
              ),
           ),
          );
        },
      ),
    );
  }
}
