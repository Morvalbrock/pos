// import 'dart:math';

import 'package:dropdown_text_search/src/flutter_dropdown_text_search.dart';
import 'package:dropdown_text_search/dropdown_text_search.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/getwidget.dart';
import 'package:keyboard_event/keyboard_event.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:pos/productpop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'stockpop.dart';
import 'custom.dart';
import 'helper/connection.dart';
import 'package:pos/productpop.dart';

// import 'package:windows_project/loginscreen.dart';
TextEditingController _controller = TextEditingController();

TextEditingController _controlleraddname = TextEditingController();
TextEditingController _controlleraddaddress = TextEditingController();
TextEditingController _controlleraddmobile = TextEditingController();
TextEditingController _controlleraddemail = TextEditingController();
TextEditingController _controlleradddob = TextEditingController();
TextEditingController _controlleradddetails = TextEditingController();
TextEditingController _controllerdate = TextEditingController();

final DataGridController _dataGridController = DataGridController();
List<BarButton> _menuBarButtons() {
  return [
    BarButton(
      text: const Text(
        'File',
        style: TextStyle(color: Colors.black),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () => print('Save'),
            text: const Text('Save'),
            shortcutText: 'Ctrl+S',
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyS, control: true),
          ),
          MenuButton(
            onTap: () {},
            text: const Text('Save as'),
            shortcutText: 'Ctrl+Shift+S',
          ),
          const MenuDivider(),
          MenuButton(
            onTap: () {},
            text: const Text('Open File'),
          ),
          MenuButton(
            onTap: () {},
            text: const Text('Open Folder'),
          ),
          const MenuDivider(),
          MenuButton(
            text: const Text('Preferences'),
            icon: const Icon(Icons.settings),
            submenu: SubMenu(
              menuItems: [
                MenuButton(
                  onTap: () {},
                  icon: const Icon(Icons.keyboard),
                  text: const Text('Shortcuts'),
                ),
                const MenuDivider(),
                MenuButton(
                  onTap: () {},
                  icon: const Icon(Icons.extension),
                  text: const Text('Extensions'),
                ),
                const MenuDivider(),
                MenuButton(
                  icon: const Icon(Icons.looks),
                  text: const Text('Change theme'),
                  submenu: SubMenu(
                    menuItems: [
                      MenuButton(
                        onTap: () {},
                        icon: const Icon(Icons.light_mode),
                        text: const Text('Light theme'),
                      ),
                      const MenuDivider(),
                      MenuButton(
                        onTap: () {},
                        icon: const Icon(Icons.dark_mode),
                        text: const Text('Dark theme'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MenuDivider(),
          MenuButton(
            onTap: () {},
            shortcutText: 'Ctrl+Q',
            text: const Text('Exit'),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
    ),
    BarButton(
      text: const Text(
        'Edit',
        style: TextStyle(color: Colors.black),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () {},
            text: const Text('Undo'),
            shortcutText: 'Ctrl+Z',
          ),
          MenuButton(
            onTap: () {},
            text: const Text('Redo'),
            shortcutText: 'Ctrl+Y',
          ),
          const MenuDivider(),
          MenuButton(
            onTap: () {},
            text: const Text('Cut'),
            shortcutText: 'Ctrl+X',
          ),
          MenuButton(
            onTap: () {},
            text: const Text('Copy'),
            shortcutText: 'Ctrl+C',
          ),
          MenuButton(
            onTap: () {},
            text: const Text('Paste'),
            shortcutText: 'Ctrl+V',
          ),
          const MenuDivider(),
          MenuButton(
            onTap: () {},
            text: const Text('Find'),
            shortcutText: 'Ctrl+F',
          ),
        ],
      ),
    ),
    BarButton(
      text: const Text(
        'Help',
        style: TextStyle(color: Colors.black),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () {},
            text: const Text('Check for updates'),
          ),
          const MenuDivider(),
          MenuButton(
            onTap: () {},
            text: const Text('View License'),
          ),
          const MenuDivider(),
          MenuButton(
            onTap: () {},
            icon: const Icon(Icons.info),
            text: const Text('About'),
          ),
        ],
      ),
    ),
  ];
}

class salespage extends StatefulWidget {
  const salespage({Key? key}) : super(key: key);

  @override
  State<salespage> createState() => _MyAppState();
}

class _MyAppState extends State<salespage> {
  Map<String, dynamic> rowData = {
    'id': 1,
    'name': 'John',
    'age': 30,
  };

  List<String> sizedata = [];
  List<String> unitdata = [];
  late String _szvalue;
  late String _uvalue;
  String cus_name = '';
  String cus_mobile = '';
  getOrder() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    try {
      List<dynamic> cusresults = await SelectionQry(
          'SELECT id,cus_id,cus_name,cus_mobile FROM `tbl_customer` WHERE `comp_id`="$comp_id"');
      sizedata.clear();
      List<dynamic> proresults = await SelectionQry(
          'SELECT id,p_id,p_name FROM `tbl_product` WHERE `comp_id`="$comp_id"');
      sizedata.clear();
      unitdata.clear();
      for (var row in cusresults) {
        sizedata.add(row['cus_id'] +
            ' - ' +
            row['cus_name'] +
            ' - ' +
            row['cus_mobile']);
      }
      for (var res in proresults) {
        unitdata.add(res['p_id'] + ' - ' + res['p_name']);
      }
      Timer(const Duration(milliseconds: 30), () {
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

// employees = getEmployees();
  late ProductDataSource productDataSource;
  String? _selectedVal = "Enter a search term";
  String? _selectedVal1 = "Enter Barcode / Product Code / Product Name";
  final List<String> _err = [];
  final List<String> _event = [];
  late KeyboardEvent keyboardEvent;
  int eventNum = 0;
  bool listenIsOn = true;
  late FocusNode myList1;
  late FocusNode myList2;
  late FocusNode myList3;
  late FocusNode myList4;
  late FocusNode myList5;
  late FocusNode myList6;
  late FocusNode myList7;
  late FocusNode myList8;
  late FocusNode myList9;
  late FocusNode myList10;
  late FocusNode myList11;
  late FocusNode myList12;

  // final _formKey = GlobalKey<FormState>();

  final List<DataGridRow> dataRows = [
    // DataRow(cells: [
    //   DataCell(Text('')),
    //   DataCell(Text('25')),
    //   DataCell(TextField(
    //     decoration: InputDecoration(
    //       focusedBorder: OutlineInputBorder(
    //           borderSide:
    //               BorderSide(color: Color.fromARGB(255, 243, 234, 234))),
    //       enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
    //       ),
    //     ),
    //   )),
    //   DataCell(Text('25')),
    //   DataCell(TextField(
    //     decoration: InputDecoration(
    //       focusedBorder: OutlineInputBorder(
    //           borderSide:
    //               BorderSide(color: Color.fromARGB(255, 243, 234, 234))),
    //       enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
    //       ),
    //     ),
    //   )),
    //   DataCell(TextField(
    //     decoration: InputDecoration(
    //       focusedBorder: OutlineInputBorder(
    //           borderSide:
    //               BorderSide(color: Color.fromARGB(255, 243, 234, 234))),
    //       enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
    //       ),
    //     ),
    //   )),
    //   DataCell(Text('25')),
    // ]),
  ];
  TextEditingController _cusserarchcontroller = TextEditingController();
  TextEditingController _productsearchcontroller = TextEditingController();
  List<ProductInfo> product = [];
  // List<ProductInfo> newproduct = [];
  // List<ProductInfo> getnewProduct() {
  //   final productList = List.of(product);

  //   product.add(productList as ProductInfo);
  //   return productList;
  // }

  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    getOrder();

    productDataSource = ProductDataSource(product);
    // _controlleradddob.text = _dateTime.toString();
    super.initState();
    setState(() {
      _cusserarchcontroller.text = '';
      _productsearchcontroller.text = '';
    });
    initPlatformState();
    keyboardEvent = KeyboardEvent();
    myList1 = FocusNode();
    myList2 = FocusNode();
    myList3 = FocusNode();
    myList4 = FocusNode();
    myList5 = FocusNode();
    myList6 = FocusNode();
    myList7 = FocusNode();
    myList8 = FocusNode();
    myList9 = FocusNode();
    myList10 = FocusNode();
    myList11 = FocusNode();
    myList12 = FocusNode();
  }

  Future<void> initPlatformState() async {
    List<String> err = [];

    try {} on PlatformException {
      err.add('Failed to get platform version.');
    }
    try {
      await KeyboardEvent.init();
    } on PlatformException {
      err.add('Failed to get virtual-key map.');
    }

    if (!mounted) return;

    setState(() {
      if (err.isNotEmpty) _err.addAll(err);

      keyboardEvent.startListening((keyEvent) {
        setState(() {
          eventNum++;
          if (keyEvent.vkName == 'F1') {
            myList1.requestFocus();
          } else if (keyEvent.vkName == 'F2') {
            myList2.requestFocus();
          } else if (keyEvent.vkName == 'F3') {
            myList3.requestFocus();
          } else if (keyEvent.vkName == 'F4') {
            myList4.requestFocus();
          } else if (keyEvent.vkName == 'F5') {
            myList5.requestFocus();
          } else if (keyEvent.vkName == 'F6') {
            myList6.requestFocus();
          } else if (keyEvent.vkName == 'F7') {
            myList7.requestFocus();
          } else if (keyEvent.vkName == 'F8') {
            myList8.requestFocus();
          } else if (keyEvent.vkName == 'F9') {
            myList9.requestFocus();
          } else if (keyEvent.vkName == 'F10') {
            myList10.requestFocus();
          } else if (keyEvent.vkName == 'F11') {
            myList11.requestFocus();
          } else if (keyEvent.vkName == 'F12') {
            myList12.requestFocus();
          } else {
            _event.add(keyEvent.toString());
          }
          if (_event.length > 20) {}
          debugPrint(keyEvent.toString());
        });
      });
    });
  }

  final formKey55 = GlobalKey<FormState>();
  // DateTime _dateTime = DateTime.now();
  Future<void> _showDatePicker() async {
    _controlleradddob.text = DateTime.now().toString();
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
    );
    if (_picked != null) {
      setState(() {
        _controlleradddob.text = _picked.toString().split(" ")[0];
        _controllerdate.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey55,
      child: Scaffold(
        backgroundColor: const Color(0xfffeeeee),
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 60,
          leading: TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
            icon: const Icon(
              Icons.home,
              size: 24.0,
              color: Colors.black,
            ),
            label: const Text(
              'Home',
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 50.0,
              ),
              Row(
                children: [
                  Container(
                    width: 60.0,
                    height: 50.0,
                    color: Colors.green,
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'ADD Customer',
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close)),
                                ],
                              ),
                              content: Container(
                                width: 500,
                                height: 400,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Name:'),
                                        const Spacer(),
                                        Container(
                                            width: 300,
                                            child: TextField(
                                              controller: _controlleraddname,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      243,
                                                                      234,
                                                                      234))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            243,
                                                            234,
                                                            234)),
                                                  ),
                                                  prefixIcon: Icon(Icons
                                                      .person_pin_outlined),
                                                  hintText: 'Enter Name',
                                                  hintStyle:
                                                      TextStyle(fontSize: 15)),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text('Address:'),
                                        ),
                                        const Spacer(),
                                        Container(
                                            width: 300,
                                            child: TextField(
                                              controller: _controlleraddaddress,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      243,
                                                                      234,
                                                                      234))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            243,
                                                            234,
                                                            234)),
                                                  ),
                                                  hintText: 'Enter Address',
                                                  prefixIcon: Icon(Icons
                                                      .add_location_rounded),
                                                  hintStyle:
                                                      TextStyle(fontSize: 15)),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text('Mobiles:'),
                                        ),
                                        const Spacer(),
                                        Container(
                                            width: 300,
                                            child: TextField(
                                              controller: _controlleraddmobile,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      243,
                                                                      234,
                                                                      234))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            243,
                                                            234,
                                                            234)),
                                                  ),
                                                  hintText: 'Enter Mobile',
                                                  prefixIcon: Icon(Icons
                                                      .phone_android_outlined),
                                                  hintStyle:
                                                      TextStyle(fontSize: 15)),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text('Email:'),
                                        ),
                                        const Spacer(),
                                        Container(
                                            width: 300,
                                            child: TextField(
                                              controller: _controlleraddemail,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      243,
                                                                      234,
                                                                      234))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            243,
                                                            234,
                                                            234)),
                                                  ),
                                                  hintText: 'Enter Email',
                                                  prefixIcon: Icon(
                                                      Icons.email_outlined),
                                                  hintStyle:
                                                      TextStyle(fontSize: 15)),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text('DOB:'),
                                        ),
                                        const Spacer(),
                                        Container(
                                            width: 300,
                                            child: TextField(
                                              controller: _controlleradddob,
                                              onTap: () {
                                                _showDatePicker();
                                              },
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      243,
                                                                      234,
                                                                      234))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            243,
                                                            234,
                                                            234)),
                                                  ),
                                                  hintText: 'Enter DOB',
                                                  prefixIcon: Icon(
                                                      Icons.date_range_sharp),
                                                  hintStyle:
                                                      TextStyle(fontSize: 15)),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text('Details:'),
                                        ),
                                        const Spacer(),
                                        Container(
                                            width: 300,
                                            child: TextField(
                                              controller: _controlleradddetails,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      243,
                                                                      234,
                                                                      234))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            243,
                                                            234,
                                                            234)),
                                                  ),
                                                  hintText: 'Enter Details',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  prefixIcon: Icon(Icons.chat),
                                                  hintStyle:
                                                      TextStyle(fontSize: 15)),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, top: 20),
                                          child: Container(
                                            height: 50.0,
                                            width: 100.0,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (formKey55.currentState!
                                                    .validate()) {
                                                  List maxid = [];
                                                  var max_id = '';
                                                  final SharedPreferences
                                                      prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  var comp_id = prefs
                                                      .getString('comp_id');
                                                  List<dynamic> data =
                                                      await SelectionQry(
                                                          'SELECT max(id) as maxid FROM `tbl_customer` where comp_id="${comp_id}"');

                                                  maxid.clear();

                                                  for (var row in data) {
                                                    setState(() {
                                                      print(row['maxid']);
                                                      max_id =
                                                          (row['maxid'] + 1)
                                                              .toString();
                                                    });
                                                  }

                                                  var cus_id = "CUS" +
                                                      max_id.padLeft(5, '0');

                                                  dynamic rs = await insertquery(
                                                      "INSERT INTO `tbl_customer`(  `comp_id`, `cus_id`,`cus_name`, `cus_address`, `cus_mobile`, `cus_email`, `cus_dob`, `cus_details`) VALUES ('${comp_id.toString()}','${cus_id.toString()}','${_controlleraddname.text}','${_controlleraddaddress.text}','${_controlleraddmobile.text}','${_controlleraddemail.text}','${_controlleradddob.text}','${_controlleradddetails.text}')");

                                                  if (rs == true) {
                                                    // ignore: use_build_context_synchronously
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Updated Successfully..')),
                                                    );
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const salespage(),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Nothing has changed.')),
                                                    );
                                                  }
                                                }
                                              },
                                              child: const Text('SUBMIT'),
                                              style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      255, 94, 214, 98)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, top: 20),
                                          child: Container(
                                            height: 50.0,
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'ADD',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                                width: 280,
                                child: DropdownTextSearch(
                                  noItemFoundText: "Invalid Search",
                                  controller: _cusserarchcontroller,
                                  overlayHeight: 300,
                                  items: sizedata,
                                  filterFnc: (String a, String b) {
                                    return a
                                        .toLowerCase()
                                        .contains(b.toLowerCase());
                                  },
                                  decorator: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    hintText: "Customer Search Here",
                                    hintStyle: TextStyle(fontSize: 18.0),
                                  ),
                                  onChange: (val) {
                                    print(val);
                                    _controller.text = val;
                                    dynamic arr = val.split(' - ');
                                    setState(() {
                                      cus_name = "Name : " + arr[1];
                                      cus_mobile = "Mobile : " + arr[2];
                                    });
                                  },
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          leadingWidth: 150,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Text(
                    cus_name,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Text(
                    cus_mobile,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                Container(
                  color: Colors.green,
                  height: 40.0,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month_rounded),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
                width: 250.0,
                padding: const EdgeInsets.only(right: 50, top: 10, bottom: 10),
                child: TextField(
                  focusNode: myList2,
                  controller: _controllerdate,
                  onTap: () {
                    _showDatePicker();
                  },
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 243, 234, 234))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 243, 234, 234)),
                      ),
                      hintText: 'DD-MM-YYYY',
                      hintStyle: TextStyle(fontSize: 15)),
                )),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.login_outlined),
                  color: Colors.black,
                ),
                const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.66,
                    height: MediaQuery.of(context).size.height * 0.80,
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: TextField(
                                      focusNode: myList3,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 243, 234, 234))),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 243, 234, 234)),
                                        ),
                                        prefixIcon: Icon(Icons.search),
                                        hintText: 'Enter your name',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.50,
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownTextSearch(
                                                noItemFoundText:
                                                    "Invalid Search",
                                                controller:
                                                    _productsearchcontroller,
                                                overlayHeight: 300,
                                                items: unitdata,
                                                filterFnc:
                                                    (String a, String b) {
                                                  return a
                                                      .toLowerCase()
                                                      .contains(
                                                          b.toLowerCase());
                                                  // .startsWith(
                                                  //     );
                                                },
                                                decorator:
                                                    const InputDecoration(
                                                  hintText:
                                                      "Product Search Here",
                                                ),
                                                onChange: (val) async {
                                                  print(val);
                                                  _controller.text = val;

                                                  dynamic p_id =
                                                      val!.split(' - ');
                                                  p_id = p_id[0];
                                                  final SharedPreferences
                                                      prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  var comp_id = prefs
                                                      .getString('comp_id');
                                                  final List<StockInfo> stock =
                                                      [];
                                                  late StockDataSource
                                                      stockDataSource;
                                                  List<dynamic> rs =
                                                      await SelectionQry(
                                                          'SELECT *,(SELECT p_name FROM `tbl_product` WHERE comp_id=tbl_stock.comp_id AND p_id=tbl_stock.p_id) AS p_name,(SELECT sup_name FROM `tbl_supplier` WHERE comp_id=tbl_stock.comp_id AND sup_id=tbl_stock.sup_id) AS sup_name,(SELECT (SELECT u_name FROM `tbl_unit` WHERE tbl_unit.comp_id=tbl_product.comp_id AND tbl_unit.u_id=tbl_product.u_id) AS u_name FROM `tbl_product` WHERE comp_id=tbl_stock.comp_id AND p_id=tbl_stock.p_id) AS u_name FROM `tbl_stock` WHERE `comp_id`="$comp_id" AND `p_id`="$p_id" ');
                                                  stock.clear();
                                                  for (var item in rs) {
                                                    // print(item['orderID']);
                                                    StockInfo lst = StockInfo(
                                                      item['id'],
                                                      item['comp_id'],
                                                      item['stk_id'],
                                                      item['pur_id'],
                                                      item['sup_id'],
                                                      item['p_name'],
                                                      item['p_id'],
                                                      item['hsn'],
                                                      item['inward'],
                                                      item['outward'],
                                                      item['balance'],
                                                      item['u_name'],
                                                      item['price'],
                                                      item['sup_name'],
                                                      item['inv_no'],
                                                      item['inv_date'],
                                                    );
                                                    stock.add(lst);
                                                  }
                                                  stockDataSource =
                                                      StockDataSource(stock);

                                                  // ignore: use_build_context_synchronously
                                                  showDialog(
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.60,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment
                                                            //         .spaceAround,
                                                            children: [
                                                              const Row(
                                                                children: [
                                                                  Text(
                                                                    'Add Products/Goods',
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        content: Container(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.68,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.20,
                                                          child: SfDataGrid(
                                                            source:
                                                                stockDataSource,
                                                            columnWidthMode:
                                                                ColumnWidthMode
                                                                    .fill,
                                                            highlightRowOnHover:
                                                                true,
                                                            rowHeight: 50.0,
                                                            onCellTap:
                                                                (details) {
                                                              int selectedRowIndex =
                                                                  details.rowColumnIndex
                                                                          .rowIndex -
                                                                      1;
                                                              var row = stockDataSource
                                                                  .effectiveRows
                                                                  .elementAt(
                                                                      selectedRowIndex);
                                                              // List<ProductInfo>

                                                              //     product = [];
                                                              dynamic inc =
                                                                  (product.length) +
                                                                      1;
                                                              dynamic disc =
                                                                  (product.length) +
                                                                      1;
                                                              dynamic disc_per =
                                                                  (product.length) +
                                                                      1;
                                                              dynamic amount =
                                                                  (product.length) +
                                                                      1;
                                                              dynamic total =
                                                                  (product.length) +
                                                                      1;
                                                              ProductInfo list =
                                                                  ProductInfo(
                                                                row
                                                                    .getCells()[
                                                                        0]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        1]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        2]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        3]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        4]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        5]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        6]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        7]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        8]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        9]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        10]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        11]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        12]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        13]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        14]
                                                                    .value,
                                                                row
                                                                    .getCells()[
                                                                        15]
                                                                    .value,
                                                                inc.toString(),
                                                                disc.toString(),
                                                                disc_per
                                                                    .toString(),
                                                                amount
                                                                    .toString(),
                                                                total
                                                                    .toString(),
                                                                // row
                                                                //     .getCells()[
                                                                //          16]
                                                                //     .value,
                                                                // row
                                                                //     .getCells()[
                                                                //         17]
                                                                //     .value,
                                                                // row
                                                                //     .getCells()[
                                                                //         18]
                                                                //     .value,
                                                                // row
                                                                //     .getCells()[
                                                                //         19]
                                                                //     .value,
                                                              );
                                                              setState(() {
                                                                print(list);
                                                                product
                                                                    .add(list);

                                                                // getnewProduct();
                                                                productDataSource =
                                                                    ProductDataSource(
                                                                        product);
                                                                Navigator.pop(
                                                                    context);
                                                              });

                                                              List<TextEditingController>
                                                                  _controllertextfield =
                                                                  List.generate(
                                                                      6,
                                                                      (i) =>
                                                                          TextEditingController());

                                                              // print(row
                                                              //     .getCells()[5]
                                                              //     .value);
                                                              _controllertextfield[
                                                                          0]
                                                                      .text =
                                                                  row
                                                                      .getCells()[
                                                                          12]
                                                                      .value
                                                                      .toString();
                                                              _controllertextfield[
                                                                          2]
                                                                      .text =
                                                                  row
                                                                      .getCells()[
                                                                          12]
                                                                      .value
                                                                      .toString();
                                                              _controllertextfield[
                                                                          5]
                                                                      .text =
                                                                  row
                                                                      .getCells()[
                                                                          12]
                                                                      .value
                                                                      .toString();
                                                            },
                                                            columns: <GridColumn>[
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'id',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'comp_id',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'stk_id',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'pur_id',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'sup_id',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'p_name',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: const Text(
                                                                      'Products/Goods'),
                                                                ),
                                                              ),
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'p_id',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'hsn',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      const Text(
                                                                          'HSN'),
                                                                ),
                                                              ),
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'inward',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                visible: false,
                                                                columnName:
                                                                    'outward',
                                                                label:
                                                                    const Text(
                                                                        ''),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'balance',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: const Text(
                                                                      'Available QTY'),
                                                                ),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'u_name',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      const Text(
                                                                          'Unit'),
                                                                ),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'price',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: const Text(
                                                                      'Price'),
                                                                ),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'sup_name',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: const Text(
                                                                      'Supplier'),
                                                                ),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'inv_no',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: const Text(
                                                                      'Invoice No'),
                                                                ),
                                                              ),
                                                              GridColumn(
                                                                columnName:
                                                                    'inv_date',
                                                                label:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: const Text(
                                                                      'Invoice Date'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    context: context,
                                                  );
                                                }),
                                          )),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SfDataGrid(
                                source: productDataSource,
                                controller: _dataGridController,
                                columns: <GridColumn>[
                                  GridColumn(
                                    visible: false,
                                    columnName: 'id',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    visible: false,
                                    columnName: 'comp_id',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    visible: false,
                                    columnName: 'stk_id',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    visible: false,
                                    columnName: 'pur_id',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    visible: false,
                                    columnName: 'sup_id',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    columnName: 'p_name',
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Items'),
                                    ),
                                  ),
                                  GridColumn(
                                    visible: false,
                                    columnName: 'p_id',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    columnName: 'hsn',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('HSN'),
                                    ),
                                  ),
                                  GridColumn(
                                    visible: false,
                                    columnName: 'inward',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    visible: false,
                                    columnName: 'outward',
                                    label: const Text(''),
                                  ),
                                  GridColumn(
                                    columnName: 'balance',
                                    visible: true,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Available QTY'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'u_name',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Unit'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'price',
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.center,
                                      child: const Text('Rate'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'sup_name',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Supplier'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'inv_no',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Invoice No'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'inv_date',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Invoice Date'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'qty',
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Qty'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'txtqty',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('TextQty'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'amount',
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Amount'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'txtamount',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('TextQty'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'disc',
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Disc(%)'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'txtdisc',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Disc(%)'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'disc_amount',
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Disc_Amt'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'txtdisc_per',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Disc_Amt'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'total',
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Total'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'txt_total',
                                    visible: false,
                                    label: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text('TextQty'),
                                    ),
                                  ),
                                  // productDataSource.addRow(rowData),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        width: MediaQuery.of(context).size.width * 0.34,
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Discount(%)Amt",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: myList5,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 243, 234, 234))),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 243, 234, 234)),
                                          ),
                                          hintText: '0',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: myList6,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 243, 234, 234))),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 243, 234, 234)),
                                          ),
                                          hintText: '0',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.133,
                                            height: 70,
                                            color: const Color.fromRGBO(
                                                255, 187, 51, 1),
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Total Qty",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.133,
                                              height: 70,
                                              color: const Color.fromRGBO(
                                                  255, 187, 51, 1),
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "Total Payable",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.128,
                                            height: 35,
                                            child: Flexible(
                                              flex: 1,
                                              child: TextField(
                                                focusNode: myList7,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      243,
                                                                      234,
                                                                      234))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            243,
                                                            234,
                                                            234)),
                                                  ),
                                                  hintText: '',
                                                  focusColor: Colors.black,
                                                  labelText: 'Card',
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.128,
                                            height: 35,
                                            child: Flexible(
                                              flex: 1,
                                              child: TextField(
                                                focusNode: myList8,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText: '0',
                                                        labelText: 'Cheque'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.128,
                                            height: 35,
                                            child: Flexible(
                                              flex: 2,
                                              child: TextField(
                                                focusNode: myList9,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText: '0',
                                                        labelText: 'Wallet'),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.128,
                                            height: 35,
                                            child: Flexible(
                                              flex: 1,
                                              child: TextField(
                                                focusNode: myList10,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText: '0',
                                                        labelText:
                                                            'Credit Note'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.128,
                                        height: 35,
                                        child: Flexible(
                                          flex: 2,
                                          child: TextField(
                                            focusNode: myList11,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    243,
                                                                    234,
                                                                    234))),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 243, 234, 234)),
                                                ),
                                                hintText: '0',
                                                labelText: 'Unpaid Amt'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.128,
                                        height: 35,
                                        child: Flexible(
                                          flex: 1,
                                          child: TextField(
                                            focusNode: myList12,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    243,
                                                                    234,
                                                                    234))),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 243, 234, 234)),
                                                ),
                                                hintText: '0',
                                                labelText: 'Cash'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Cash Given',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.132,
                                                height: 40,
                                                child: const TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        90,
                                                                        132))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              224,
                                                              79,
                                                              127)),
                                                    ),
                                                    hintText: '0',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.132,
                                            height: 30,
                                            color: const Color.fromARGB(
                                                255, 236, 63, 77),
                                            child: const Center(
                                              child: Text(
                                                'Given Change',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 2),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.132,
                                                height: 50,
                                                color: const Color.fromARGB(
                                                    255, 236, 63, 77),
                                                child: const Center(
                                                    child: TextField()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.132,
                                        child: GFButton(
                                          color: Colors.green,
                                          onPressed: () {
                                            dynamic value = getAllRowData();
                                            print(value);
                                            print("value");
                                          },
                                          text: "Save & Print",
                                          fullWidthButton: true,
                                          size: GFSize.LARGE,
                                          elevation: 7.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.132,
                                        child: GFButton(
                                          color: Colors.lightBlue,
                                          onPressed: () {},
                                          text: "Save & New",
                                          fullWidthButton: true,
                                          size: GFSize.LARGE,
                                          elevation: 7.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      const Text('© 2023 Searchsoft Technologies by '),
                      InkWell(
                        onLongPress: () => launch("https://www.google.com"),
                        child: const Text("searchsoft.in"),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  launch(String s) {}
}

List<ProductInfo> getAllRowData() {
  final selectedRows = _dataGridController.selectedRows;
  final List<ProductInfo> allData = selectedRows.map((gridRow) {
    final ProductInfo data = gridRow as ProductInfo;
    return data;
  }).toList();

  return allData;
}
