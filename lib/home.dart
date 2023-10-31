import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import 'package:pos/bar_graph/bar_graps.dart';
import 'package:pos/helper/connection.dart';
import 'package:pos/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom.dart';

String todayDate = DateFormat.yMd().format(DateTime.now());

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

  // late String data = '';
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');
    getdetails();
    // data = supplierCount[0]['COUNT(*)'];
    // print(data);
  }

  late String total_Revenue = '';
  late String overall_Revenue = '';
  late String today_Invice = '';
  late String overall_Invice = '';
  late String user_name = '';
  //  DateTime todaydatefoemat = formatter.format(todayDate) as DateTime;

  getdetails() async {
    // await Future.delayed(Duration(seconds: 10));
    // print(todayDate);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var compId = prefs.getString('comp_id');
    try {
      List<dynamic> totalRevenues = await SelectionQry(
          'SELECT SUM(og_total) as sum FROM tbl_invoice WHERE `comp_id`="$compId" AND DATE_format(created_at,"percentageY-percentagem-percentaged") = "$todayDate"');
      List<dynamic> overallRevenues = await SelectionQry(
          'SELECT SUM(og_total) as sums FROM tbl_invoice WHERE `comp_id`="$compId"');
      List<dynamic> todayInvices = await SelectionQry(
          'SELECT COUNT(*) as inv FROM tbl_invoice WHERE `comp_id`="$compId" AND DATE_format(created_at,"percentageY-percentagem-percentaged") = "$todayDate"');
      List<dynamic> overallInvices = await SelectionQry(
          'SELECT COUNT(*) as invs FROM tbl_invoice WHERE `comp_id`="$compId"');

      List<dynamic> username = await SelectionQry(
          'SELECT `username` FROM `users` WHERE `company_id`="$compId"');
      Timer(const Duration(seconds: 5), () {
        setState(() {
          total_Revenue = totalRevenues[0]['sum'].toString();
          overall_Revenue = overallRevenues[0]['sums'].toString();
          today_Invice = todayInvices[0]['inv'].toString();
          overall_Invice = overallInvices[0]['invs'].toString();
          user_name = username[0]['username'].toString();
        });
        EasyLoading.dismiss();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, double> dataMap = {
    //   "Flutter": 5,
    //   "React": 3,
    //   "Xamarin": 2,
    //   "Ionic": 2,
    // };

    return Scaffold(
      backgroundColor: const Color(0xfffeeeee),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(236, 133, 36, 1),
        title: const Text('Homepage'),
      ),
      drawer: Customdrawer(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Welcome! $user_name",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    "Date:${todayDate.toString()}",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Card(
                  elevation: 2.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.monitor_outlined,
                              size: 35.0,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                "₹$total_Revenue",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "TODAY REVENUE",
                          style: TextStyle(fontSize: 16.0),
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
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.assessment_outlined,
                              size: 35.0,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                "₹$overall_Revenue",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "OVERALL REVENUE",
                          style: TextStyle(fontSize: 16.0),
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
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.file_copy_sharp,
                              size: 35.0,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                today_Invice,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "TODAY INVOICES",
                          style: TextStyle(fontSize: 16.0),
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
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              size: 35.0,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                overall_Invice,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "OVERALL INVOICES",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
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
                        height: MediaQuery.of(context).size.height * 0.55,
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
                    height: MediaQuery.of(context).size.height * 0.63,
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
