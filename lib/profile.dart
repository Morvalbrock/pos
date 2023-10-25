import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController compnamecontroller = TextEditingController();
  TextEditingController websitecontroller = TextEditingController();
  TextEditingController gstcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController banknamecontroller = TextEditingController();
  TextEditingController branchnamecontroller = TextEditingController();
  TextEditingController accountnocontroller = TextEditingController();
  TextEditingController ifsccontroller = TextEditingController();

  late List<dynamic> userdata = [];
  List<Map<String, dynamic>> statedata = [];
  var name = '';
  var mobile = '';
  var email = '';
  var address = '';
  dynamic _statevalue = '';
  getOrder() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    try {
      List<dynamic> usrresults =
          await SelectionQry('SELECT * FROM `users` WHERE `id`="$id"');
      userdata.clear();
      List<dynamic> steresults =
          await SelectionQry('SELECT st_id,state FROM `tbl_state`');
      userdata.clear();
      statedata.clear();

      for (var row in usrresults) {
        setState(() {
          userdata.addAll([
            row['id'],
            row['company_id'],
            row['company_name'],
            row['owner_name'],
            row['mobile_no'],
            row['email'] ?? '',
            row['username'],
            row['gst_no'],
            row['address'],
            row['state'] ?? '',
            row['website'],
            row['type'],
            row['bank_name'],
            row['branch_name'],
            row['ac_no'],
            row['ifsc_code'],
            row['privileges']
          ]);
        });
      }
      statedata.add({
        'st_id': '',
        'state': 'Choose',
      });
      for (var res in steresults) {
        statedata.add({
          'st_id': res['st_id'],
          'state': res['state'],
        });
      }
      Timer(Duration(seconds: 2), () {
        setState(() {
          // userdata = userdata;
          _statevalue = userdata[9];
          statedata = statedata;
          name = userdata[3] ?? "";
          email = userdata[5] ?? '';
          mobile = userdata[4] ?? '';
          address = userdata[8].toString() ?? '';
        });
        EasyLoading.dismiss();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');
    getOrder();
    Timer(const Duration(seconds: 5), () {
      setState(() {
        usernamecontroller.text = userdata[6];
        emailcontroller.text = userdata[5] ?? '';
        fullnamecontroller.text = userdata[3] ?? '';
        mobilecontroller.text = userdata[4] ?? '';
        websitecontroller.text = userdata[10] ?? '';
      });
    });
  }

  var dropdown;
  final formKeys2 = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeeee),
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        elevation: 0,
      ),
      body: Form(
        key: formKeys2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0, top: 40.0),
              child: Material(
                elevation: 4.0,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                                'https://searchsoft.in/aura/public/images/user.png'),
                            radius: 50.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              '$name',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Divider(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          'Email address',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 2.0),
                        child: Text(
                          email,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 2.0),
                        child: Text(
                          mobile,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 2.0),
                        child: Text(
                          address,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Material(
                elevation: 4.0,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.46,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Material(
                          child: Container(
                            height: 60,
                            color: Colors.white,
                            child: TabBar(
                              tabs: [
                                Tab(
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Color.fromRGBO(236, 133, 36, 1),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('Account'),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Color.fromRGBO(236, 133, 36, 1),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('Personal'),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            236, 133, 36, 1),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('Company'),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            236, 133, 36, 1),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('Bank Details'),
                                    ),
                                  ),
                                ),
                              ],
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              unselectedLabelColor:
                                  const Color.fromRGBO(236, 133, 36, 1),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromRGBO(236, 133, 36, 1),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 45.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          child: Text(
                                            "Account Details",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('UserName'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: usernamecontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('Email'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: emailcontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('Password'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: passwordcontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    GFButton(
                                      color: Colors.green,
                                      elevation: 5.0,
                                      onPressed: () async {
                                        if (formKeys2.currentState!
                                            .validate()) {
                                          dynamic rs = await updatequery(
                                              "UPDATE `users` SET `email`='${emailcontroller.text}',`username`='${usernamecontroller.text}',`password`='${passwordcontroller.text}' WHERE `id`='${userdata[0]}'");

                                          if (rs == true) {
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setString(
                                                'email', emailcontroller.text);
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
                                                    Profilepage(),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Nothing has changed.')),
                                            );
                                          }
                                        }
                                      },
                                      text: "Update",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 45.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          child: Text(
                                            "Personal Details",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.08,
                                          ),
                                          Text('FullName'),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: fullnamecontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('Mobile No'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: mobilecontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    GFButton(
                                      color: Colors.green,
                                      elevation: 5.0,
                                      onPressed: () async {
                                        String query;
                                        if (passwordcontroller.text.isEmpty) {
                                          query =
                                              "UPDATE `users` SET `owner_name`='${fullnamecontroller.text}',`mobile_no`='${mobilecontroller.text}' WHERE `id`='${userdata[0]}'";
                                        } else {
                                          query =
                                              "UPDATE `users` SET `owner_name`='${fullnamecontroller.text}',`mobile_no`='${mobilecontroller.text}',`password`='${passwordcontroller.text}'  WHERE `id`='${userdata[0]}'";
                                        }
                                        dynamic rs = await updatequery(query);

                                        if (rs == true) {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.setString('owner_name',
                                              fullnamecontroller.text);
                                          await prefs.setString('mobile_no',
                                              mobilecontroller.text);
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
                                                  Profilepage(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Nothing has changed.')),
                                          );
                                        }
                                      },
                                      text: "Update",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 45.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          child: Text(
                                            "Company Details",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('CompanyName'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: compnamecontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('Website'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: websitecontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text('GST NO'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: gstcontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text('Address'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: addresscontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('State'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              margin: EdgeInsets.all(20),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: GFDropdown(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: const BorderSide(
                                                      color: Colors.black12,
                                                      width: 1),
                                                  dropdownButtonColor:
                                                      Colors.white,
                                                  value: _statevalue,
                                                  onChanged: (v) {
                                                    print(v);
                                                    setState(() {
                                                      _statevalue =
                                                          v.toString();
                                                      // staffid = _value;
                                                    });
                                                  },
                                                  items: statedata.map((e) {
                                                    return DropdownMenuItem(
                                                      child: Text(e["state"]),
                                                      value:
                                                          e['st_id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    GFButton(
                                      color: Colors.green,
                                      elevation: 5.0,
                                      onPressed: () async {
                                        if (formKeys2.currentState!
                                            .validate()) {
                                          dynamic rs = await updatequery(
                                              "UPDATE `users` SET `company_name`='${compnamecontroller.text}',`website`='${websitecontroller.text}' ,`gst_no`='${gstcontroller.text}' ,`address`='${addresscontroller.text}' WHERE `id`='${userdata[0]}'");

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
                                                    Profilepage(),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Nothing has changed.')),
                                            );
                                          }
                                        }
                                      },
                                      text: "Update",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 45.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          child: Text(
                                            "Bank Details",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('Bank Name'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: banknamecontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('Branch Name'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: branchnamecontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('Account No'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: accountnocontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text('IFSC Code'),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextField(
                                              controller: ifsccontroller,
                                              onTap: () {},
                                              decoration: InputDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    GFButton(
                                      color: Colors.green,
                                      elevation: 5.0,
                                      onPressed: () async {
                                        if (formKeys2.currentState!
                                            .validate()) {
                                          dynamic rs = await updatequery(
                                              "UPDATE `users` SET `bank_name`='${banknamecontroller.text}',`branch_name`='${branchnamecontroller.text}' ,`ac_no`='${accountnocontroller.text}' ,`ifsc_code`='${ifsccontroller.text}' WHERE `id`='${userdata[0]}'");

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
                                                    Profilepage(),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Nothing has changed.')),
                                            );
                                          }
                                        }
                                      },
                                      text: "Update",
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
