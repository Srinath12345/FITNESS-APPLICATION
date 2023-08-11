import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class LineChartWidget extends StatelessWidget{
  final List<List> data;

  const LineChartWidget({Key? key,required this.data}) : super(key: key);

  getdata(List<List> data){
    List<FlSpot> widgets = [];
    data.forEach((item) {
      widgets.add(FlSpot(item[0],item[1].roundToDouble()));
    });

    return widgets;
  }

  Widget buildlogout(BuildContext context) {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Progress"),
          leading: IconButton(
            icon: const Icon(EvaIcons.chevronLeft),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            buildlogout(context)
          ],
        ),
          body:Container(
            padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child: LineChart(LineChartData (
                minY: 40,
                maxY: 100,
                minX: 1,
                maxX: 13,
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (val,meta){
                        String text = '';
                        switch(val.toInt()){
                          case 1:
                            text='JAN';
                            break;
                          case 5:
                            text='MAY';
                            break;
                          case 9:
                            text='SEP';
                            break;
                          case 12:
                            text='DEC';
                            break;
                        }
                        return Text(text);
                      }
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      reservedSize: 40,
                    ),
                  ),
                ),
                backgroundColor: Color(0xff000000),
                lineBarsData: [LineChartBarData(
            spots: getdata(data),
            isCurved: false,
            dotData: FlDotData(show: true)
        )])
        ))

    );

  }
  
}