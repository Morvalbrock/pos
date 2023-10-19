import 'package:flutter/material.dart';
import 'package:dropdown_text_search/dropdown_text_search.dart';

import 'package:pdf/widgets.dart' as pw;

class Textfld1 extends StatelessWidget {
  const Textfld1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: TextField(
          decoration: InputDecoration(
            hintText: "₹",
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: double.infinity,
                    color: Color.fromARGB(255, 243, 234, 234))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: double.infinity,
                  color: Color.fromARGB(255, 243, 234, 234)),
            ),
          ),
        ));
  }
}

Widget Textfld(
  String fld,
  double width,
  _controller,
  dynamic htxt,
) {
  if (htxt == null) {
    htxt = '';
  }

  var amt;
  var sellprice;
  dynamic controller;
  if (fld == 'hsn') {
    controller = _controller[1];
  } else if (fld == 'qty') {
    controller = _controller[2];
  } else if (fld == 'rate') {
    controller = _controller[3];
  } else if (fld == 'sellper') {
    controller = _controller[4];
  } else if (fld == 'sellprice') {
    controller = _controller[5];
  } else if (fld == 'offerper') {
    controller = _controller[7];
  } else if (fld == 'offeramt') {
    controller = _controller[8];
  } else if (fld == 'offersellprice') {
    controller = _controller[9];
  } else if (fld == 'amount') {
    controller = _controller[10];
  } else if (fld == 'gst') {
    controller = _controller[11];
  } else if (fld == 'price') {
    controller = _controller[12];
  }

  return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: htxt,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: double.infinity,
                  color: Color.fromARGB(255, 243, 234, 234))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: double.infinity,
                color: Color.fromARGB(255, 243, 234, 234)),
          ),
        ),
        onChanged: (value) {
          // setState(() {
          var rate = _controller[3].text;
          var qty = _controller[2].text;
          var sellper = _controller[4].text;
          var offerprice = _controller[8].text;
          var sellprice = _controller[5].text;
          var offersellprice = _controller[9].text;
          var offerper = _controller[7].text;
          var gstAmount = _controller[11].text;
          var price = _controller[12].text;
          var amount = _controller[10].text;

          if (sellper == null || sellper == '') {
            sellper = '0';
          }

          if (qty == null || qty == '') {
            qty = '0';
          }

          if (rate == null || rate == '') {
            rate = '0';
          }

          if (offerprice == null || offerprice == '') {
            offerprice = '0';
          }
          if (sellprice == null || sellprice == '') {
            sellprice = '0';
          }
          if (offersellprice == null || offersellprice == '') {
            offersellprice = '0';
          }
          if (offerper == null || offerper == '') {
            offerper = '0';
          }
          if (gstAmount == null || gstAmount == '') {
            gstAmount = '0';
          }
          if (price == null || price == '') {
            price = '0';
          }
          if (amount == null || amount == '') {
            amount = '0';
          }

          if (fld == 'qty' || fld == 'rate') {
            amt = double.parse(qty) * double.parse(rate);
            _controller[10].text = amt.toString();
          }

          //sell price program ,offeramount

          if (fld == 'sellper') {
            sellprice = (double.parse(sellper) * double.parse(rate) * 0.01) +
                double.parse(rate);
            // _controller[4].text = sellper.toString();
            _controller[5].text = sellprice.toString();
            // _controller[9].text = offersellprice.toString();

            sellprice = sellprice - double.parse(offerprice);
            _controller[5].text = sellprice.toString();
            _controller[9].text = sellprice.toString();
          }

          if (fld == 'offerper') {
            offerprice =
                (double.parse(offerper) * double.parse(sellprice) * 0.01);
            _controller[8].text = (offerprice.toStringAsFixed(2)).toString();

            offersellprice = double.parse(sellprice) - offerprice;
            _controller[9].text =
                (offersellprice.toStringAsFixed(2)).toString();

            // offersellprice = double.parse(sellprice) - offerprice;
            // _controller[9].text =
            //     (offersellprice.toStringAsFixed(2)).toString();
          }

          if (fld == 'offeramt') {
            offersellprice = double.parse(sellprice) - double.parse(offerprice);
            _controller[9].text =
                (offersellprice.toStringAsFixed(2)).toString();

            offerper =
                ((double.parse(offerprice) * 100) / double.parse(sellprice));
            _controller[7].text = (offerper.toStringAsFixed(1)).toString();
          }

          if (fld == 'gst' || fld == 'amount') {
            price = double.parse(gstAmount) + double.parse(amount);
            _controller[12].text = (price.toStringAsFixed(2).toString());
          }
        },
        // onChanged: ,
      ));
}

Widget CustomDropdown(
    String fld, double width, dynamic _items, _controller, dynamic htxt) {
  if (htxt == null) {
    htxt = 'Search Here';
  }
  dynamic controller;
  if (fld == 'product') {
    controller = _controller[0];
    var rate = _controller[3].text;
  } else if (fld == 'unit') {
    controller = _controller[6];
    var rate = _controller[3].text;
  }

  return SizedBox(
    width: width,
    child: DropdownTextSearch(
        onChange: (val) {
          controller.text = val;
        },
        noItemFoundText: "Invalid Search",
        controller: controller,
        overlayHeight: 300,
        items: _items,
        hoverColor: const Color.fromARGB(255, 185, 218, 245),
        filterFnc: (String a, String b) {
          return a.toLowerCase().startsWith(b.toLowerCase());
        },
        decorator: InputDecoration(hintText: htxt)),
  );
}

Widget SalesTextfield(String fld, double width, dynamic _controllertext,
    dynamic htxt, dynamic ratevalue) {
  dynamic controller;
  if (fld == 'qty') {
    controller = _controllertext[0];
  } else if (fld == 'amount') {
    controller = _controllertext[1];
  } else if (fld == 'disc') {
    controller = _controllertext[2];
  } else if (fld == 'disc_amount') {
    controller = _controllertext[3];
  } else if (fld == 'total') {
    controller = _controllertext[4];
  }
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: htxt,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
      ),
    ),
    onChanged: (value) {
      var Rate = ratevalue;
      var Qty = _controllertext[0].text;
      var Amount = _controllertext[1].text;

      var Disc = _controllertext[2].text;
      var Disc_amount = _controllertext[3].text;
      var Total = _controllertext[4].text;
      // if (Rate == null || Rate == '') {
      //   Rate = '1';
      //   _controllertext[0].text = Rate;
      // }
      if (Qty == null || Qty == '') {
        Qty = '0';
        _controllertext[0].text = Qty;
      }
      if (Amount == null || Amount == '') {
        Amount = '1';
        _controllertext[1].text = Amount;
      }
      if (Disc == null || Disc == '') {
        Disc = '0';
        _controllertext[2].text = Disc;
      }
      if (Disc_amount == null || Disc_amount == '') {
        Disc_amount = '0';
        _controllertext[3].text = Disc_amount;
      }
      if (Total == null || Total == '') {
        Total = '0';
        _controllertext[4].text = Total;
      }
      if (fld == 'qty') {
        Amount = int.parse(Qty) * int.parse(Rate);
        _controllertext[1].text = Amount.toString();
      }
      if (fld == 'disc') {
        Disc_amount = (double.parse(Disc) * double.parse(Rate) * 0.01);
        Disc_amount = (Disc_amount.toStringAsFixed(2)).toString();
        _controllertext[4].text = Disc_amount;

        Amount = _controllertext[2].text;
        _controllertext[5].text =
            (double.parse(Amount) - double.parse(Disc_amount)).toString();
      }
      if (fld == 'disc_amount') {
        // Amount = double.parse(Amount) - double.parse(Disc_amount);
        // _controllertext[5].text = (Amount.toStringAsFixed(2)).toString();
        Disc = ((double.parse(Disc_amount) * 100) / double.parse(Rate));
        _controllertext[3].text = (Disc.toStringAsFixed(1)).toString();
        Amount = _controllertext[2].text;
        _controllertext[5].text =
            (double.parse(Amount) - double.parse(_controllertext[4].text))
                .toString();
      }
    },
  );
}

Widget ClosingTextfield(
    String fld, double width, _close, _pcs, _amount, dynamic htxt) {
  dynamic controller;
  if (htxt == null || htxt == '') {
    htxt = '0';
  }

  if (fld == 'Last Day Closing') {
    controller = _close[0];
  } else if (fld == 'Receipt') {
    controller = _close[1];
  } else if (fld == 'Payment') {
    controller = _close[2];
  } else if (fld == 'Balance') {
    controller = _close[3];
  } else if (fld == 'Adjustment') {
    controller = _close[4];
  } else if (fld == 'Total') {
    controller = _close[5];
  } else if (fld == '2000') {
    controller = _pcs[0];
  } else if (fld == '500') {
    controller = _pcs[1];
  } else if (fld == '200') {
    controller = _pcs[2];
  } else if (fld == '100') {
    controller = _pcs[3];
  } else if (fld == '50') {
    controller = _pcs[4];
  } else if (fld == '20') {
    controller = _pcs[5];
  } else if (fld == '10') {
    controller = _pcs[6];
  } else if (fld == '5') {
    controller = _pcs[7];
  } else if (fld == '2') {
    controller = _pcs[8];
  } else if (fld == '1') {
    controller = _pcs[9];
  } else if (fld == 'amt1') {
    controller = _amount[0];
  } else if (fld == 'amt2') {
    controller = _amount[1];
  } else if (fld == 'amt3') {
    controller = _amount[2];
  } else if (fld == 'amt4') {
    controller = _amount[3];
  } else if (fld == 'amt5 ') {
    controller = _amount[4];
  } else if (fld == 'amt6') {
    controller = _amount[5];
  } else if (fld == 'amt7') {
    controller = _amount[6];
  } else if (fld == 'amt8') {
    controller = _amount[7];
  } else if (fld == 'amt9') {
    controller = _amount[8];
  } else if (fld == 'amt10') {
    controller = _amount[9];
  } else if (fld == 'Total_All') {
    controller = _amount[10];
  }
  return Container(
      width: width,
      height: 40,
      padding: EdgeInsets.only(right: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
            ),
            hintText: htxt,
            hintStyle: TextStyle(fontSize: 15, color: Colors.black)),
        onChanged: (value) {
          var Pcs1 = _pcs[0].text;
          var Pcs2 = _pcs[1].text;
          var Pcs3 = _pcs[2].text;
          var Pcs4 = _pcs[3].text;
          var Pcs5 = _pcs[4].text;
          var Pcs6 = _pcs[5].text;
          var Pcs7 = _pcs[6].text;
          var Pcs8 = _pcs[7].text;
          var Pcs9 = _pcs[8].text;
          var Pcs10 = _pcs[9].text;

          var amount1 = _amount[0].text;
          var amount2 = _amount[1].text;
          var amount3 = _amount[2].text;
          var amount4 = _amount[3].text;
          var amount5 = _amount[4].text;
          var amount6 = _amount[5].text;
          var amount7 = _amount[6].text;
          var amount8 = _amount[7].text;
          var amount9 = _amount[8].text;
          var amount10 = _amount[9].text;
          var amount11;

          if (amount1 == null || amount1 == '') {
            amount1 = '0';
            _amount[0].text = amount1;
          }
          if (amount2 == null || amount2 == '') {
            amount2 = '0';
            _amount[1].text = amount2;
          }
          if (amount3 == null || amount3 == '') {
            amount3 = '0';
            _amount[2].text = amount3;
          }
          if (amount4 == null || amount4 == '') {
            amount4 = '0';
            _amount[3].text = amount4;
          }
          if (amount5 == null || amount5 == '') {
            amount5 = '0';
            _amount[4].text = amount5;
          }
          if (amount6 == null || amount6 == '') {
            amount6 = '0';
            _amount[5].text = amount6;
          }
          if (amount7 == null || amount7 == '') {
            amount7 = '0';
            _amount[6].text = amount7;
          }
          if (amount8 == null || amount8 == '') {
            amount8 = '0';
            _amount[7].text = amount8;
          }
          if (amount9 == null || amount9 == '') {
            amount9 = '0';
            _amount[8].text = amount9;
          }
          if (amount10 == null || amount10 == '') {
            amount10 = '0';
            _amount[9].text = amount10;
          }
          if (amount11 == null || amount11 == '') {
            amount11 = 0;
          }

          if (Pcs1 == null || Pcs1 == '') {
            Pcs1 = '0';
          }
          if (Pcs2 == null || Pcs2 == '') {
            Pcs2 = '0';
          }
          if (Pcs3 == null || Pcs3 == '') {
            Pcs3 = '0';
          }
          if (Pcs4 == null || Pcs4 == '') {
            Pcs4 = '0';
          }
          if (Pcs5 == null || Pcs5 == '') {
            Pcs5 = '0';
          }
          if (Pcs6 == null || Pcs6 == '') {
            Pcs6 = '0';
          }
          if (Pcs7 == null || Pcs7 == '') {
            Pcs7 = '0';
          }
          if (Pcs8 == null || Pcs8 == '') {
            Pcs8 = '0';
          }
          if (Pcs9 == null || Pcs9 == '') {
            Pcs9 = '0';
          }
          if (Pcs10 == null || Pcs10 == '') {
            Pcs10 = '0';
          }

          if (fld == '2000') {
            amount1 = double.parse(Pcs1) * double.parse(fld);

            _amount[0].text = amount1.toString();
          }

          if (fld == '500') {
            amount2 = double.parse(Pcs2) * double.parse(fld);
            _amount[1].text = amount2.toString();
          }

          if (fld == '200') {
            amount3 = double.parse(Pcs3) * double.parse(fld);
            _amount[2].text = amount3.toString();
          }

          if (fld == '100') {
            amount4 = double.parse(Pcs4) * double.parse(fld);
            _amount[3].text = amount4.toString();
          }

          if (fld == '50') {
            print(fld);
            amount5 = double.parse(Pcs5) * double.parse(fld);
            print(amount5);
            _amount[4].text = amount5.toString();
          }

          if (fld == '20') {
            amount6 = double.parse(Pcs6) * double.parse(fld);
            _amount[5].text = amount6.toString();
          }

          if (fld == '10') {
            amount7 = double.parse(Pcs7) * double.parse(fld);
            _amount[6].text = amount7.toString();
          }

          if (fld == '5') {
            amount8 = double.parse(Pcs8) * double.parse(fld);
            _amount[7].text = amount8.toString();
          }
          if (fld == '2') {
            amount9 = double.parse(Pcs9) * double.parse(fld);
            _amount[8].text = amount9.toString();
          }
          if (fld == '1') {
            amount10 = double.parse(Pcs10) * double.parse(fld);
            _amount[9].text = amount10.toString();
          }

          amount1 = _amount[0].text;
          amount2 = _amount[1].text;
          amount3 = _amount[2].text;
          amount4 = _amount[3].text;
          amount5 = _amount[4].text;
          amount6 = _amount[5].text;
          amount7 = _amount[6].text;
          amount8 = _amount[7].text;
          amount9 = _amount[8].text;
          amount10 = _amount[9].text;
          amount11 = double.parse(amount1) +
              double.parse(amount2) +
              double.parse(amount3) +
              double.parse(amount4) +
              double.parse(amount5) +
              double.parse(amount6) +
              double.parse(amount7) +
              double.parse(amount8) +
              double.parse(amount9) +
              double.parse(amount10);

          _amount[10].text = amount11.toString();
        },
      ));
}

// Widget Textfld(String fld, double width, _controller, dynamic htxt) {
//   if (htxt == null) {
//     htxt = '';
//   }
Widget Textfieldstaff(String fld, double width, _controller, dynamic htxt) {
  return Container(
    width: width,
    height: 40,
    padding: EdgeInsets.only(right: 20.0),
    child: TextField(
      controller: _controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 243, 234, 234)),
          ),
          hintText: htxt,
          hintStyle: TextStyle(fontSize: 15, color: Colors.black)),
    ),
  );
}

Widget Customdrawer(context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: Text('--- PERSONAL'),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushNamed("home");
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart_sharp),
          title: Text('Sales'),
          onTap: () {
            Navigator.of(context).pushNamed("sales");
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        ExpansionTile(
          title: Text("Master"),
          leading: Icon(Icons.info),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Products"),
                onTap: () {
                  Navigator.of(context).pushNamed("product");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Suppliers"),
                onTap: () {
                  Navigator.of(context).pushNamed('suppiler');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Customers"),
                onTap: () {
                  Navigator.of(context).pushNamed('customer');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Category"),
                onTap: () {
                  Navigator.of(context).pushNamed('category');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Sub category"),
                onTap: () {
                  Navigator.of(context).pushNamed('sub_category');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Size"),
                onTap: () {
                  Navigator.of(context).pushNamed('size');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Unit"),
                onTap: () {
                  Navigator.of(context).pushNamed('unit');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Purchase"),
                onTap: () {
                  Navigator.of(context).pushNamed('purchase');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Stock"),
                onTap: () {
                  Navigator.of(context).pushNamed('stock');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Account Root"),
                onTap: () {
                  Navigator.of(context).pushNamed('accountroot');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Account"),
                onTap: () {
                  Navigator.of(context).pushNamed('account');
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        ExpansionTile(
          title: Text("Account"),
          leading: Icon(Icons.account_balance_outlined),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Payment"),
                onTap: () {
                  Navigator.of(context).pushNamed('payment');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Receipt"),
                onTap: () {
                  Navigator.of(context).pushNamed('receipt');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Transaction"),
                onTap: () {
                  Navigator.of(context).pushNamed('transaction');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Closing"),
                onTap: () {
                  Navigator.of(context).pushNamed('closing');
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        ExpansionTile(
          title: Text("Reports"),
          leading: Icon(Icons.analytics),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Invoice Report"),
                onTap: () {
                  Navigator.of(context).pushNamed("invicereport");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Stack Report"),
                onTap: () {
                  Navigator.of(context).pushNamed('stockreport');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text("Closing Report"),
                onTap: () {
                  Navigator.of(context).pushNamed('closingreport');
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Staff'),
          onTap: () {
            Navigator.of(context).pushNamed('staffpage');
          },
        ),
        SizedBox(
          height: 35.0,
        ),
        Text('--- SUPPORT'),
        SizedBox(
          height: 35.0,
        ),
        ListTile(
          leading: Icon(Icons.person_outlined),
          title: Text('Profile'),
          onTap: () {
            Navigator.of(context).pushNamed('profile');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_outlined),
          title: Text('Log Out'),
          onTap: () {},
        ),
      ],
    ),
  );
}
