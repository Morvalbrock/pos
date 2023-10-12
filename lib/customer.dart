import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pos/addcustomer.dart';
import 'package:pos/view_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

// import 'package:syncfusion_flutter_datagrid_export/export.dart';
// Local import

import 'custom.dart';
import 'edit_customer.dart';
import 'helper/connection.dart';
import 'helper/save_file_mobile.dart'
    if (dart.library.html) 'helper/save_file_web.dart' as helper;
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_core/theme.dart';

TextEditingController _controllercusaddname = TextEditingController();
TextEditingController _controllercusaddaddress = TextEditingController();
TextEditingController _controllercusaddmobile = TextEditingController();
TextEditingController _controllercusaddemail = TextEditingController();
TextEditingController _controllercusadddob = TextEditingController();
TextEditingController _controllercusadddetails = TextEditingController();
TextEditingController _controllercusdate = TextEditingController();
final id = '';
final List<supplierInfo> product = [];
List<supplierInfo> paginatedDataSource = [];
final int rowsPerPage = 10;

late OrderInfoDataSource _productInfoDataSource;

final GlobalKey<SfDataGridState> _keys = GlobalKey<SfDataGridState>();

class Customerpage extends StatefulWidget {
  const Customerpage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Customerpage> {
  static const double dataPagerHeight = 60;

  @override
  void initState() {
    super.initState();
    getOrder();

    EasyLoading.show(status: 'loading...');
    _productInfoDataSource = OrderInfoDataSource();
    Timer(Duration(seconds: 5), () {
      setState(() {
        _productInfoDataSource = OrderInfoDataSource();
      });
      EasyLoading.dismiss();
    });
    _productInfoDataSource.addListener(updateWidget);
  }

  Future<dynamic> getOrder() async {
    // await Future.delayed(Duration(seconds: 10));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    List<dynamic> rs = await SelectionQry(
        'SELECT * FROM  tbl_customer WHERE comp_id = "$comp_id"');
    product.clear();
    for (var item in rs) {
      // print(item['orderID']);
      supplierInfo lst = supplierInfo(
        item['id'],
        item['comp_id'],
        item['cus_id'],
        item['cus_name'],
        item['cus_address'].toString(),
        item['cus_mobile'],
        item['cus_email'],
        item['cus_dob'],
        item['cus_details'].toString(),
        item['created_at'],
        item['update_at'],
      );
      product.add(lst);
    }
    return product ?? [];
  }

  updateWidget() {
    setState(() {});
  }

  Future<void> _exportDataGridToExcel() async {
    final currentState = _keys.currentState;
    Workbook workbook = currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  }

  Future<void> _exportDataGridToPdf() async {
    final PdfDocument document =
        _keys.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    await helper.saveAndLaunchFile(bytes, 'DataGrid.pdf');
    document.dispose();
  }

  final formKey56 = GlobalKey<FormState>();

  Future<void> _showDatePickers() async {
    _controllercusadddob.text = DateTime.now().toString();
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
    );
    if (_picked != null) {
      setState(() {
        _controllercusadddob.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Paginated SfDataGrid',
        home: Form(
          key: formKey56,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(236, 133, 36, 1),
              title: Text('Customer'),
            ),
            drawer: Customdrawer(context),
            body: LayoutBuilder(builder: (context, constraint) {
              if (product.isEmpty) {
                return SizedBox();
              } else {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 13.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                            width: 150.0,
                            child: MaterialButton(
                                color: Color.fromRGBO(72, 117, 146, 1),
                                onPressed: _exportDataGridToExcel,
                                child: const Center(
                                    child: Text(
                                  'Export to Excel',
                                  style: TextStyle(color: Colors.white),
                                ))),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(
                                  bottom: 40.0, top: 40.0, left: 40.0)),
                          SizedBox(
                            height: 40.0,
                            width: 150.0,
                            child: MaterialButton(
                                color: const Color.fromRGBO(252, 180, 70, 1),
                                onPressed: _exportDataGridToPdf,
                                child: const Center(
                                    child: Text(
                                  'Export to PDF',
                                  style: TextStyle(color: Colors.white),
                                ))),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 40.0,
                            width: 100.0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: MaterialButton(
                                color: const Color.fromARGB(255, 68, 172, 71),
                                child: const Text(
                                  'ADD',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddCustomer(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.72,
                          child: SizedBox(
                              height: constraint.maxHeight - dataPagerHeight,
                              width: constraint.maxWidth,
                              child: SfDataGridTheme(
                                data: SfDataGridThemeData(
                                  headerColor: Color.fromRGBO(21, 83, 120, 1),
                                  rowHoverColor:
                                      Color.fromRGBO(166, 216, 245, 1),
                                ),
                                child: SfDataGrid(
                                    // https://help.syncfusion.com/flutter/datagrid/export-to-excel
                                    key: _keys,
                                    allowSorting: true,
                                    allowFiltering: true,
                                    source: _productInfoDataSource,
                                    onCellTap: (details) {
                                      int selectedRowIndex =
                                          details.rowColumnIndex.rowIndex - 1;
                                      var row = _productInfoDataSource
                                          .effectiveRows
                                          .elementAt(selectedRowIndex);
                                      print(row.getCells()[0].value);
                                      // this.id,
                                      //   this.comp_id,
                                      //   this.cus_id,
                                      //   this.cus_name,
                                      //   this.cus_address,
                                      //   this.cus_mobile,
                                      //   this.cus_email,
                                      //   this.sup_dob,
                                      //   this.cus_details,
                                      //   this.created_at,
                                      //   this.update_at,
                                      Map<String, dynamic> fetchedData = {
                                        'id': row.getCells()[0].value,
                                        'comp_id': row.getCells()[1].value,
                                        'cus_id': row.getCells()[2].value,
                                        'cus_name': row.getCells()[3].value,
                                        'cus_address': row.getCells()[4].value,
                                        'cus_mobile': row.getCells()[5].value,
                                        'cus_email': row.getCells()[6].value,
                                        'cus_dob': row.getCells()[7].value,
                                        'cus_details': row.getCells()[8].value,
                                        'created_at': row.getCells()[9].value,
                                        'update_at': row.getCells()[10].value,
                                      };

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                  title: const Text('Action'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text('Close'))
                                                  ],
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      IconButton(
                                                          tooltip: 'View',
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    View_customer(
                                                                        customerInfo:
                                                                            fetchedData),
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(Icons
                                                              .remove_red_eye)),
                                                      IconButton(
                                                          tooltip: 'Edit',
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Editing_customer(
                                                                        customerInfo:
                                                                            fetchedData),
                                                              ),
                                                            );
                                                          },
                                                          icon:
                                                              Icon(Icons.edit)),
                                                      IconButton(
                                                          tooltip: 'Delete',
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                title:
                                                                    Container(
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            'Delete Screen',
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Spacer(),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon:
                                                                              Icon(Icons.close)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                content:
                                                                    Container(
                                                                  height: 100.0,
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                          'Confirm you want delete the data'),
                                                                      SizedBox(
                                                                        height:
                                                                            20.0,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                primary: Colors.red,
                                                                              ),
                                                                              onPressed: () async {
                                                                                Navigator.pop(context);
                                                                                EasyLoading.show(status: 'loading...');
                                                                                dynamic rs = await deletequery('DELETE FROM `tbl_customer` WHERE `id` =' + fetchedData["id"].toString());

                                                                                if (rs == true) {
                                                                                  Navigator.pop(context);
                                                                                  getOrder();
                                                                                  _productInfoDataSource = OrderInfoDataSource();
                                                                                  Timer(Duration(seconds: 5), () {
                                                                                    setState(() {
                                                                                      _productInfoDataSource = OrderInfoDataSource();
                                                                                    });
                                                                                    EasyLoading.dismiss();
                                                                                  });
                                                                                } else {
                                                                                  Navigator.pop(context);
                                                                                }
                                                                              },
                                                                              child: Text('Confirm')),
                                                                          Spacer(),
                                                                          ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                primary: Colors.green,
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text('Cancel')),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(
                                                              Icons.delete)),
                                                    ],
                                                  )));
                                    },
                                    columnWidthMode: ColumnWidthMode.fill,
                                    allowEditing: true,
                                    headerGridLinesVisibility:
                                        GridLinesVisibility.both,
                                    columns: <GridColumn>[
                                      GridColumn(
                                          columnName: 'id',
                                          visible: false,
                                          label: Text('')),
                                      GridColumn(
                                          columnName: 'comp_id',
                                          visible: false,
                                          label: Text('')),
                                      GridColumn(
                                        columnName: 'cus_id',
                                        // visible: false,
                                        allowEditing: true,
                                        label: Container(
                                            padding: EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Id',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      GridColumn(
                                        columnName: 'cus_name',
                                        // visible: false,
                                        allowEditing: true,
                                        label: Container(
                                            padding: EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Name',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      GridColumn(
                                          columnName: 'cus_address',
                                          visible: false,
                                          label: Text('')),
                                      GridColumn(
                                        columnName: 'cus_mobile',
                                        // visible: false,
                                        allowEditing: true,
                                        label: Container(
                                            padding: EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Mobile',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      GridColumn(
                                        columnName: 'cus_email',
                                        // visible: false,
                                        allowEditing: true,
                                        label: Container(
                                            padding: EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Emails',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      GridColumn(
                                        columnName: 'cus_dob',
                                        // visible: false,
                                        allowEditing: true,
                                        label: Container(
                                            padding: EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'DOB',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      GridColumn(
                                          columnName: 'cus_details',
                                          visible: false,
                                          label: Text('')),
                                      GridColumn(
                                          columnName: 'created_at',
                                          visible: false,
                                          label: Text('')),
                                      GridColumn(
                                          columnName: 'updated_at',
                                          visible: false,
                                          label: Text('')),
                                    ]),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      height: dataPagerHeight,
                      color: Colors.white,
                      child: SfDataPagerTheme(
                        data: SfDataPagerThemeData(
                            itemBorderWidth: 0.5,
                            itemBorderColor: Colors.grey.shade400,
                            itemBorderRadius: BorderRadius.circular(5),
                            selectedItemColor: Color.fromRGBO(21, 83, 120, 1)),
                        child: SfDataPager(
                          firstPageItemVisible: true,
                          lastPageItemVisible: true,
                          visibleItemsCount: 3,
                          navigationItemWidth: 100,
                          pageCount:
                              (product.length / rowsPerPage).ceilToDouble(),
                          delegate: _productInfoDataSource,
                          direction: Axis.horizontal,
                          pageItemBuilder: (String itemName) {
                            if (itemName == 'Next') {
                              return const Center(
                                child: Text('Next'),
                              );
                            }
                            if (itemName == 'Previous') {
                              return const Center(
                                child: Text('Previous'),
                              );
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
          ),
        ));
  }
}

class supplierInfo {
  supplierInfo(
    this.id,
    this.comp_id,
    this.cus_id,
    this.cus_name,
    this.cus_address,
    this.cus_mobile,
    this.cus_email,
    this.cus_dob,
    this.cus_details,
    this.created_at,
    this.update_at,
  );
  final int? id;
  final String? comp_id;
  final String? cus_id;
  final String? cus_name;
  final String? cus_address;
  final String? cus_mobile;
  final String? cus_email;

  final DateTime? cus_dob;
  final String? cus_details;

  final DateTime? created_at;
  final DateTime? update_at;
}

class OrderInfoDataSource extends DataGridSource {
  OrderInfoDataSource() {
    paginatedDataSource = List.from(product.toList(growable: false));
    buildPaginatedDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * rowsPerPage;
    int endIndex = startRowIndex + rowsPerPage;

    if (endIndex > product.length) {
      endIndex = product.length;
    }

    paginatedDataSource = List.from(
        product.getRange(startRowIndex, endIndex).toList(growable: false));
    buildPaginatedDataGridRows();
    notifyListeners();
    return true;
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = paginatedDataSource.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'id', value: dataGridRow.id),
        DataGridCell(columnName: 'comp_id', value: dataGridRow.comp_id),
        DataGridCell(columnName: 'cus_id', value: dataGridRow.cus_id),
        DataGridCell(columnName: 'cus_name', value: dataGridRow.cus_name),
        DataGridCell(columnName: 'cus_address', value: dataGridRow.cus_address),
        DataGridCell(columnName: 'cus_mobile', value: dataGridRow.cus_mobile),
        DataGridCell(columnName: 'cus_email', value: dataGridRow.cus_email),
        DataGridCell(columnName: 'cus_dob', value: dataGridRow.cus_dob),
        DataGridCell(columnName: 'cus_details', value: dataGridRow.cus_details),
        DataGridCell(columnName: 'created_at', value: dataGridRow.created_at),
        DataGridCell(columnName: 'update_at', value: dataGridRow.update_at),
      ]);
    }).toList(growable: false);
  }
}
