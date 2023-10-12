import 'package:flutter/material.dart';

import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:pos/category.dart';

import 'helper/connection.dart';

TextEditingController controllername = TextEditingController();
TextEditingController controllershort = TextEditingController();

TextEditingController controllerstatus = TextEditingController();

class Editing_category extends StatefulWidget {
  const Editing_category(
      {super.key, required Map<String, dynamic> this.categoryInfo});
  final Map<String, dynamic> categoryInfo;

  @override
  State<Editing_category> createState() => _Editing_productState();
}

class _Editing_productState extends State<Editing_category> {
  final List _listactivity = [
    "Active",
    "Inactive",
  ];
  String? _selectedVal = "Active";
  final formKey3 = GlobalKey<FormState>();
  void initState() {
    super.initState();

    setState(() {
      controllername.text = widget.categoryInfo['c_name'].toString();
      controllershort.text = widget.categoryInfo['c_short'];
      controllerstatus.text = widget.categoryInfo['c_status'].toString();
    });
  }

  // this.id,
  //   this.comp_id,
  //   this.c_id,
  //   this.c_name,
  //   this.c_short,
  //   this.c_status,
  //   this.created_at,
  //   this.update_at,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editing Category Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey3,
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
                            'Category Name',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllername,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Category Enter Name';
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
                              'Category Short',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllershort,
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
                                  if (formKey3.currentState!.validate()) {
                                    dynamic rs = await updatequery(
                                        "UPDATE `tbl_category` SET `c_name`='${controllername.text}',`c_short`='${controllershort.text}' WHERE `id`='${widget.categoryInfo['id']}'");

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
                                          builder: (context) => Categorypage(),
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
