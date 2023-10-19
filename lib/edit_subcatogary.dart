import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:pos/subcategory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

TextEditingController controllercname = TextEditingController();
TextEditingController controllersubname = TextEditingController();
TextEditingController controllersubshort = TextEditingController();

TextEditingController controllersubstatus = TextEditingController();

class Editing_subcategory extends StatefulWidget {
  const Editing_subcategory(
      {super.key, required Map<String, dynamic> this.subcategoryInfo});
  final Map<String, dynamic> subcategoryInfo;

  @override
  State<Editing_subcategory> createState() => _Editing_productState();
}

class _Editing_productState extends State<Editing_subcategory> {
  List<Map<String, dynamic>> categorydata = [];
  late String _categoryvalue;
  final formKey4 = GlobalKey<FormState>();
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
          'SELECT  `id`,`c_id`, `c_name` FROM `tbl_category` WHERE `comp_id`="$comp_id"');
      categorydata.clear();

      for (var row in szresults) {
        categorydata.add({
          'c_id': row['c_id'],
          'c_name': row['c_name'],
        });
      }

      Timer(Duration(seconds: 5), () {
        setState(() {
          categorydata = categorydata;
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
      _categoryvalue = widget.subcategoryInfo['c_id'];
      controllercname.text = widget.subcategoryInfo['c_name'].toString();
      controllersubname.text = widget.subcategoryInfo['s_c_name'].toString();
      controllersubshort.text = widget.subcategoryInfo['s_c_short'];
      controllersubstatus.text =
          widget.subcategoryInfo['s_c_status'].toString();
    });
  }

  // this.id,
  //   this.comp_id,
  //   this.c_id,
  //   this.s_c_id,
  //   this.sub_id,
  //   this.s_c_name,
  //   this.s_c_short,
  //   this.s_c_status,
  //   this.created_at,
  //   this.update_at,
  //   this.c_name,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        title: Text(
          'Editing Subcatogary Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey4,
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
                            'Category',
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
                                value: _categoryvalue,
                                onChanged: (v) {
                                  setState(() {
                                    _categoryvalue = v.toString();
                                    // staffid = _value;
                                  });
                                },
                                items: categorydata.map((e) {
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
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'SubCategory Name ',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllersubname,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter SubCategory Name';
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
                              'SubCategory Short',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllersubshort,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Short Name';
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
                                    hintText: 'Enter Short',
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
                              'SubCategory Status',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              'Category Status',
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
                                  if (formKey4.currentState!.validate()) {
                                    dynamic rs = await updatequery(
                                        "UPDATE `tbl_sub_category` SET `s_c_name`='${controllersubname.text}',`s_c_short`='${controllersubshort.text}' WHERE `id`='${widget.subcategoryInfo['id']}'");

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
                                          builder: (context) =>
                                              Subcategorypage(),
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
                                child: Text('Update'),
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
