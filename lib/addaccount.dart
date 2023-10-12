import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

TextEditingController _controlleraccountnamename = TextEditingController();
// TextEditingController _controllersubcatogaryshort = TextEditingController();

class AddAccount extends StatefulWidget {
  const AddAccount({
    super.key,
  });

  @override
  State<AddAccount> createState() => _AddAccountState();
}

final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

class _AddAccountState extends State<AddAccount> {
  final formKeyss15 = GlobalKey<FormState>();
  final List _listactivity = [
    "Active",
    "Inactive",
  ];
  String? _selectedVals = "Active";

  List<Map<String, dynamic>> account_rootdata = [];

  String _accountrootvalue = '';

  getOrders() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    try {
      List<dynamic> accountrooot = await SelectionQry(
          'SELECT  `acc_root`, `acc_root_name` FROM `tbl_account_root` WHERE `comp_id`="$comp_id"');

      account_rootdata.clear();

      account_rootdata.add({
        'acc_root': '',
        'acc_root_name': 'Choose',
      });
      for (var row in accountrooot) {
        account_rootdata.add({
          'acc_root': row['acc_root'],
          'acc_root_name': row['acc_root_name'],
        });
      }

      Timer(Duration(seconds: 5), () {
        setState(() {
          account_rootdata = account_rootdata;
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
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Add Account',
        style: TextStyle(color: Colors.white),
      )),
      body: Form(
        key: formKeyss15,
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
                            'Account Root:',
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
                                items: account_rootdata.map((e) {
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
                          Container(
                            child: Text(
                              'Account Name:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: _controlleraccountnamename,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ' Enter Category Short';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 243, 234, 234),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 243, 234, 234),
                                    ),
                                  ),
                                  hintText: 'Enter Address',
                                  hintStyle: TextStyle(fontSize: 15),
                                ),
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
                              'Account Status:',
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
                                value: _selectedVals,
                                items: _listactivity
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  setState(() {
                                    _selectedVals = v as String;
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
                                  if (formKeyss15.currentState!.validate()) {
                                    List maxid = [];
                                    var max_id = '';
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    var comp_id = prefs.getString('comp_id');
                                    List<dynamic> data = await SelectionQry(
                                        'SELECT max(id) as maxid FROM `tbl_customer` where comp_id="${comp_id}"');

                                    maxid.clear();

                                    for (var row in data) {
                                      setState(() {
                                        print(row['maxid']);
                                        max_id = (row['maxid'] + 1).toString();
                                      });
                                    }

                                    var acc_id = "ACC${max_id.padLeft(3, '0')}";

                                    dynamic rs = await insertquery(
                                        "INSERT INTO `tbl_account`( `comp_id`, `acc_id`, `acc_root`, `acc_name`, `acc_status`) VALUES ('${comp_id}','${acc_id}','${_accountrootvalue}','${_controlleraccountnamename.text}','${_selectedVals}')");

                                    if (rs == true) {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Updated Successfully..')),
                                      );
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddAccount(),
                                        ),
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Nothing has changed.')),
                                      );
                                    }
                                  }
                                },
                                child: Text('Save'),
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('CLOSE'),
                              ),
                            ),
                          ),
                        ],
                      ),
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

String? Productname(String? value) {
  if (value!.length < 3)
    return 'Product Name must be enter';
  else
    return null;
}

String? Productdetails(String? value) {
  if (value!.length < 3)
    return 'Product Productdetails must be enter';
  else
    return null;
}
