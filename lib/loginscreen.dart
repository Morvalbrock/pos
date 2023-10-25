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

  @override
  void initState() {
    super.initState();
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: const Color.fromRGBO(236, 133, 36, 1),
            padding: const EdgeInsets.only(bottom: 70.0, right: 20),
            // padding: EdgeInsets.only(right: 30.0),
            child: Image.asset(
              'assets/images/loginpage.jpg',
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 0.50,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: const Center(
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
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                  ),
                  const Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 40.0,
                    child: TextField(
                      controller: username,
                      decoration: const InputDecoration(
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
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 40.0,
                    child: TextField(
                      controller: password,
                      decoration: const InputDecoration(
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
              const SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.15,
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 50),
                    backgroundColor: const Color.fromRGBO(236, 133, 36, 1),
                  ),
                  child: const Text('Login'),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.10),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                          '© 2023 Searchsoft Technologies by searchsoft.in')),
                ],
              ),
            ],
          ),
          const SizedBox(width: 70.0),
        ],
      ),
    );
  }
}
