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

class Stockpage extends StatefulWidget {
  const Stockpage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Stockpage> {
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
        'SELECT * FROM  tbl_stock WHERE comp_id = "$comp_id"');
    product.clear();
    for (var item in rs) {
      // print(item['orderID']);
      OrderInfo lst = OrderInfo(
        item['id'],
        item['comp_id'],
        item['stk_id'],
        item['pur_id'],
        item['sup_id'],
        item['inv_no'],
        item['inv_date'],
        item['p_id'],
        item['hsn'],
        item['inward'],
        item['outward'],
        item['balance'],
        item['price'],
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
            title: Text('Stock Page'),
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
                        height: MediaQuery.of(context).size.height * 0.62,
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
                                      columnName: 'stk_id',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Stock Code',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'pur_id',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Purchase Code',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'sup_id',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Supplier Id',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'inv_no',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Invice No',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'inv_date',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Invice date',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'p_id',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'hsn',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                      columnName: 'inward',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Inward',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'outward',
                                        label: Container(
                                            padding: EdgeInsets.all(8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Outward',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    GridColumn(
                                        columnName: 'balance',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                      columnName: 'price',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Price',
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
    this.stk_id,
    this.pur_id,
    this.sup_id,
    this.inv_no,
    this.inv_date,
    this.p_id,
    this.hsn,
    this.inward,
    this.outward,
    this.balance,
    this.price,
    this.created_at,
    this.update_at,
  );
  final int? id;
  final String? comp_id;
  final String? stk_id;
  final String? pur_id;
  final String? sup_id;
  final String? inv_no;
  final DateTime? inv_date;
  final String? p_id;
  final String? hsn;

  final String? inward;
  final String? outward;
  final String? balance;
  final String? price;
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
        DataGridCell(columnName: 'stk_id', value: dataGridRow.stk_id),
        DataGridCell(columnName: 'pur_id', value: dataGridRow.pur_id),
        DataGridCell(columnName: 'sup_id', value: dataGridRow.sup_id),
        DataGridCell(columnName: 'inv_no', value: dataGridRow.inv_no),
        DataGridCell(columnName: 'inv_date', value: dataGridRow.inv_date),
        DataGridCell(columnName: 'p_id', value: dataGridRow.p_id),
        DataGridCell(columnName: 'hsn', value: dataGridRow.hsn),
        DataGridCell(columnName: 'inward', value: dataGridRow.inward),
        DataGridCell(columnName: 'outward', value: dataGridRow.outward),
        DataGridCell(columnName: 'balance', value: dataGridRow.balance),
        DataGridCell(columnName: 'price', value: dataGridRow.price),
        DataGridCell(columnName: 'created_at', value: dataGridRow.created_at),
        DataGridCell(columnName: 'update_at', value: dataGridRow.update_at),
      ]);
    }).toList(growable: false);
  }
}
