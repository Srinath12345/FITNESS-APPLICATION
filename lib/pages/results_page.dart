import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:macro_calculator/pages/graph.dart';
import 'package:macro_calculator/pages/graph1.dart';
import 'package:macro_calculator/pages/login.dart';
import 'package:macro_calculator/pages/updatepage.dart';
import 'package:macro_calculator/widgets/result_tile.dart';
import 'package:screenshot/screenshot.dart';

import '../SQL/sqlutil.dart';


class ResultPage extends StatefulWidget{

  const ResultPage({Key? key,
    required this.username,
    required this.bfper,
    required this.totalCalories,
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.bmi,
    required this.tdee,
    required this.bmiScale,
  }) : super(key: key);
  final String username;
  final double bfper;
  final double totalCalories;
  final double carbs;
  final double protein;
  final double fats;
  final double bmi;
  final double tdee;
  final String bmiScale;


  @override
  State<StatefulWidget> createState() {
    return _ResultState();
  }

}

class _ResultState extends State<ResultPage> {

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    elevation: 10,
    foregroundColor: Colors.white,
    backgroundColor: Colors.grey[300],
    padding: const EdgeInsets.all(15),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  Widget buildUpdateBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async{

          var list = await SQLhelper.fetchrecord(widget.username);
          var list1 = await SQLhelper.fetchdetail(widget.username);

           Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(user : widget.username, gender : list1[0]['GENDER'],dob : int.parse(list1[0]['DOB']))));
           },
        child: const Text(
          'UPDATE METRICS',
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildprogressBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async{

          var list = await SQLhelper.fetchrecord(widget.username);
          var list1 = await SQLhelper.fetchdetail(widget.username);
          List<List> obj = [];
          for (var i in list) {
            var data = [];
            double month = double.parse(DateFormat("M").format(DateTime.parse(i['DATE'])));
            data.add(month);
            data.add(i['WEIGHT']);
            obj.add(data);
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => LineChartWidget(data: obj) ));
        },
        child: const Text(
          'USER PROGRESS',
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }



  Widget buildlogout() {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context,ModalRoute.withName('/Login'));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
      },
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
              text: '  log out  ',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
        leading: IconButton(
          icon: const Icon(EvaIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          buildlogout()
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(6.0),
        children: [
          Screenshot(
            controller: screenshotController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ResultTile(
                  title: "Total Calories",
                  value: widget.totalCalories.toStringAsFixed(0),
                  units: "KCALS",
                ),
                ResultTile(
                  title: "Body Fat percentage",
                  value: widget.bfper.toStringAsFixed(2),
                  units: "PERCENT",
                ),
                ResultTile(
                  title: "Carbs",
                  value: widget.carbs.toStringAsFixed(0),
                  units: "GRAMS",
                ),
                Row(
                  children: [
                    Expanded(
                      child: ResultTile(
                        title: "Protein",
                        value: widget.protein.toStringAsFixed(0),
                        units: "GRAMS",
                      ),
                    ),
                    Expanded(
                      child: ResultTile(
                        title: "Fats",
                        value: widget.fats.toStringAsFixed(0),
                        units: "GRAMS",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ResultTile(
                        title: "BMI",
                        value: widget.bmi.toStringAsFixed(1),
                        units: widget.bmiScale,
                      ),
                    ),
                    Expanded(
                      child: ResultTile(
                        title: "TDEE",
                        value: widget.tdee.toStringAsFixed(0),
                        units: "KCALS",
                      ),
                    ),
                  ],
                ),
                buildUpdateBtn(),
                buildprogressBtn(),
              ],
            ),
          ),
        ],
      ),

    );
  }

}