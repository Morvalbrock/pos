import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/accountroot.dart';
import 'package:pos/addPurchase.dart';
import 'package:pos/addStaff.dart';
import 'package:pos/addproduct.dart';
import 'package:pos/category.dart';
import 'package:pos/closing.dart';
import 'package:pos/closingreport.dart';
import 'package:pos/customer.dart';
import 'package:pos/home.dart';
import 'package:pos/invice_report.dart';
import 'package:pos/loginscreen.dart';
import 'package:pos/payment.dart';
import 'package:pos/printingpage.dart';
import 'package:pos/product.dart';
import 'package:pos/profile.dart';
import 'package:pos/purchase.dart';
import 'package:pos/receipt.dart';
import 'package:pos/sales.dart';
import 'package:pos/size.dart';
import 'package:pos/staff.dart';
import 'package:pos/stock.dart';
import 'package:pos/stockreport.dart';
import 'package:pos/subcategory.dart';
import 'package:pos/suppliers.dart';
import 'package:pos/transaction.dart';
import 'package:pos/unit.dart';
import 'account.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      builder: EasyLoading.init(),
      routes: {
        // '/': (context) => Profilepage(),
        '/': (context) => const LoginScreen(),
        'home': (context) => const Homepage(),
        'sales': (context) => const salespage(),
        'product': (context) => const Productpage(),
        'suppiler': (context) => const Supplierpage(),
        'customer': (context) => const Customerpage(),
        'category': (context) => const Categorypage(),
        'sub_category': (context) => const Subcategorypage(),
        'size': (context) => const Sizepage(),
        'unit': (context) => const Unitpage(),
        'purchase': (context) => const Purchasepage(),
        'addpurchase': (context) => const AddPurchase(),
        'stock': (context) => const Stockpage(),
        'accountroot': (context) => const Accountrootpage(),
        'account': (context) => const Accountpage(),
        'payment': (context) => const Paymentpage(),
        'receipt': (context) => const Receiptpage(),
        'transaction': (context) => const Transactionpage(),
        'closing': (context) => const closingPage(),
        // 'closingreport': (context) => Closingreportpage(),
        'closingreport': (context) => const PrintingPage(),
        'stockreport': (context) => const StockReportpage(),
        'staffpage': (context) => const Staffpage(),
        'add_staff': (context) => AddStaff(),
        'profile': (context) => const Profilepage(),
        'print': (context) => const PrintingPage(),
        'invicereport': (context) => const InviceReport(),
      },
    ),
  );
}
