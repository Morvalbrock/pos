import 'package:flutter/material.dart';

import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

TextEditingController _controllercusaddname = TextEditingController();
TextEditingController _controllercusaddaddress = TextEditingController();
TextEditingController _controllercusaddmobile = TextEditingController();
TextEditingController _controllercusaddemail = TextEditingController();
TextEditingController _controllercusadddob = TextEditingController();
TextEditingController _controllercusadddetails = TextEditingController();
TextEditingController _controllercusdate = TextEditingController();

class AddCustomer extends StatefulWidget {
  const AddCustomer({
    super.key,
  });

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

class _AddCustomerState extends State<AddCustomer> {
  final formKeyss13 = GlobalKey<FormState>();

  Future<void> _showDatePickers() async {
    _controllercusadddob.text = DateTime.now().toString();
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
    );
    if (_picked != null) {
      setState(() {
        _controllercusadddob.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Add Customer',
        style: TextStyle(color: Colors.white),
      )),
      body: Form(
        key: formKeyss13,
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
                            'Customer Name:',
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
                              controller: _controllercusaddname,
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
                                  hintText: 'Enter Customer Name',
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
                          Container(
                            child: const Text(
                              'Customer Address:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: _controllercusaddaddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Supplier Address';
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
                              'Customer Mobile:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: _controllercusaddmobile,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Supplier Address';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 234, 234))),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 234, 234)),
                                    ),
                                    hintText: 'Enter  Mobile',
                                    hintStyle: TextStyle(fontSize: 15)),
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
                              'Customer Email:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: _controllercusaddemail,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 234, 234))),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 234, 234)),
                                    ),
                                    hintText: 'Enter  Email',
                                    hintStyle: TextStyle(fontSize: 15)),
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
                              'Customer DOB:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: _controllercusadddob,
                                onTap: () {
                                  _showDatePickers();
                                },
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 234, 234))),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 234, 234)),
                                    ),
                                    hintText: 'Enter  DOB',
                                    hintStyle: TextStyle(fontSize: 15)),
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
                              'Customer Details:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: _controllercusadddetails,
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
                                  hintText: 'Enter Details',
                                  hintStyle: TextStyle(fontSize: 15),
                                ),
                              )),
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
                                  if (formKeyss13.currentState!.validate()) {
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

                                    var cusId = "CUS${max_id.padLeft(5, '0')}";

                                    dynamic rs = await insertquery(
                                        "INSERT INTO `tbl_customer`(  `comp_id`, `cus_id`,`cus_name`, `cus_address`, `cus_mobile`, `cus_email`, `cus_dob`, `cus_details`) VALUES ('${comp_id.toString()}','${cusId.toString()}','${_controllercusaddname.text}','${_controllercusaddaddress.text}','${_controllercusaddmobile.text}','${_controllercusaddemail.text}','${_controllercusadddob.text}','${_controllercusadddetails.text}')");

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
                                                const AddCustomer()),
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
