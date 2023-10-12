import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

class Receiptpage extends StatefulWidget {
  const Receiptpage({super.key});

  @override
  State<Receiptpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Receiptpage> {
  var dropdownValue;
  var dropdownValue1;
  var dropdownValue2;
  List<Map<String, dynamic>> accountrootdata = [];
  String _accountrootvalue = '';

  List<Map<String, dynamic>> accountname = [];
  String _accountname = '';
  getOrder() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    try {
      List<dynamic> accrootname = await SelectionQry(
          'SELECT `id`, `comp_id`, `acc_root`, `acc_root_name`, `acc_status`, `created_at`, `updated_at` FROM `tbl_account_root` WHERE `comp_id`="$comp_id"');
      List<dynamic> accname = await SelectionQry(
          'SELECT `id`, `comp_id`, `acc_id`, `acc_root`, `acc_name`, `acc_status`, `created_at`, `updated_at` FROM `tbl_account` WHERE `comp_id`="$comp_id"');
      accountrootdata.clear();
      accountname.clear();
      accountrootdata.add({
        'acc_root': '',
        'acc_root_name': 'Choose',
      });
      for (var row in accrootname) {
        accountrootdata.add({
          'acc_root': row['acc_root'],
          'acc_root_name': row['acc_root_name'],
        });
      }
      accountname.add({
        'acc_id': '',
        'acc_name': 'Choose',
      });
      for (var row in accname) {
        accountname.add({
          'acc_id': row['acc_id'],
          'acc_name': row['acc_name'],
        });
      }

      Timer(Duration(seconds: 5), () {
        setState(() {
          accountrootdata = accountrootdata;
          accrootname = accrootname;
        });
        EasyLoading.dismiss();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeeee),
      appBar: AppBar(
        title: Text(
          'Receipt',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 40.0, left: 40.0, right: 40.0, bottom: 40.0),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 550.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10, bottom: 5.0),
                child: Text(
                  'Payment',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(
                color: Colors.black12,
                height: 5,
                indent: 20,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                          child: Text('Date'),
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Container(
                            width: 320.0,
                            height: 40.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 234, 234))),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 243, 234, 234)),
                                  ),
                                  hintText: 'yyyy-mm-dd',
                                  hintStyle: TextStyle(fontSize: 15)),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Container(
                          child: Text('Description'),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Container(
                            width: 300,
                            height: 80.0,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              textAlign: TextAlign.start,
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 234, 234))),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 243, 234, 234)),
                                  ),
                                  hintText: 'Enter Description',
                                  hintStyle: TextStyle(fontSize: 15)),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Container(
                          child: Text('Account Root'),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            value: _accountrootvalue,
                            onChanged: (v) {
                              setState(() {
                                _accountrootvalue = v.toString();
                              });
                            },
                            items: accountrootdata.map((e) {
                              return DropdownMenuItem(
                                child: Text(e["acc_root_name"].toString()),
                                value: e['acc_root'],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Container(
                          child: Text('Account'),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.22,
                          child: DropdownButtonHideUnderline(
                            child: GFDropdown(
                              borderRadius: BorderRadius.circular(5),
                              border: const BorderSide(
                                  color: Colors.black12, width: 1),
                              dropdownButtonColor: Colors.white,
                              value: _accountname,
                              onChanged: (v) {
                                setState(() {
                                  _accountname = v.toString();
                                });
                              },
                              items: accountname.map((e) {
                                return DropdownMenuItem(
                                  child: Text(e["acc_name"]),
                                  value: e['acc_id'],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text('Transaction Mode'),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            value: dropdownValue1,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue1 = newValue;
                              });
                            },
                            items: [
                              'Selected Mode',
                              'CASH',
                              'CHEQUE',
                            ]
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text('Payment Amount'),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Container(
                          width: 300,
                          height: 40.0,
                          child: TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(
                                            255, 243, 234, 234))),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 243, 234, 234)),
                                ),
                                hintText: 'Payment Amount',
                                hintStyle: TextStyle(fontSize: 15)),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                color: Colors.black12,
                height: 5,
                indent: 20,
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: GFButton(
                        elevation: 10.0,
                        color: Color.fromARGB(255, 98, 218, 102),
                        onPressed: () {},
                        text: "SUBMIT",
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: GFButton(
                        elevation: 12.0,
                        color: Colors.white,
                        onPressed: () {},
                        text: "CANCEL",
                        textStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
