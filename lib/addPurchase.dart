// ignore_for_file: non_constant_identifier_names, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:dropdown_text_search/dropdown_text_search.dart';
import 'package:pos/custom.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  // _MyFormState() {
  //   _selectedval2 = _listProduct[0];
  // }

  // _MyFormStates() {
  //   _selectedVal1 = _listName[0];
  // }

  final _listName = [
    "Choose Supplier",
    "Aura Agri Tech",
    "KEMICIDES CROP PROTECTION PVT LTD KRISHNAGIRI",
    "VISHAKAN BIOTECH PRAIVATE LIMITED"
  ];
  final _listProduct = ["Mayajaal 200 ml", "AURAFOS 250 ml", "V GAIN 100 ml"];
  final _listUnit = [
    "Per Piece",
    "Dozen",
    "Meter",
    "Centi Meter",
    "Cortun",
    "Set",
    "Par",
    "BOX",
    "125 GM",
    "1.5kg"
  ];
  // String? _selectedVal1 = "Choose Supplier";
  // dynamic _selectedval2 = "Choose Product";
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffeeeee),
      appBar: AppBar(
        title: const Text(
          'Add Purchase',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 1440,
                // height: 500,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 5, right: 5),
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Supplier',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 220,
                                        child: DropdownTextSearch(
                                            onChange: (val) {
                                              _controller.text = val;
                                            },
                                            noItemFoundText: "Invalid Search",
                                            controller: _controller,
                                            overlayHeight: 300,
                                            items: _listName,
                                            hoverColor: const Color.fromARGB(
                                                255, 185, 218, 245),
                                            filterFnc: (String a, String b) {
                                              return a
                                                  .toLowerCase()
                                                  .startsWith(b.toLowerCase());
                                            },
                                            decorator: const InputDecoration(
                                                hintText: 'Search Here')),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Invoice No',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      width: 300,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 243, 234, 234))),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 243, 234, 234)),
                                            ),
                                            hintText: 'Invoice No',
                                            hintStyle: TextStyle(
                                              fontSize: 15,
                                            )),
                                      )),
                                ],
                              ),
                              // Container(
                              //     padding: EdgeInsets.only(top: 30.0),
                              //     child: Text("Invoice Date")),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Invoice Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      width: 300,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextField(
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
                                            hintText: 'YYYY-MM-DD',
                                            hintStyle: TextStyle(fontSize: 15)),
                                        onTap: () {
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2023),
                                              lastDate: DateTime(2024));
                                        },
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 540.0,
                                child: SingleChildScrollView(
                                  child: DataTable(
                                    // columnSpacing: double.infinity,
                                    horizontalMargin: 0,
                                    columnSpacing: 0,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => const Color.fromRGBO(
                                                21, 83, 120, 1)),
                                    border: TableBorder.all(
                                        color: const Color(0xfffeeeee),
                                        width: 1.0,
                                        borderRadius: BorderRadius.circular(2)),
                                    columns: [
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Products/Goods',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'HSN/SAC',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Qty',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Rate',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Sell(%)',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Sell Price',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              'Unit',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Offer(%)',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Offer Amount',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Offer Sell Price',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Amount',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'GST(%)',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Price',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: TableRows(1),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Save'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(120, 50),
                                        backgroundColor: Colors.green[600],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Close'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(120, 50),
                                        backgroundColor: const Color.fromARGB(
                                            255, 78, 124, 155),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DataRow> TableRows(dynamic loop) {
    if (loop == null) {
      loop = 1;
    }
    loop = 5;

    // for (var a = 1; a <= loop; a++) {
    //   final List<TextEditingController> +''+a;
    // }
    List myControllers = List.generate(loop, (i) => TextEditingController());

    final List<DataRow> arr = [];

    for (var z = 1; z <= loop; z++) {
      List<TextEditingController> myController =
          List.generate(13, (i) => TextEditingController());

      arr.add(DataRow(cells: [
        DataCell(
          CustomDropdown('product', 220.0, _listProduct, myController, null),
        ),
        DataCell(Textfld('hsn', 110.0, myController, null)),
        DataCell(Textfld('qty', 70, myController, null)),
        DataCell(Textfld('rate', 100.0, myController, "₹")),
        DataCell(Textfld('sellper', 100.0, myController, "%")),
        DataCell(Textfld('sellprice', 100.0, myController, "₹")),
        DataCell(CustomDropdown('unit', 100.0, _listUnit, myController, null)),
        DataCell(Textfld('offerper', 90.0, myController, null)),
        DataCell(Textfld('offeramt', 100.0, myController, "₹")),
        DataCell(Textfld('offersellprice', 100.0, myController, "₹")),
        DataCell(Textfld('amount', 100.0, myController, "₹")),
        DataCell(Textfld('gst', 70.0, myController, null)),
        DataCell(
          Textfld('price', 100.0, myController, "₹"),
        ),
      ]));
    }
    List<TextEditingController> _newrowController =
        List.generate(13, (i) => TextEditingController());
    arr.add(DataRow(cells: [
      const DataCell(Text('')),
      DataCell(Textfld('hsn', 110.0, _newrowController, null)),
      DataCell(Textfld('qty', 70, _newrowController, null)),
      DataCell(Textfld('rate', 100.0, _newrowController, "₹")),
      DataCell(Textfld('sellper', 100.0, _newrowController, "%")),
      DataCell(Textfld('sellprice', 100.0, _newrowController, "₹")),
      const DataCell(Text('')),
      DataCell(Textfld('offerper', 90.0, _newrowController, null)),
      DataCell(Textfld('offeramt', 100.0, _newrowController, "₹")),
      DataCell(Textfld('offersellprice', 100.0, _newrowController, "₹")),
      DataCell(Textfld('amount', 100.0, _newrowController, "₹")),
      DataCell(Textfld('gst', 70.0, _newrowController, null)),
      DataCell(
        Textfld('price', 100.0, _newrowController, "₹"),
      ),
    ]));
    return arr;
  }
}
