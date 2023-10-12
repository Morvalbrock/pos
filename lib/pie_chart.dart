import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class My_Piechart extends StatelessWidget {
  My_Piechart({super.key});
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 2,
    "Xamarin": 3,
    "Ionic": 3,
  };
  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(seconds: 2),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 1.7,
      colorList: const [
        Colors.lightGreen,
        Color.fromARGB(255, 240, 118, 118),
        Colors.orange,
        Colors.yellow,
      ],
      initialAngleInDegree: 0,
      // chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "HYBRID",
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
