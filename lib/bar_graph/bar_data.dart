import 'package:pos/bar_graph/individual_bar.dart';

class BarData {
  final double firstYear;
  final double secondYear;
  final double thirdYear;
  final double fourthYear;
  final double fifthYear;

  BarData({
    required this.firstYear,
    required this.secondYear,
    required this.thirdYear,
    required this.fourthYear,
    required this.fifthYear,
  });

  List<IndividualBar> barData = [];
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: firstYear),
      IndividualBar(x: 1, y: secondYear),
      IndividualBar(x: 2, y: thirdYear),
      IndividualBar(x: 3, y: fourthYear),
      IndividualBar(x: 4, y: fifthYear),
    ];
  }
}
