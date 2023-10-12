import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account.dart';
import 'helper/connection.dart';

TextEditingController controlleraccroot = TextEditingController();
TextEditingController controlleraccname = TextEditingController();
TextEditingController controlleraccstatus = TextEditingController();

class Editing_account extends StatefulWidget {
  const Editing_account(
      {super.key, required Map<String, dynamic> this.accountInfo});
  final Map<String, dynamic> accountInfo;

  @override
  State<Editing_account> createState() => _Editing_productState();
}

class _Editing_productState extends State<Editing_account> {
  List<Map<String, dynamic>> accountrootdata = [];
  late String _accountrootvalue;
  final formKey8 = GlobalKey<FormState>();
  final List _listactivity = [
    "Active",
    "Inactive",
  ];
  String? _selectedVal = "Active";
  getOrder() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    try {
      List<dynamic> szresults = await SelectionQry(
          'SELECT `id`, `comp_id`, `acc_root`, `acc_root_name`, `acc_status`, `created_at`, `updated_at` FROM `tbl_account_root` WHERE `comp_id`="$comp_id"');
      accountrootdata.clear();

      for (var row in szresults) {
        accountrootdata.add({
          'acc_root': row['acc_root'],
          'acc_root_name': row['acc_root_name'],
        });
      }

      Timer(Duration(seconds: 5), () {
        setState(() {
          accountrootdata = accountrootdata;
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
    setState(() {
      _accountrootvalue = widget.accountInfo['acc_root'];
      controlleraccroot.text = widget.accountInfo['acc_root'].toString();
      controlleraccname.text = widget.accountInfo['acc_name'].toString();
      controlleraccstatus.text = widget.accountInfo['acc_status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Editing Account Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey8,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Account Root',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
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
                                    // staffid = _value;
                                  });
                                },
                                items: accountrootdata.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e["acc_root_name"]),
                                    value: e['acc_root'],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Account Name',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controlleraccname,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Account Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 234, 234))),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 234, 234)),
                                    ),
                                    hintText: 'Enter Name',
                                    hintStyle: TextStyle(fontSize: 15)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Account  Status',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                borderRadius: BorderRadius.circular(5),
                                border: const BorderSide(
                                    color: Colors.black12, width: 1),
                                dropdownButtonColor: Colors.white,
                                value: _selectedVal,
                                items: _listactivity
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  setState(() {
                                    _selectedVal = v as String;
                                    // staffid = _value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 30, top: 20),
                            child: Container(
                              height: 40.0,
                              width: 100.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey8.currentState!.validate()) {
                                    dynamic rs = await updatequery(
                                        "UPDATE `tbl_account` SET `acc_name`='${controlleraccname.text} WHERE `id`='${widget.accountInfo['id']}'");

                                    if (rs == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Updated Successfully..')),
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Accountpage(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Nothing has changed.')),
                                      );
                                    }
                                  }
                                },
                                child: Text('SUBMIT'),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 94, 214, 98)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, top: 20),
                            child: Container(
                              height: 40.0,
                              width: 100.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('CLOSE'),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
