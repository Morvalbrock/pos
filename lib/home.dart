import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pos/bar_graph/bar_graps.dart';
import 'package:pos/pie_chart.dart';

import 'custom.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<double> yearlySummary = [
    20.0,
    40.0,
    20.0,
    60.0,
    90.0,
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };
    return Scaffold(
      backgroundColor: Color(0xfffeeeee),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        title: Text('Homepage'),
      ),
      drawer: Customdrawer(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Welcome!Username",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    "Date:05/10/2023",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Card(
                  elevation: 2.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    height: 100.0,
                    color: Colors.white,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monitor_outlined,
                              size: 40.0,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                "28",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "MYNEW CLIENTS",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    height: 100.0,
                    color: Colors.white,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assessment_outlined,
                              size: 40.0,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                "24",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "NEW PROJECTS",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    height: 100.0,
                    color: Colors.white,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.file_copy_sharp,
                              size: 40.0,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                "30",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "NEW INVOICES",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    height: 100.0,
                    color: Colors.white,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 40.0,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                "34",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "All PROJECTS",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'YEARLY SALES',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        color: Colors.white,
                        height: MediaQuery.of(context).size.width * 0.35,
                        width: MediaQuery.of(context).size.width * 0.58,
                        child: MyBarGraph(
                          yearSummar: yearlySummary,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Card(
                  elevation: 2.0,
                  child: Container(
                    color: Colors.white,
                    height: 566.0,
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: My_Piechart(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
