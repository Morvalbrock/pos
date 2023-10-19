import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:pos/suppliers.dart';

import 'helper/connection.dart';

TextEditingController controllersuppliername = TextEditingController();
TextEditingController controllersupplieraddress = TextEditingController();

TextEditingController controllersuppliermobile = TextEditingController();

TextEditingController controllersupplieremail = TextEditingController();
TextEditingController controllersuppliergst = TextEditingController();
TextEditingController controllersupplierdetails = TextEditingController();

class Editing_supplier extends StatefulWidget {
  const Editing_supplier(
      {super.key, required Map<String, dynamic> this.supplierInfo});
  final Map<String, dynamic> supplierInfo;

  @override
  State<Editing_supplier> createState() => _Editing_productState();
}

final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

class _Editing_productState extends State<Editing_supplier> {
  final formKey2 = GlobalKey<FormState>();
  void initState() {
    super.initState();
    setState(() {
      controllersuppliername.text = widget.supplierInfo['sup_name'].toString();
      controllersupplieraddress.text = widget.supplierInfo['sup_address'];
      controllersuppliermobile.text =
          widget.supplierInfo['sup_mobile'].toString();
      controllersupplieremail.text =
          widget.supplierInfo['sup_email'].toString();
      controllersuppliergst.text = widget.supplierInfo['sup_gst'].toString();
      controllersupplierdetails.text = widget.supplierInfo['sup_details'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        title: Text(
          'Editing Supplier Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey2,
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
                            'Supplier Name',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllersuppliername,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Supplier Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
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
                              'Supplier Address',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                validator: supplieraddress,
                                controller: controllersupplieraddress,
                                decoration: InputDecoration(
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
                                    hintText: 'Enter Address',
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
                              'Supplier Mobile',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length != 10) {
                                    return 'Please Enter mobile number';
                                  }
                                  return null;
                                },
                                controller: controllersuppliermobile,
                                decoration: InputDecoration(
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
                                    hintText: 'Enter Mobile',
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
                              'Supplier Email',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllersupplieremail,
                                decoration: InputDecoration(
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
                                    hintText: 'Enter Email',
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
                              'Supplier GST',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllersuppliergst,
                                decoration: InputDecoration(
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
                                    hintText: 'Enter GST',
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
                              'Supplier Details',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllersupplierdetails,
                                decoration: InputDecoration(
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
                                    hintText: 'Enter  Details',
                                    hintStyle: TextStyle(fontSize: 15)),
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
                                  if (formKey2.currentState!.validate()) {
                                    dynamic rs = await updatequery(
                                        "UPDATE `tbl_supplier` SET `sup_name`='${controllersuppliername.text}',`sup_address`='${controllersupplieraddress.text}',`sup_mobile`='${controllersuppliermobile.text}',`sup_email`='${controllersupplieremail.text}',`sup_gst`='${controllersuppliergst.text}',`sup_details`='${controllersupplierdetails.text}' WHERE `id`='${widget.supplierInfo['id']}'");

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
                                          builder: (context) => Supplierpage(),
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

String? suppliername(String? value) {
  if (value!.length < 3)
    return 'Supplier Name must be enter';
  else
    return null;
}

String? supplieraddress(String? value) {
  if (value!.length < 3)
    return 'Supplier address must be enter';
  else
    return null;
}

String? supplierMobile(String? value) {
  if (value!.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}
