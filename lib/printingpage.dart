import 'dart:async';
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos/helper/connection.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrintingPage extends StatefulWidget {
  const PrintingPage({super.key});

  @override
  State<PrintingPage> createState() => _PrintingPageState();
}

class _PrintingPageState extends State<PrintingPage> {
  List<Map<String, dynamic>> user_data = [];

  List<Map<String, dynamic>> invoice_data = [];

  List<Map<String, dynamic>> invoice_product_data = [];

  var i;

  // late String _accountrootvalue;
  getOrder() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');

    List<dynamic> userdata = await SelectionQry(
        'SELECT `id`, `company_id`, `company_name`, `owner_name`, `mobile_no`, `email`, `username`, `password`, `gst_no`, `address`, `state`, `website`, `type`, `bank_name`, `branch_name`, `ac_no`, `ifsc_code`, `privileges`, `remember_token`, `last_login`, `email_verified_at`, `created_at`, `updated_at` FROM `users` WHERE `company_id`="$comp_id"');

    List<dynamic> invdata = await SelectionQry(
        'SELECT *,(SELECT CONCAT(`cus_id`,"-", `cus_name`,"-", `cus_address`,"-", `cus_mobile`,"-", `cus_email`) FROM `tbl_customer`  WHERE `comp_id`=tbl_invoice.comp_id AND cus_id=tbl_invoice.cus_id) AS tbl_customer FROM `tbl_invoice`  WHERE `comp_id`="$comp_id" AND inv_no="ANS00006"');

    List<dynamic> invProductData = await SelectionQry(
        'SELECT *,(SELECT `p_name` FROM `tbl_product` WHERE `comp_id`=tbl_invproducts.comp_id AND p_id=tbl_invproducts.p_id ) AS p_name,@a:=@a+1 serial_number FROM `tbl_invproducts`,(SELECT @a:= 0) AS a WHERE `comp_id`="$comp_id" AND inv_no="ANS00006"');

    invoice_data.clear();
    user_data.clear();

    for (var row in invProductData) {
      invoice_product_data.add({
        'qty': row['qty'],
        'rate': row['rate'],
        'amount': row['amount'],
        'total': row['total'],
        'p_name': row['p_name'],
        'serial_number': row['serial_number'],
      });
    }
    for (var row in invdata) {
      invoice_data.add({
        'inv_no': row['inv_no'],
        'inv_date': row['inv_date'],
        'cus_name': row['cus_name'],
        'cus_address': row['cus_address'],
        'cus_mobile': row['cus_mobile'],
        'cus_email': row['cus_email'],
      });
    }

    for (var row in userdata) {
      user_data.add({
        'company_name': row['company_name'],
        'owner_name': row['owner_name'],
        'address': row['address'],
        'mobile_no': row['mobile_no'],
        'email': row['email'],
        'bank_name': row['bank_name'],
        'branch_name': row['branch_name'],
        'ac_no': row['ac_no'],
        'ifsc_code': row['ifsc_code'],
      });
    }
  }

  void initState() {
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Printing Page")),
      body: PdfPreview(
        build: (format) => _generatePdf(format, "Printing Page"),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Container(
                  width: 482.0,
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.only(
                    top: 12.0,
                    bottom: 11.0,
                  ),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(
                        vertical: pw.BorderSide(), horizontal: pw.BorderSide()),
                  ),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(right: 8.0),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          user_data[0]['company_name'],
                          style: pw.TextStyle(
                              fontSize: 14.0, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 1.0),
                        pw.Text(
                          user_data[0]['address'].toString(),
                          style: const pw.TextStyle(
                            fontSize: 7,
                          ),
                        ),
                        pw.SizedBox(height: 1.0),
                        // pw.Text(
                        //   "KARKOODALPATTY (P. O), RASIPURAM (T. K), NAMAKKAL (D. T)-636202",
                        //   style: const pw.TextStyle(
                        //     fontSize: 7.0,
                        //   ),
                        // ),
                        pw.SizedBox(height: 1.0),
                        pw.Text(
                          "Phone no:${user_data[0]['mobile_no']} Email:${user_data[0]['email']}",
                          style: const pw.TextStyle(
                            fontSize: 7.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(
                    width: 243.0,
                    child: pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 5.0),
                              child: pw.Text('Bill To:',
                                  style: const pw.TextStyle(fontSize: 8.0),
                                  textAlign: pw.TextAlign.left),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.SizedBox(
                              height: 30.0,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 5.0),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      invoice_data[0]['cus_name'].toString(),
                                      style: pw.TextStyle(
                                          fontSize: 7.0,
                                          fontWeight: pw.FontWeight.bold),
                                      textAlign: pw.TextAlign.left,
                                    ),
                                    pw.SizedBox(height: 2.0),
                                    pw.Text(
                                      invoice_data[0]['cus_address'].toString(),
                                      style: const pw.TextStyle(
                                        fontSize: 7.0,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2.0),
                                    pw.Text(
                                      'Contact No: ${invoice_data[0]['cus_mobile'].toString()}',
                                      style: const pw.TextStyle(
                                        fontSize: 7.0,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2.0),
                                  ],
                                ),
                              ),
                            ),
                            // pw.SizedBox(height: 15.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    width: 239.0,
                    padding: const pw.EdgeInsets.only(top: 12.0, bottom: 11.0),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border.symmetric(
                          vertical: pw.BorderSide(),
                          horizontal: pw.BorderSide()),
                    ),
                    child: pw.Text(
                      "Invoice No: ${invoice_data[0]['inv_no']}\nDate:${invoice_data[0]['inv_date']}",
                      style: pw.TextStyle(
                          fontSize: 7.0, fontWeight: pw.FontWeight.bold),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
              pw.Center(
                child: pw.Container(
                  width: 482.0,
                  child: DynamicTable(invoice_product_data),
                ),
              ),
              pw.Container(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Container(
                      width: 232.0,
                      padding:
                          const pw.EdgeInsets.only(top: 14.0, bottom: 13.0),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border.symmetric(
                            vertical: pw.BorderSide(),
                            horizontal: pw.BorderSide()),
                      ),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            "Invoice Amount In Words",
                            style: pw.TextStyle(
                                fontSize: 7.0, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            "Eight Thousand Four Hundred and Fifty Rupees only",
                            style: pw.TextStyle(fontSize: 7.0),
                          ),
                          pw.Text(
                            "Payment Mode",
                            style: pw.TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                          pw.Text(
                            "Credit",
                            style: pw.TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: 250.0,
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            " Amount:",
                            style: pw.TextStyle(
                                fontSize: 7.0, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                " Sub Total",
                                style: pw.TextStyle(fontSize: 7.0),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(
                                    right: 3.0, bottom: 3),
                                child: pw.Text(
                                  "Rs ${invoice_product_data[0]['total']}",
                                  style: pw.TextStyle(fontSize: 7.0),
                                ),
                              ),
                            ],
                          ),
                          pw.Container(
                            width: 250.0,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      " Total:",
                                      style: pw.TextStyle(
                                          fontSize: 7.0,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.only(
                                          right: 3.0, top: 3),
                                      child: pw.Text(
                                        "Rs ${invoice_product_data[0]['total']}",
                                        style: pw.TextStyle(fontSize: 7.0),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      " Recived",
                                      style: pw.TextStyle(fontSize: 7.0),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.only(
                                          right: 3.0, top: 3, bottom: 3.0),
                                      child: pw.Text(
                                        "Rs 0.0",
                                        style: pw.TextStyle(fontSize: 7.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 250.0,
                            padding: pw.EdgeInsets.only(bottom: 4.0),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  " Sub Total",
                                  style: pw.TextStyle(fontSize: 7.0),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      right: 3.0, top: 3),
                                  child: pw.Text(
                                    "Rs ${invoice_product_data[0]['total']}",
                                    style: pw.TextStyle(fontSize: 7.0),
                                  ),
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
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(
                    width: 232.0,
                    padding: const pw.EdgeInsets.only(top: 4.0, bottom: 4.0),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border.symmetric(
                          vertical: pw.BorderSide(),
                          horizontal: pw.BorderSide()),
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 5.0),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Terms and conditions:",
                            style: pw.TextStyle(
                                fontSize: 7.0, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 3.0),
                          pw.Text(
                            "Thank you for doing business with us.",
                            style: pw.TextStyle(fontSize: 7.0),
                          ),
                          pw.SizedBox(height: 3.0),
                          pw.Text(
                            "Bank details:",
                            style: pw.TextStyle(
                                fontSize: 7.0, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 3.0),
                          pw.Text(
                            "Bank Name:${user_data[0]['bank_name']}",
                            style: pw.TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                          pw.SizedBox(height: 3.0),
                          pw.Text(
                            "Bank Account No:${user_data[0]['ac_no']}",
                            style: pw.TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                          pw.SizedBox(height: 3.0),
                          pw.Text(
                            "Branch Name: ${user_data[0]['branch_name']}",
                            style: pw.TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                          pw.SizedBox(height: 3.0),
                          pw.Text(
                            "Bank IFSC code: ${user_data[0]['ifsc_code']}",
                            style: pw.TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                          pw.SizedBox(height: 3.0),
                          pw.Text(
                            "Account Holder's Name: ${user_data[0]['owner_name']}",
                            style: pw.TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 250.0,
                    padding: const pw.EdgeInsets.only(top: 28.0, bottom: 25.0),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border.symmetric(
                          vertical: pw.BorderSide(),
                          horizontal: pw.BorderSide()),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          "For, ${user_data[0]['company_name']}",
                          style: pw.TextStyle(fontSize: 7.0),
                        ),
                        pw.SizedBox(height: 25.0),
                        pw.Text(
                          "Authorized Signatory",
                          style: pw.TextStyle(
                            fontSize: 7.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 10.0,
              ),
              pw.Center(
                child: pw.ClipRRect(
                  child: pw.BarcodeWidget(
                    barcode: Barcode.gs128(),
                    data: 'https://dbestech.com',
                    drawText: false,
                    color: PdfColors.black,
                    width: 150.0,
                    height: 40.0,
                  ),
                ),
              ),
              pw.Divider(color: PdfColors.grey100),
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Acknowledgment',
                      style: pw.TextStyle(
                          fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      'MATHI FIBER NET',
                      style: pw.TextStyle(
                          fontSize: 10.0, fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 10.0),
              pw.Container(
                padding: pw.EdgeInsets.only(left: 30.0, right: 30.0),
                alignment: pw.Alignment.centerRight,
                child: pw.Row(
                  children: [
                    pw.Column(
                      children: [
                        pw.Text('Theenadhayalan ',
                            style: pw.TextStyle(
                                fontSize: 8.0, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 4.0),
                        pw.Text('THIRUMANUR ',
                            style: const pw.TextStyle(
                              fontSize: 8.0,
                            )),
                      ],
                    ),
                    pw.Spacer(),
                    pw.Column(
                      children: [
                        pw.Text(
                          'Invoice No. : 492',
                          style: const pw.TextStyle(fontSize: 8.0),
                        ),
                        pw.SizedBox(height: 4.0),
                        pw.Text(
                          'Invoice Date : 23-03-2022',
                          style: const pw.TextStyle(fontSize: 8.0),
                        ),
                        pw.SizedBox(height: 4.0),
                        pw.Text(
                          'Invoice Amount : 8450.0',
                          style: const pw.TextStyle(fontSize: 8.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 10.0),
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Column(
                  children: [
                    pw.Text(
                      "Receiver's Seal & Sig",
                      style: const pw.TextStyle(fontSize: 8.0),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}

DynamicTable(invoice_product_data) {
  return pw.Table(border: pw.TableBorder.all(), children: [
    pw.TableRow(
      children: [
        pw.Text('NO',
            style: const pw.TextStyle(fontSize: 9.0),
            textAlign: pw.TextAlign.center),
        pw.Text('DESCRIPTION ',
            style: const pw.TextStyle(fontSize: 9.0),
            textAlign: pw.TextAlign.center),
        pw.Text('QTY',
            style: const pw.TextStyle(fontSize: 9.0),
            textAlign: pw.TextAlign.center),
        pw.Text('MRP',
            style: const pw.TextStyle(fontSize: 9.0),
            textAlign: pw.TextAlign.center),
        pw.Text('PRICE ',
            style: const pw.TextStyle(fontSize: 9.0),
            textAlign: pw.TextAlign.center),
        pw.Text('AMOUNT',
            style: const pw.TextStyle(fontSize: 9.0),
            textAlign: pw.TextAlign.center),
      ],
    ),
    for (final row in invoice_product_data)
      pw.TableRow(
        children: [
          pw.Center(
            heightFactor: 5.0,
            child: pw.SizedBox(
              height: 5.0,
              child: pw.Text(
                row['serial_number'].toString(),
                style: const pw.TextStyle(fontSize: 8.0),
              ),
            ),
          ),
          // pw.SizedBox(height: 15.0),
          pw.Center(
            heightFactor: 5.0,
            child: pw.SizedBox(
              height: 5.0,
              child: pw.Text(
                row['p_name'].toString(),
                style: const pw.TextStyle(fontSize: 8.0),
              ),
            ),
          ),
          pw.Center(
            heightFactor: 5.0,
            child: pw.SizedBox(
              height: 5.0,
              child: pw.Text(
                row['qty'],
                style: const pw.TextStyle(fontSize: 8.0),
              ),
            ),
          ),
          pw.Center(
            heightFactor: 5.0,
            child: pw.SizedBox(
              height: 5.0,
              child: pw.Text(
                'Rs ${row['rate']} ',
                style: const pw.TextStyle(fontSize: 8.0),
              ),
            ),
          ),
          pw.Center(
            heightFactor: 5.0,
            child: pw.SizedBox(
              height: 5.0,
              child: pw.Text(
                'Rs ${row['rate']}',
                style: const pw.TextStyle(fontSize: 8.0),
              ),
            ),
          ),
          pw.Center(
            heightFactor: 5.0,
            child: pw.SizedBox(
              height: 5.0,
              child: pw.Text(
                'Rs ${row['amount']}',
                style: const pw.TextStyle(fontSize: 8.0),
              ),
            ),
          ),
        ],
      ),
    pw.TableRow(
      children: [
        pw.Center(
          heightFactor: 3.0,
          child: pw.SizedBox(
            height: 5.0,
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 6.0),
            ),
          ),
        ),
        // pw.SizedBox(height: 15.0),
        pw.Center(
          heightFactor: 3.0,
          child: pw.SizedBox(
            height: 5.0,
            child: pw.Padding(
              padding: pw.EdgeInsets.only(bottom: 6.0),
              child: pw.Text('Total',
                  style: pw.TextStyle(
                      fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center),
            ),
          ),
        ),
        pw.Center(
          heightFactor: 3.0,
          child: pw.SizedBox(
            height: 5.0,
            child: pw.Text(
              '2',
              style:
                  pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),
        pw.Center(
          child: pw.SizedBox(
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 6.0),
            ),
          ),
        ),
        pw.Center(
          child: pw.SizedBox(
            child: pw.Text(
              '',
              style:
                  pw.TextStyle(fontSize: 6.0, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),
        pw.Center(
          heightFactor: 3.0,
          child: pw.SizedBox(
            height: 5.0,
            child: pw.Text(
              'Rs ${invoice_product_data[0]['total']}',
              style:
                  pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  ]);
}
