import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

// import 'package:syncfusion_flutter_datagrid_export/export.dart';
// Local import

import 'custom.dart';
import 'helper/connection.dart';
import 'helper/save_file_mobile.dart'
    if (dart.library.html) 'helper/save_file_web.dart' as helper;
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_core/theme.dart';

final id = '';
final List<OrderInfo> product = [];
List<OrderInfo> paginatedDataSource = [];
final int rowsPerPage = 10;

late OrderInfoDataSource _productInfoDataSource;

final GlobalKey<SfDataGridState> _keys = GlobalKey<SfDataGridState>();

class Transactionpage extends StatefulWidget {
  const Transactionpage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Transactionpage> {
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var comp_id = prefs.getString('comp_id');
    List<dynamic> rs = await SelectionQry(
        'SELECT *,(SELECT acc_name FROM `tbl_account` WHERE comp_id="SER00007" AND acc_id=tbl_payment.acc_id) AS acc_name FROM `tbl_payment` WHERE comp_id = "$comp_id"');
    product.clear();
    for (var item in rs) {
      // print(item['orderID']);
      OrderInfo lst = OrderInfo(
        item['id'],
        item['comp_id'],
        item['pay_id'],
        item['acc_name'],
        item['pay_type'],
        item['acc_root'],
        item['acc_id'],
        item['pay_mode'],
        item['chq_no'],
        item['chq_date'],
        item['bank_name'],
        item['pay_amount'],
        item['pay_desc'].toString(),
        item['pay_date'],
        item['create_at'],
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Paginated SfDataGrid',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(236, 133, 36, 1),
            title: Text('Transaction Page'),
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
                                color: Color.fromARGB(255, 68, 172, 71),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'ADD Customer',
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.close)),
                                          ],
                                        ),
                                      ),
                                      content: Container(
                                        width: 500,
                                        height: 400,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text('Name:'),
                                                Spacer(),
                                                Container(
                                                    width: 300,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234))),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234)),
                                                              ),
                                                              hintText:
                                                                  'Enter Name',
                                                              hintStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          15)),
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text('Address:'),
                                                ),
                                                Spacer(),
                                                Container(
                                                    width: 300,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234))),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234)),
                                                              ),
                                                              hintText:
                                                                  'Enter Address',
                                                              hintStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          15)),
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text('Mobiles:'),
                                                ),
                                                Spacer(),
                                                Container(
                                                    width: 300,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234))),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234)),
                                                              ),
                                                              hintText:
                                                                  'Enter Mobile',
                                                              hintStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          15)),
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text('Email:'),
                                                ),
                                                Spacer(),
                                                Container(
                                                    width: 300,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234))),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234)),
                                                              ),
                                                              hintText:
                                                                  'Enter Email',
                                                              hintStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          15)),
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text('DOB:'),
                                                ),
                                                Spacer(),
                                                Container(
                                                    width: 300,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234))),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234)),
                                                              ),
                                                              hintText:
                                                                  'Enter DOB',
                                                              hintStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          15)),
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text('Details:'),
                                                ),
                                                Spacer(),
                                                Container(
                                                    width: 300,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234))),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234)),
                                                              ),
                                                              hintText:
                                                                  'Enter Details',
                                                              hintStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          15)),
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30, top: 20),
                                                  child: Container(
                                                    height: 30.0,
                                                    width: 100.0,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text('SUBMIT'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      94,
                                                                      214,
                                                                      98)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30, top: 20),
                                                  child: Container(
                                                    height: 30.0,
                                                    width: 100.0,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text('CLOSE'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Center(
                                    child: Text(
                                  'ADD',
                                  style: TextStyle(color: Colors.white),
                                ))),
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
                                rowHoverColor: Color.fromRGBO(166, 216, 245, 1),
                              ),
                              child: SfDataGrid(
                                  // https://help.syncfusion.com/flutter/datagrid/export-to-excel
                                  key: _keys,
                                  allowSorting: true,
                                  allowFiltering: true,
                                  source: _productInfoDataSource,
                                  onCellTap: (DataGridCellTapDetails details) {
                                    var id = _productInfoDataSource
                                        .effectiveRows[
                                            details.rowColumnIndex.rowIndex - 1]
                                        .getCells()[details
                                            .rowColumnIndex.columnIndex = 0]
                                        .value;

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
                                                        onPressed: () {},
                                                        icon: Icon(Icons
                                                            .remove_red_eye)),
                                                    IconButton(
                                                        tooltip: 'Edit',
                                                        onPressed: () {},
                                                        icon: Icon(Icons.edit)),
                                                    IconButton(
                                                        tooltip: 'Delete',
                                                        onPressed: () {},
                                                        icon:
                                                            Icon(Icons.delete)),
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
                                      columnName: 'pay_id',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'ID',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'acc_name',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Name',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'pay_type',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Payment Type',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'acc_root',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'acc_id',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                      columnName: 'pay_mode',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Payment Mode',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'chq_no',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'chq_date',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'bank_name',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'pay_amount',
                                        label: Container(
                                            padding: EdgeInsets.all(8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Amount',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    GridColumn(
                                        columnName: 'pay_desc',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                      columnName: 'pay_date',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Date',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'create_at',
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
        ));
  }
}

class OrderInfo {
  OrderInfo(
    this.id,
    this.comp_id,
    this.pay_id,
    this.acc_name,
    this.pay_type,
    this.acc_root,
    this.acc_id,
    this.pay_mode,
    this.chq_no,
    this.chq_date,
    this.bank_name,
    this.bank_account,
    this.pay_desc,
    this.pay_date,
    this.created_at,
    this.update_at,
  );
  final int? id;
  final String? comp_id;
  final String? pay_id;
  final String? acc_name;
  final String? pay_type;
  final String? acc_root;
  final String? acc_id;
  final String? pay_mode;
  final String? chq_no;
  final DateTime? chq_date;

  final String? bank_name;
  final String? bank_account;
  final String? pay_desc;
  final DateTime? pay_date;
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
        DataGridCell(columnName: 'pay_id', value: dataGridRow.pay_id),
        DataGridCell(columnName: 'acc_name', value: dataGridRow.acc_name),
        DataGridCell(columnName: 'pay_type', value: dataGridRow.pay_type),
        DataGridCell(columnName: 'acc_root', value: dataGridRow.acc_root),
        DataGridCell(columnName: 'acc_id', value: dataGridRow.acc_id),
        DataGridCell(columnName: 'pay_mode', value: dataGridRow.pay_mode),
        DataGridCell(columnName: 'chq_no', value: dataGridRow.chq_no),
        DataGridCell(columnName: 'chq_date', value: dataGridRow.chq_date),
        DataGridCell(columnName: 'bank_name', value: dataGridRow.bank_name),
        DataGridCell(
            columnName: 'bank_account', value: dataGridRow.bank_account),
        DataGridCell(columnName: 'pay_desc', value: dataGridRow.pay_desc),
        DataGridCell(columnName: 'pay_date', value: dataGridRow.pay_date),
        DataGridCell(columnName: 'created_at', value: dataGridRow.created_at),
        DataGridCell(columnName: 'update_at', value: dataGridRow.update_at),
      ]);
    }).toList(growable: false);
  }
}
