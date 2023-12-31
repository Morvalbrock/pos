import 'package:flutter/material.dart';

import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

TextEditingController _controlleraccountrootname = TextEditingController();

class AddAccountRoot extends StatefulWidget {
  const AddAccountRoot({
    super.key,
  });

  @override
  State<AddAccountRoot> createState() => _AddAccountRootState();
}

final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

class _AddAccountRootState extends State<AddAccountRoot> {
  final formKeyss15 = GlobalKey<FormState>();
  final List _listactivity = [
    "Active",
    "Inactive",
  ];
  String? _selectedVal = "Active";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Add Accountroot',
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
                            'Account Root Name:',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Account Root Name';
                                }
                                return null;
                              },
                              controller: _controlleraccountrootname,
                              keyboardType: TextInputType.text,
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
                                  hintText: 'Enter Account Root Name',
                                  hintStyle: TextStyle(fontSize: 15)),
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
                              'Account Root Status:',
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

                                    var acc_root_id =
                                        "ARC${max_id.padLeft(3, '0')}";

                                    dynamic rs = await insertquery(
                                        "INSERT INTO `tbl_account_root`( `comp_id`, `acc_root`, `acc_root_name`, `acc_status`) VALUES ('${comp_id}','${acc_root_id}','${_controlleraccountrootname.text}','${_selectedVal}')");

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
                                              const AddAccountRoot(),
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
