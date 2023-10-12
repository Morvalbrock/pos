import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:pos/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

TextEditingController controller_add_product = TextEditingController();
TextEditingController controllersize = TextEditingController();
TextEditingController controllerunit = TextEditingController();

TextEditingController controller_add_productdetails = TextEditingController();

TextEditingController controller_add_existing = TextEditingController();
TextEditingController controller_add_catogary = TextEditingController();

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

class _AddProductState extends State<AddProduct> {
  final formKeyss1 = GlobalKey<FormState>();
  List<Map<String, dynamic>> sizedata = [];
  List<Map<String, dynamic>> unitdata = [];
  List<Map<String, dynamic>> categorydata = [];
  List<Map<String, dynamic>> subcategorydata = [];
  String _szvalue = '';
  String _uvalue = '';
  String _category = '';
  String _subcategory = '';
  getOrders() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    try {
      List<dynamic> szresults = await SelectionQry(
          'SELECT id,sz_id,sz_name FROM `tbl_size` WHERE `comp_id`="$comp_id"');
      sizedata.clear();
      List<dynamic> uresults = await SelectionQry(
          'SELECT id,u_id,u_name FROM `tbl_unit` WHERE `comp_id`="$comp_id"');
      List<dynamic> category = await SelectionQry(
          'SELECT  c_id, c_name FROM `tbl_category` WHERE `comp_id`="$comp_id"');
      List<dynamic> sub_category = await SelectionQry(
          'SELECT  `s_c_id`, `s_c_name` FROM `tbl_sub_category` WHERE `comp_id`="$comp_id"');
      sizedata.clear();
      unitdata.clear();
      categorydata.clear();
      subcategorydata.clear();

      subcategorydata.add({
        's_c_id': '',
        's_c_name': 'Choose',
      });
      for (var row in sub_category) {
        subcategorydata.add({
          's_c_id': row['s_c_id'],
          's_c_name': row['s_c_name'],
        });
      }

      categorydata.add({
        'c_id': '',
        'c_name': 'Choose',
      });
      for (var row in category) {
        categorydata.add({
          'c_id': row['c_id'],
          'c_name': row['c_name'],
        });
      }
      sizedata.add({
        'sz_id': '',
        'sz_name': 'Choose',
      });
      for (var row in szresults) {
        sizedata.add({
          'sz_id': row['sz_id'],
          'sz_name': row['sz_name'],
        });
      }
      unitdata.add({
        'u_id': '',
        'u_name': 'Choose',
      });
      for (var res in uresults) {
        unitdata.add({
          'u_id': res['u_id'],
          'u_name': res['u_name'],
        });
      }
      Timer(const Duration(seconds: 5), () {
        setState(() {
          sizedata = sizedata;
          unitdata = unitdata;
          categorydata = categorydata;
          subcategorydata = subcategorydata;
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
    print(sizedata);
    // setState(() {
    //   _szvalue = 'Choose';
    //   _uvalue = 'Choose';
    //   // controller_add_product.text = widget.productInfo['p_name'].toString();
    //   // // _value = widget.productInfo['sz_id'];
    //   // controllerunit.text = widget.productInfo['u_name'].toString();
    //   // controller_add_productdetails.text =
    //   //     widget.productInfo['P_details'].toString();
    //   // controller_add_existing.text =
    //   //     widget.productInfo['p_barcode'].toString() != 'null'
    //   //         ? widget.productInfo['p_barcode'].toString()
    //   //         : '';
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Add Product ',
        style: TextStyle(color: Colors.white),
      )),
      body: Form(
        key: formKeyss1,
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
                            'Product Name:',
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
                              controller: controller_add_product,
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
                                  hintText: 'Enter Product Name',
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
                            'Size:',
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
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Unit:',
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
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Text(
                              'Product Details:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controller_add_productdetails,
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
                                  hintText: 'Product Details',
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
                                value: _category,
                                onChanged: (v) {
                                  setState(() {
                                    _category = v.toString();
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
                                value: _subcategory,
                                onChanged: (v) {
                                  setState(() {
                                    _subcategory = v.toString();
                                    // staffid = _value;
                                  });
                                },
                                items: subcategorydata.map((e) {
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
                              'Existing Barcode:',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextFormField(
                                controller: controller_add_existing,
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
                                  if (formKeyss1.currentState!.validate()) {
                                    List maxid = [];
                                    var max_id = '';
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    var comp_id = prefs.getString('comp_id');
                                    List<dynamic> data = await SelectionQry(
                                        'SELECT max(id) as maxid FROM `tbl_product` where comp_id="${comp_id}"');

                                    maxid.clear();

                                    for (var row in data) {
                                      setState(() {
                                        print(row['maxid']);
                                        max_id = (row['maxid'] + 1).toString();
                                      });
                                    }

                                    var P_Id = "P${max_id.padLeft(5, '0')}";
                                    print(
                                      "INSERT INTO `tbl_product`( `comp_id`, `p_id`,  `c_id`,`s_c_id`,  `u_id`, `sz_id`,    `p_name`, `p_details`, `p_barcode`) VALUES ('${comp_id}','${P_Id}','${_category}','${_subcategory}','${_uvalue}','${_szvalue}','${controller_add_product.text}','${controller_add_productdetails.text}','${controller_add_existing.text}')",
                                    );
                                    dynamic rs = await insertquery(
                                        "INSERT INTO `tbl_product`( `comp_id`, `p_id`,  `c_id`,`s_c_id`,  `u_id`, `sz_id`,    `p_name`, `p_details`, `p_barcode`) VALUES ('${comp_id}','${P_Id}','${_category}','${_subcategory}','${_uvalue}','${_szvalue}','${controller_add_product.text}','${controller_add_productdetails.text}','${controller_add_existing.text}')");

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
                                              const AddProduct(),
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
