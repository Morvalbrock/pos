import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:pos/unit.dart';

import 'helper/connection.dart';

TextEditingController controllerunitname = TextEditingController();
TextEditingController controllerunitstatus = TextEditingController();

class Editing_unit extends StatefulWidget {
  const Editing_unit({super.key, required Map<String, dynamic> this.unitInfo});
  final Map<String, dynamic> unitInfo;

  @override
  State<Editing_unit> createState() => _Editing_productState();
}

class _Editing_productState extends State<Editing_unit> {
  final List _listactivity = [
    "Active",
    "Inactive",
  ];
  String? _selectedVal = "Active";
  final formKey6 = GlobalKey<FormState>();
  void initState() {
    super.initState();
    setState(() {
      controllerunitname.text = widget.unitInfo['u_name'].toString();
      controllerunitstatus.text = widget.unitInfo['u_status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        title: Text(
          "Editing Unit Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey6,
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
                            'Unit Name',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllerunitname,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Unit enter Name';
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
                              'Unit Status',
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
                                  if (formKey6.currentState!.validate()) {
                                    dynamic rs = await updatequery(
                                        "UPDATE `tbl_unit` SET `u_name`='${controllerunitname.text} WHERE `id`='${widget.unitInfo['id']}'");

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
                                          builder: (context) => Unitpage(),
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
