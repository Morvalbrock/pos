import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:pos/staff.dart';
import 'package:pos/suppliers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom.dart';
import 'helper/connection.dart';

TextEditingController controllerstaffname_add = TextEditingController();
TextEditingController controllerstaffmobile_add = TextEditingController();
TextEditingController controllerstaffemail_add = TextEditingController();

TextEditingController controllerusername_add = TextEditingController();

TextEditingController controllerpassword_add = TextEditingController();

class AddStaff extends StatefulWidget {
  // const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

final TextEditingController _controller = TextEditingController();

final _listStaff = [
  "Staff",
  "Admin",
];

class _AddStaffState extends State<AddStaff> {
  @override
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffeeeee),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(236, 133, 36, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Staff',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        elevation: 0,
      ),
      body: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.90,
          padding: const EdgeInsets.only(left: 40.0, top: 45.0),
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Staff Details',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 50.0,
                      ),
                      child: Text(
                        'Staff Name',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff('Staff_Name', 300, controllerstaffname_add,
                        'Enter Staff Name')
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 50.0,
                      ),
                      child: Text(
                        'Mobile No',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff('Mobile_No', 300, controllerstaffmobile_add,
                        'Enter Mobile Number'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff(
                        'Email', 300, controllerstaffemail_add, 'Enter Email'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Text(
                        'Username',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff('Username', 300, controllerusername_add,
                        'Enter User Name'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Textfieldstaff('Password', 300, controllerpassword_add,
                        'Enter Password'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Text(
                            'Type',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.182,
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
                      padding: const EdgeInsets.only(top: 40.0, left: 60.0),
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
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var comp_id = prefs.getString('comp_id');
                          // print(privlge);
                          dynamic rs = await updatequery(
                              "INSERT INTO `users`(`company_id`,`owner_name`, `mobile_no`, `email`, `username`, `password`, `type`, `privileges`) VALUES ('$comp_id','${controllerstaffname_add.text}','${controllerstaffmobile_add.text}','${controllerstaffemail_add.text}','${controllerusername_add.text}','${controllerpassword_add.text}','${_selectedVal}','${privlge}')");

                          if (rs == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Staffpage(),
                              ),
                            );
                          } else {}
                        },
                        child: const Text('SUBMIT'),
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
          padding: const EdgeInsets.only(top: 45.0, left: 55.0),
          child: Card(
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
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
                          const Text('Select All')
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 260,
                        margin: const EdgeInsets.only(
                            left: 30, bottom: 10, right: 10, top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color.fromARGB(255, 160, 158, 158),
                          width: 1,
                        )),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text('Main Menu:'),
                              ],
                            ),
                            const SizedBox(
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
                                    const Text('Customer'),
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
                                const Text('Staff'),
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
                                const Text('Stock'),
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
                                const Text('Sales'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 260,
                        margin: const EdgeInsets.only(
                            left: 30, bottom: 10, right: 10, top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color.fromARGB(255, 160, 158, 158),
                          width: 1,
                        )),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text('Masters:'),
                              ],
                            ),
                            const SizedBox(
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
                                const Text('Product'),
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
                                const Text('Supplier'),
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
                                const Text('Category')
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
                                const Text('SubCategory')
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
                                const Text('Unit')
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
                                const Text('Size')
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
                                const Text('Purchase')
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
                    const SizedBox(
                      height: 110.0,
                    ),
                    Container(
                      width: 270,
                      height: 185.0,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: const Color.fromARGB(255, 160, 158, 158),
                        width: 1,
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Account:'),
                          const SizedBox(
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
                              const Text('Account'),
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
                              const Text('Payments')
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
                              const Text('Transaction')
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
                              const Text('Closing')
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 270,
                      height: 267.0,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: const Color.fromARGB(255, 160, 158, 158),
                        width: 1,
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Reports:'),
                          const SizedBox(
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
                              const Text('Stock Report')
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
                              const Text('Invoice Report')
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
