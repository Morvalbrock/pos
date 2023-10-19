import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:pos/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

TextEditingController controllerproduct = TextEditingController();
TextEditingController controllersize = TextEditingController();
TextEditingController controllerunit = TextEditingController();

TextEditingController controllerproductdetails = TextEditingController();

TextEditingController controllerexisting = TextEditingController();

class Editing_product extends StatefulWidget {
  const Editing_product(
      {super.key, required Map<String, dynamic> this.productInfo});
  final Map<String, dynamic> productInfo;

  @override
  State<Editing_product> createState() => _Editing_productState();
}

final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

class _Editing_productState extends State<Editing_product> {
  final formKey1 = GlobalKey<FormState>();
  List<Map<String, dynamic>> sizedata = [];
  List<Map<String, dynamic>> unitdata = [];
  late String _szvalue;
  late String _uvalue;
  getOrder() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    try {
      List<dynamic> szresults = await SelectionQry(
          'SELECT id,sz_id,sz_name FROM `tbl_size` WHERE `comp_id`="$comp_id"');
      sizedata.clear();
      List<dynamic> uresults = await SelectionQry(
          'SELECT id,u_id,u_name FROM `tbl_unit` WHERE `comp_id`="$comp_id"');
      sizedata.clear();
      unitdata.clear();
      for (var row in szresults) {
        sizedata.add({
          'sz_id': row['sz_id'],
          'sz_name': row['sz_name'],
        });
      }
      for (var res in uresults) {
        unitdata.add({
          'u_id': res['u_id'],
          'u_name': res['u_name'],
        });
      }
      Timer(Duration(seconds: 5), () {
        setState(() {
          sizedata = sizedata;
          unitdata = unitdata;
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
      _szvalue = widget.productInfo['sz_id'];
      _uvalue = widget.productInfo['u_id'];
      controllerproduct.text = widget.productInfo['p_name'].toString();
      // _value = widget.productInfo['sz_id'];
      controllerunit.text = widget.productInfo['u_name'].toString();
      controllerproductdetails.text =
          widget.productInfo['P_details'].toString();
      controllerexisting.text =
          widget.productInfo['p_barcode'].toString() != 'null'
              ? widget.productInfo['p_barcode'].toString()
              : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(236, 133, 36, 1),
          title: Text(
            'Edit Product Details',
            style: TextStyle(color: Colors.white),
          )),
      body: Form(
        key: formKey1,
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
                            'Product Name:',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Spacer(),
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
                              controller: controllerproduct,
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
                                  hintText: 'Enter Product Name',
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
                          Text(
                            'Size:',
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
                                value: _szvalue,
                                onChanged: (v) {
                                  setState(() {
                                    _szvalue = v.toString();
                                    // staffid = _value;
                                  });
                                },
                                items: sizedata.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e["sz_name"]),
                                    value: e['sz_id'],
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
                            'Unit:',
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
                                value: _uvalue,
                                onChanged: (v) {
                                  setState(() {
                                    _uvalue = v.toString();
                                    // staffid = _value;
                                  });
                                },
                                items: unitdata.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e["u_name"]),
                                    value: e['u_id'],
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
                              'Product Details:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllerproductdetails,
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
                                  hintText: 'Product Details',
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
                              'Existing Barcode:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controllerexisting,
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
                                    hintText: 'Enter  Barcode',
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
                                  if (formKey1.currentState!.validate()) {
                                    dynamic rs = await updatequery(
                                        "UPDATE `tbl_product` SET `p_name`='${controllerproduct.text}',`p_details`='${controllerproductdetails.text}',`p_barcode`='${controllerexisting.text}' WHERE `id`='${widget.productInfo['id']}'");

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
                                          builder: (context) => Productpage(),
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
                                child: Text('UPDATE'),
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
