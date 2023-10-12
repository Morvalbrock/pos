import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pos/bar_graph/bar_data.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key, required this.yearSummar});
  final List yearSummar;
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      firstYear: yearSummar[0],
      secondYear: yearSummar[1],
      fourthYear: yearSummar[2],
      thirdYear: yearSummar[3],
      fifthYear: yearSummar[4],
    );
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
            show: true,
            // topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            // leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTiles,
            ))),
        barGroups: myBarData.barData
            .map(
              (value) => BarChartGroupData(
                x: value.x,
                barRods: [
                  BarChartRodData(
                      toY: value.y,
                      color: const Color.fromARGB(255, 14, 190, 235),
                      width: 25.0,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100.0,
                        color: Color.fromARGB(132, 216, 231, 233),
                      )),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const Style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        '2019',
        style: Style,
      );
      break;

    case 1:
      text = const Text(
        '2020',
        style: Style,
      );
      break;

    case 2:
      text = const Text(
        '2021',
        style: Style,
      );
      break;

    case 3:
      text = const Text(
        '2022',
        style: Style,
      );
      break;

    case 4:
      text = const Text(
        '2023',
        style: Style,
      );
      break;

    default:
      text = const Text(
        '',
        style: Style,
      );
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
