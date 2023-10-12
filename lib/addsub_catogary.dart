import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

TextEditingController _controllersubcatogaryname = TextEditingController();
TextEditingController _controllersubcatogaryshort = TextEditingController();

class AddSubCatogary extends StatefulWidget {
  const AddSubCatogary({
    super.key,
  });

  @override
  State<AddSubCatogary> createState() => _AddSubCatogaryState();
}

final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

class _AddSubCatogaryState extends State<AddSubCatogary> {
  final formKeyss15 = GlobalKey<FormState>();
  final List _listactivity = [
    "Active",
    "Inactive",
  ];
  String? _selectedVals = "Active";
  List<Map<String, dynamic>> categorydatas = [];
  List<Map<String, dynamic>> subcategorydatas = [];
  String _categorys = '';
  String _subcategorys = '';
  getOrders() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    try {
      List<dynamic> categorys = await SelectionQry(
          'SELECT  c_id, c_name FROM `tbl_category` WHERE `comp_id`="$comp_id"');
      List<dynamic> sub_categorys = await SelectionQry(
          'SELECT  `s_c_id`, `s_c_name` FROM `tbl_sub_category` WHERE `comp_id`="$comp_id"');
      categorydatas.clear();
      subcategorydatas.clear();
      subcategorydatas.add({
        's_c_id': '',
        's_c_name': 'Choose',
      });
      for (var row in sub_categorys) {
        subcategorydatas.add({
          's_c_id': row['s_c_id'],
          's_c_name': row['s_c_name'],
        });
      }

      categorydatas.add({
        'c_id': '',
        'c_name': 'Choose',
      });
      for (var row in categorys) {
        categorydatas.add({
          'c_id': row['c_id'],
          'c_name': row['c_name'],
        });
      }

      Timer(const Duration(seconds: 5), () {
        setState(() {
          categorydatas = categorydatas;
          subcategorydatas = subcategorydatas;
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
          title: const Text(
        'Add SubCatogary',
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Catagory:',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                borderRadius: BorderRadius.circular(5),
                                border: const BorderSide(
                                    color: Colors.black12, width: 1),
                                dropdownButtonColor: Colors.white,
                                value: _categorys,
                                onChanged: (v) {
                                  setState(() {
                                    _categorys = v.toString();
                                    // staffid = _value;
                                  });
                                },
                                items: categorydatas.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e["c_name"]),
                                    value: e['c_id'],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'SubCategory Name:',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter  Product Name';
                                }
                                return null;
                              },
                              controller: _controllersubcatogaryname,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 234, 234))),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 243, 234, 234)),
                                  ),
                                  hintText: 'Enter Category Name',
                                  hintStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'SubCatagory:',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                borderRadius: BorderRadius.circular(5),
                                border: const BorderSide(
                                    color: Colors.black12, width: 1),
                                dropdownButtonColor: Colors.white,
                                value: _subcategorys,
                                onChanged: (v) {
                                  setState(() {
                                    _subcategorys = v.toString();
                                    // staffid = _value;
                                  });
                                },
                                items: subcategorydatas.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e["s_c_name"]),
                                    value: e['s_c_id'],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Text(
                              'SubCategory Short:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: _controllersubcatogaryshort,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ' Enter Category Short';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
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
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Text(
                              'Status:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
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

                                    var c_id = "C${max_id.padLeft(3, '0')}";

                                    dynamic rs = await insertquery(
                                        "INSERT INTO `tbl_sub_category`( `comp_id`, `c_id`, `s_c_id`, `s_c_name`, `s_c_short`, `s_c_status`) VALUES ('${comp_id}','${c_id}','${_subcategorys}','${_controllersubcatogaryname.text}','${_controllersubcatogaryshort.text}','${_selectedVals}')");

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
                                              const AddSubCatogary(),
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
                                child: const Text('Save'),
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 94, 214, 98)),
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                child: const Text('CLOSE'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
