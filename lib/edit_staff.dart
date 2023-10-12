import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom.dart';
import 'helper/connection.dart';
import 'staff.dart';

TextEditingController controllerstaffname = TextEditingController();
TextEditingController controllerstaffmobile = TextEditingController();
TextEditingController controllerstaffemail = TextEditingController();

TextEditingController controllerusername = TextEditingController();

TextEditingController controllerpassword = TextEditingController();

class Editing_staff extends StatefulWidget {
  const Editing_staff(
      {super.key, required Map<String, dynamic> this.staffInfo});
  final Map<String, dynamic> staffInfo;

  @override
  State<Editing_staff> createState() => _AddStaffState();
}

class _AddStaffState extends State<Editing_staff> {
  bool values = false;
  bool customer = false;
  bool staff = false;
  bool stock = false;
  bool sales = false;
  bool product = false;
  bool supplier = false;
  bool category = false;
  bool subcategory = false;
  bool unit = false;
  bool size = false;
  bool purchase = false;
  bool stackreport = false;
  bool invoicereport = false;
  bool account = false;
  bool payment = false;
  bool transaction = false;
  bool closing = false;
  final List _listactivity = [
    "Staff",
    "Admin",
  ];
  String? _selectedVal = "Staff";
  @override
  void initState() {
    super.initState();
    String privileges = widget.staffInfo['privileges'];
    List parts = privileges.split(",");

    setState(() {
      if (parts.contains('customer')) {
        customer = true;
      }

      if (parts.contains('staff')) {
        staff = true;
      }

      if (parts.contains('stock')) {
        stock = true;
      }

      if (parts.contains('sales')) {
        sales = true;
      }

      if (parts.contains('product')) {
        product = true;
      }

      if (parts.contains('supplier')) {
        supplier = true;
      }

      if (parts.contains('category')) {
        category = true;
      }

      if (parts.contains('subcategory')) {
        subcategory = true;
      }

      if (parts.contains('unit')) {
        unit = true;
      }

      if (parts.contains('size')) {
        size = true;
      }

      if (parts.contains('purchase')) {
        purchase = true;
      }

      if (parts.contains('account')) {
        account = true;
      }

      if (parts.contains('payments')) {
        payment = true;
      }

      if (parts.contains('transaction')) {
        transaction = true;
      }

      if (parts.contains('closing')) {
        closing = true;
      }

      if (parts.contains('stock_report')) {
        stackreport = true;
      }

      if (parts.contains('invoice_report')) {
        invoicereport = true;
      }
      controllerstaffname.text = widget.staffInfo['owner_name'].toString();
      controllerstaffmobile.text = widget.staffInfo['mobile_no'].toString();
      controllerstaffemail.text = widget.staffInfo['email'].toString();
      controllerusername.text = widget.staffInfo['username'].toString();
      controllerpassword.text = widget.staffInfo['password'].toString();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeeee),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Staff',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        elevation: 0,
      ),
      body: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.90,
          padding: EdgeInsets.only(left: 40.0, top: 45.0),
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Editing Staff Details',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50.0,
                      ),
                      child: Text(
                        'Staff Name',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff(
                        'Staff_Name',
                        MediaQuery.of(context).size.width * 0.20,
                        controllerstaffname,
                        'Enter Staff Name')
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50.0,
                      ),
                      child: Text(
                        'Mobile No',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff(
                        'Mobile_No',
                        MediaQuery.of(context).size.width * 0.20,
                        controllerstaffmobile,
                        'Enter Mobile Number'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff(
                        'Email',
                        MediaQuery.of(context).size.width * 0.20,
                        controllerstaffemail,
                        'Enter Email'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Text(
                        'Username',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff(
                        'Username',
                        MediaQuery.of(context).size.width * 0.20,
                        controllerusername,
                        'Enter User Name'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff(
                        'Password',
                        MediaQuery.of(context).size.width * 0.20,
                        controllerpassword,
                        'Enter Password'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Text(
                            'Type',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.19,
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
                        ),
                      ],
                    ),
                    Container(
                      width: 180,
                      height: 80,
                      padding: EdgeInsets.only(top: 40.0, left: 60.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          List priviledge = [];
                          if (values == true) {
                            priviledge.addAll([
                              'customer',
                              'staff',
                              'stock',
                              'sales',
                              'product',
                              'supplier',
                              'category',
                              'subcategory',
                              'unit',
                              'size',
                              'purchase',
                              'account',
                              'payments',
                              'transaction',
                              'closing',
                              'stock_report',
                              'invoice_report'
                            ]);
                          } else {
                            if (customer == true) {
                              priviledge.add('customer');
                            }
                            if (staff == true) {
                              priviledge.add('staff');
                            }
                            if (stock == true) {
                              priviledge.add('stock');
                            }
                            if (sales == true) {
                              priviledge.add('sales');
                            }
                            if (account == true) {
                              priviledge.add('account');
                            }
                            if (payment == true) {
                              priviledge.add('payments');
                            }
                            if (transaction == true) {
                              priviledge.add('transaction');
                            }
                            if (closing == true) {
                              priviledge.add('closing');
                            }
                            if (product == true) {
                              priviledge.add('product');
                            }
                            if (supplier == true) {
                              priviledge.add('supplier');
                            }
                            if (category == true) {
                              priviledge.add('category');
                            }
                            if (subcategory == true) {
                              priviledge.add('subcategory');
                            }
                            if (unit == true) {
                              priviledge.add('unit');
                            }
                            if (size == true) {
                              priviledge.add('size');
                            }
                            if (purchase == true) {
                              priviledge.add('purchase');
                            }
                            if (stackreport == true) {
                              priviledge.add('stock_report');
                            }
                            if (invoicereport == true) {
                              priviledge.add('invoice_report');
                            }
                          }
                          String privlge = priviledge.join(',');
                          // print(privlge);
                          dynamic rs = await updatequery(
                              "UPDATE `users` SET `owner_name`='${controllerstaffname.text}',`mobile_no`='${controllerstaffmobile.text}',`email`='${controllerstaffemail.text}',`username`='${controllerusername.text}',`password`='${controllerpassword.text}',`privileges`='${privlge}' WHERE id=${widget.staffInfo['id']}");

                          if (rs == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Staffpage(),
                              ),
                            );
                          } else {}
                        },
                        child: Text('SUBMIT'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 73, 199, 77),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.50,
          height: MediaQuery.of(context).size.height * 0.90,
          padding: EdgeInsets.only(top: 45.0, left: 55.0),
          child: Card(
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Privileges',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.0),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Checkbox(
                                value: values,
                                onChanged: (value) {
                                  setState(() {
                                    values = value!;
                                  });
                                }),
                          ),
                          Text('Select All')
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 260,
                        margin: EdgeInsets.only(
                            left: 30, bottom: 10, right: 10, top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color.fromARGB(255, 160, 158, 158),
                          width: 1,
                        )),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Main Menu:'),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: customer || values,
                                        onChanged: (value) {
                                          setState(() {
                                            customer = value!;
                                          });
                                        }),
                                    Text('Customer'),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: staff || values,
                                    onChanged: (value) {
                                      setState(() {
                                        staff = value!;
                                      });
                                    }),
                                Text('Staff'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: stock || values,
                                    onChanged: (value) {
                                      setState(() {
                                        stock = value!;
                                      });
                                    }),
                                Text('Stock'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: sales || values,
                                    onChanged: (value) {
                                      setState(() {
                                        sales = value!;
                                      });
                                    }),
                                Text('Sales'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 260,
                        margin: EdgeInsets.only(
                            left: 30, bottom: 10, right: 10, top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color.fromARGB(255, 160, 158, 158),
                          width: 1,
                        )),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Masters:'),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: product || values,
                                    onChanged: (value) {
                                      setState(() {
                                        product = value!;
                                      });
                                    }),
                                Text('Product'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: supplier || values,
                                    onChanged: (value) {
                                      setState(() {
                                        supplier = value!;
                                      });
                                    }),
                                Text('Supplier'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: category || values,
                                    onChanged: (value) {
                                      setState(() {
                                        category = value!;
                                      });
                                    }),
                                Text('Category')
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: subcategory || values,
                                    onChanged: (value) {
                                      setState(() {
                                        subcategory = value!;
                                      });
                                    }),
                                Text('SubCategory')
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: unit || values,
                                    onChanged: (value) {
                                      setState(() {
                                        unit = value!;
                                      });
                                    }),
                                Text('Unit')
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: size || values,
                                    onChanged: (value) {
                                      setState(() {
                                        size = value!;
                                      });
                                    }),
                                Text('Size')
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: purchase || values,
                                    onChanged: (value) {
                                      setState(() {
                                        purchase = value!;
                                      });
                                    }),
                                Text('Purchase')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 110.0,
                    ),
                    Container(
                      width: 270,
                      height: 185.0,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: const Color.fromARGB(255, 160, 158, 158),
                        width: 1,
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account:'),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: account || values,
                                  onChanged: (value) {
                                    setState(() {
                                      account = value!;
                                    });
                                  }),
                              Text('Account'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: payment || values,
                                  onChanged: (value) {
                                    setState(() {
                                      payment = value!;
                                    });
                                  }),
                              Text('Payments')
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: transaction || values,
                                  onChanged: (value) {
                                    setState(() {
                                      transaction = value!;
                                    });
                                  }),
                              Text('Transaction')
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: closing || values,
                                  onChanged: (value) {
                                    setState(() {
                                      closing = value!;
                                    });
                                  }),
                              Text('Closing')
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 270,
                      height: 267.0,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: const Color.fromARGB(255, 160, 158, 158),
                        width: 1,
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reports:'),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: stackreport || values,
                                  onChanged: (value) {
                                    setState(() {
                                      stackreport = value!;
                                    });
                                  }),
                              Text('Stock Report')
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: invoicereport || values,
                                  onChanged: (value) {
                                    setState(() {
                                      invoicereport = value!;
                                    });
                                  }),
                              Text('Invoice Report')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
