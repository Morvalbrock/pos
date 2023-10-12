import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/connection.dart';

final List<dynamic> product = [];

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  dynamic res = [];

  void initState() {
    setState(() {
      username.text = '9043889370';
      password.text = '123';
    });
  }

  Future<dynamic> getOrder(String username, String password) async {
    List<dynamic> rs = await SelectionQry(
        'SELECT * FROM  users WHERE mobile_no=$username AND password=$password');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    product.clear();
    for (var item in rs) {
      setState(() {
        product.addAll([
          item['id'],
          item['company_id'],
          item['company_name'],
          item['owner_name'],
          item['mobile_no'],
          item['email'],
          item['username'],
          item['password'],
          item['gst_no'],
          item['address'],
          item['state'],
          item['website'],
          item['type'],
          item['bank_name'],
          item['branch_name'],
          item['ac_no'],
          item['ifsc_code'],
          item['privileges'],
          item['remember_token'],
          item['last_login'],
          item['email_verified_at'],
          item['created_at'],
          item['updated_at']
        ]);
      });
    }
    print(product);
    if (product.isNotEmpty) {
      await prefs.setInt('id', product[0]);
      await prefs.setString('comp_id', product[1]);
      await prefs.setString('owner_name', product[3]);
      await prefs.setString('mobile_no', product[4]);
      await prefs.setString('email', product[5] ?? '');
      await prefs.setString('username', product[6]);
      await prefs.setString('website', product[11] ?? '');
      await prefs.setString('userType', product[12]);
      await prefs.setString('state', product[10]);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: Color.fromRGBO(236, 133, 36, 1),
            padding: EdgeInsets.only(bottom: 70.0, right: 20),
            // padding: EdgeInsets.only(right: 30.0),
            child: Image.network(
              'https://evolve.ie/wp-content/uploads/2015/09/big-data-analytics-portrait.jpg',
              height: double.infinity,
              width: 800,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                  ),
                  child: Center(
                    child: Text(
                      "Login to your Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(21, 83, 120, 1),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 40.0,
                    padding: EdgeInsets.only(left: 30),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 234, 234))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 243, 234, 234)),
                        ),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 40.0,
                    padding: EdgeInsets.only(left: 30.0),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 234, 234))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 243, 234, 234)),
                        ),
                        labelText: 'password',
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 440.0,
                child: ElevatedButton(
                  onPressed: () {
                    EasyLoading.show(status: 'loading...');
                    res = getOrder(username.text, password.text);

                    if (res == false) {
                      Navigator.pushNamed(
                        context,
                        '/',
                      );
                      // Timer(Duration(seconds: 5), () {
                      //   EasyLoading.dismiss();
                      // });
                    } else {
                      EasyLoading.dismiss();
                      Navigator.pushNamed(
                        context,
                        'home',
                      );
                    }
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120, 50),
                    backgroundColor: Color.fromRGBO(236, 133, 36, 1),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                      height: 300,
                      alignment: Alignment.bottomCenter,
                      child: Text(
                          '© 2023 Searchsoft Technologies by searchsoft.in')),
                ],
              ),
            ],
          ),
          SizedBox(width: 70.0),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
