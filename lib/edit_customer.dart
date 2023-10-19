import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:pos/customer.dart';
import 'package:intl/intl.dart';

import 'helper/connection.dart';

TextEditingController controllercustomername = TextEditingController();
TextEditingController controllercustomeraddress = TextEditingController();

TextEditingController controllercustomermobile = TextEditingController();

TextEditingController controllercustomeremail = TextEditingController();
TextEditingController controllercustomerdob = TextEditingController();
TextEditingController controllercustomerdetails = TextEditingController();

class Editing_customer extends StatefulWidget {
  const Editing_customer(
      {super.key, required Map<String, dynamic> this.customerInfo});
  final Map<String, dynamic> customerInfo;

  @override
  State<Editing_customer> createState() => _Editing_productState();
}

//  this.id,
//     this.comp_id,
//     this.sup_id,
//     this.sup_name,
//     this.sup_address,
//     this.sup_mobile,
//     this.sup_email,
//     this.sup_gst,
//     this.sup_details,
//     this.status,
//     this.created_at,
//     this.update_at,

class _Editing_productState extends State<Editing_customer> {
  final formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    setState(() {
      controllercustomername.text = widget.customerInfo['cus_name'].toString();
      controllercustomeraddress.text = widget.customerInfo['cus_address'];
      controllercustomermobile.text =
          widget.customerInfo['cus_mobile'].toString();
      controllercustomeremail.text =
          widget.customerInfo['cus_email'].toString();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(widget.customerInfo['cus_dob']);
      controllercustomerdob.text = formatted;
      controllercustomerdetails.text = widget.customerInfo['cus_details'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(236, 133, 36, 1),
          title: Text(
            'Editing Customer Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: formKey,
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
                              'Customer Name',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextFormField(
                                  controller: controllercustomername,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Name';
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
                                'Customer Address',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextField(
                                  controller: controllercustomeraddress,
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
                                'Customer Mobile',
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
                                  controller: controllercustomermobile,
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
                                'Customer Email',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Email id';
                                    }
                                    return null;
                                  },
                                  controller: controllercustomeremail,
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
                                      hintText: 'xyz@gmail.com',
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
                                'Customer DOB',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextField(
                                  controller: controllercustomerdob,
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
                                      hintText: 'Enter DOB',
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
                                'Customer Details',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextField(
                                  controller: controllercustomerdetails,
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
                                      hintText: 'Enter  Details',
                                      hintStyle: TextStyle(fontSize: 15)),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 20),
                              child: Container(
                                height: 40.0,
                                width: 100.0,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // if (formKey.currentState!.validate()) {}

                                    if (formKey.currentState!.validate()) {
                                      dynamic rs = await updatequery(
                                          "UPDATE `tbl_customer` SET `cus_name`='${controllercustomername.text}',`cus_address`='${controllercustomeraddress.text}',`cus_mobile`='${controllercustomermobile.text}',`cus_email`='${controllercustomeremail.text}',`cus_dob`='${controllercustomerdob.text}',`cus_details`='${controllercustomerdetails.text}' WHERE `id`='${widget.customerInfo['id']}'");

                                      if (rs == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Updated Successfully..')),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Customerpage(),
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
                                      primary:
                                          Color.fromARGB(255, 94, 214, 98)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 20),
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
        ));
  }
}

String? customername(String? value) {
  if (value!.length < 3)
    return 'Customer Name must be enter';
  else
    return null;
}

String? customeremail(String? value) {
  if (value!.length < 3)
    return 'Customer email must be enter';
  else
    return null;
}

String? customerMobile(String? value) {
  if (value!.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}
