import 'package:flutter/material.dart';
import 'package:pos/custom.dart';

List<TextEditingController> myController =
    List.generate(10, (i) => TextEditingController());
List<TextEditingController> myController1 =
    List.generate(10, (i) => TextEditingController());
List<TextEditingController> myController2 =
    List.generate(11, (i) => TextEditingController());

class closingPage extends StatelessWidget {
  const closingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeeee),
      appBar: AppBar(
        title: Text(
          'Closing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        elevation: 0,
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 550.0,
                  height: 600.0,
                  child: Card(
                    color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'CLOSING ACCOUNT',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
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
                                left: 15.0,
                              ),
                              child: Text(
                                'Last Day Closing',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                            ClosingTextfield(
                                'Last Day Closing',
                                200,
                                myController,
                                myController1,
                                myController2,
                                'Last_Day_Closing'),
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
                                left: 15.0,
                              ),
                              child: Text(
                                'Receipt',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                            ClosingTextfield('Receipt', 200, myController,
                                myController1, myController2, '0'),
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
                                left: 15.0,
                              ),
                              child: Text(
                                'Payment',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                            ClosingTextfield('Payment', 200, myController,
                                myController1, myController2, '0'),
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
                                left: 15.0,
                              ),
                              child: Text(
                                'Balance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                            ClosingTextfield('Balance', 200, myController,
                                myController1, myController2, '0'),
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
                                left: 15.0,
                              ),
                              child: Text(
                                'Adjustment',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                            ClosingTextfield('Adjustment', 200, myController,
                                myController1, myController2, 'Adjustment'),
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
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                  ),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                ),
                                ClosingTextfield('Total', 200, myController,
                                    myController1, myController2, 'Total'),
                              ],
                            ),
                            Container(
                              width: 120,
                              height: 60,
                              padding: EdgeInsets.only(top: 20.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('DAY CLOSING'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 85.0, left: 10.0),
            child: Column(
              children: [
                Container(
                  width: 800,
                  height: 650,
                  child: Card(
                    color: Colors.orange[400],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'CASH IN HAND',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text('Note'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('2000'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('500'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('200'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('100'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('50'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('20'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('10'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('5'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('2'),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text('1'),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, top: 30.0),
                                child: Column(
                                  children: [
                                    Text('Pcs'),
                                    ClosingTextfield('2000', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('500', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('200', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('100', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('50', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('20', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('10', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('5', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('2', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('1', 220, myController,
                                        myController1, myController2, '0'),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 30.0),
                                child: Column(
                                  children: [
                                    Text('Amount'),
                                    ClosingTextfield('amt1', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt2', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt3', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt4', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt5', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt6', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt7', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt8', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt9', 220, myController,
                                        myController1, myController2, '0'),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ClosingTextfield('amt10', 220, myController,
                                        myController1, myController2, '0'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text('Grand Total'),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 134.0, top: 10.0),
                              child: ClosingTextfield(
                                  'Total_All',
                                  220,
                                  myController,
                                  myController1,
                                  myController2,
                                  '0'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
