import 'dart:async';

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
List<OrderInfo> orders = <OrderInfo>[];
List<OrderInfo> paginatedDataSource = [];
final int rowsPerPage = 10;
final _OrderInfoRepository _repository = _OrderInfoRepository();
late OrderInfoDataSource _orderInfoDataSource;
final GlobalKey<SfDataGridState> _keys = GlobalKey<SfDataGridState>();

class Closingreportpage extends StatefulWidget {
  const Closingreportpage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Closingreportpage> {
  static const double dataPagerHeight = 60;

  @override
  void initState() {
    super.initState();
    orders = _repository.getOrderDetails();
    _orderInfoDataSource = OrderInfoDataSource();
    _orderInfoDataSource.addListener(updateWidget);
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
            title: Text('Product Page'),
          ),
          drawer: Customdrawer(context),
          body: LayoutBuilder(builder: (context, constraint) {
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
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText: 'Enter Name',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15)),
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
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText:
                                                            'Enter Address',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15)),
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
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText:
                                                            'Enter Mobile',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15)),
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
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText: 'Enter Email',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15)),
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
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText: 'Enter DOB',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15)),
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
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            243,
                                                                            234,
                                                                            234))),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          234,
                                                                          234)),
                                                        ),
                                                        hintText:
                                                            'Enter Details',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15)),
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30, top: 20),
                                                child: Container(
                                                  height: 30.0,
                                                  width: 100.0,
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text('SUBMIT'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Color.fromARGB(
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
                                                padding: const EdgeInsets.only(
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
                      height: 611.0,
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
                                source: _orderInfoDataSource,
                                onCellTap: (DataGridCellTapDetails details) {
                                  var id = _orderInfoDataSource.effectiveRows[
                                          details.rowColumnIndex.rowIndex - 1]
                                      .getCells()[details
                                          .rowColumnIndex.columnIndex = 0]
                                      .value;
                                  _repository.getOrder(id);

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                              title:
                                                  const Text('Tapped Content'),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('OK'))
                                              ],
                                              content: Text(id.toString())));
                                },
                                columnWidthMode: ColumnWidthMode.fill,
                                allowEditing: true,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.both,
                                columns: <GridColumn>[
                                  GridColumn(
                                    columnName: 'id',
                                    // visible: false,
                                    allowEditing: true,
                                    label: Container(
                                        padding: EdgeInsets.all(16.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'id',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                  GridColumn(
                                      columnName: 'date',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Date',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'last_day',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Last Day',
                                            style:
                                                TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                  GridColumn(
                                      columnName: 'cash_in',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Cash IN',
                                            style:
                                                TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                  GridColumn(
                                      columnName: 'cash_out',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Cash Out',
                                            style:
                                                TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                  GridColumn(
                                      columnName: 'balance',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Balance',
                                            style:
                                                TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                  GridColumn(
                                      columnName: 'adjustment',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Adjustment',
                                            style:
                                                TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                  GridColumn(
                                      columnName: 'total',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Total',
                                            style:
                                                TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                ]),
                          )),
                    ),
                  ),
                ),
                Container(
                  height: dataPagerHeight,
                  color: Colors.white,
                  // alignment: Alignment.centerRight,
                  child: SfDataPagerTheme(
                    data: SfDataPagerThemeData(
                        // itemColor: Colors.white,
                        // selectedItemColor: Color.fromRGBO(236, 133, 36, 1),
                        // itemBorderRadius: BorderRadius.circular(5),
                        // backgroundColor: Color.fromRGBO(20, 104, 153, 1),

                        itemBorderWidth: 0.5,
                        itemBorderColor: Colors.grey.shade400,
                        itemBorderRadius: BorderRadius.circular(5),
                        selectedItemColor: Color.fromRGBO(21, 83, 120, 1)),
                    child: SfDataPager(
                      firstPageItemVisible: false,
                      lastPageItemVisible: false,
                      visibleItemsCount: 3,
                      navigationItemWidth: 100,
                      pageCount: (orders.length / rowsPerPage).ceilToDouble(),
                      delegate: _orderInfoDataSource,
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
          }),
        ));
  }
}

class OrderInfo {
  OrderInfo(
    this.id,
    this.date,
    this.last_day,
    this.cash_in,
    this.cash_out,
    this.balance,
    this.adjustment,
    this.total,
  );

  final String? id;
  final String? date;
  final String? last_day;
  final String? cash_in;
  final String? cash_out;
  final String? balance;
  final String? adjustment;
  final String? total;
}

class OrderInfoDataSource extends DataGridSource {
  OrderInfoDataSource() {
    paginatedDataSource = orders.getRange(0, rowsPerPage).toList();
    buildPaginatedDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * rowsPerPage;
    int endIndex = startRowIndex + rowsPerPage;

    if (endIndex > orders.length) {
      endIndex = orders.length;
    }

    paginatedDataSource = List.from(
        orders.getRange(startRowIndex, endIndex).toList(growable: false));
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
        DataGridCell(columnName: 'date', value: dataGridRow.date),
        DataGridCell(columnName: 'last_day', value: dataGridRow.last_day),
        DataGridCell(columnName: 'cash_in', value: dataGridRow.cash_in),
        DataGridCell(columnName: 'cash_out', value: dataGridRow.cash_out),
        DataGridCell(columnName: 'balance', value: dataGridRow.balance),
        DataGridCell(columnName: 'adjustment', value: dataGridRow.adjustment),
        DataGridCell(columnName: 'total', value: dataGridRow.total),
      ]);
    }).toList(growable: false);
  }
}

class _OrderInfoRepository {
  Future<List> getOrder(id) async {
    await Future.delayed(Duration(seconds: 1));
    List<dynamic> rs =
        await SelectionQry('SELECT * FROM tbl_product where p_id = "$id"');
    print(rs);
    return rs;
  }

  List<OrderInfo> getOrderDetails() {
    List<OrderInfo> orderDetails = [
      OrderInfo('P00001', 'James', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00002', 'Kathryn', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00003', 'Lara', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00004', 'Michael', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00005', 'Martin', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00006', 'Newberry', '9654223322', 'abc@gmail.com',
          '563321146', 'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00007', 'Balnc', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00008', 'Perry', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00009', 'Gable', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00010', 'Grimes', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00011', 'James', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00012', 'Kathryn', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00013', 'Lara', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00014', 'Michael', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00015', 'Martin', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00016', 'Newberry', '9654223322', 'abc@gmail.com',
          '563321146', 'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00017', 'Balnc', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00018', 'Perry', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00019', 'Gable', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00020', 'Grimes', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00021', 'James', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00022', 'Kathryn', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00023', 'Lara', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00024', 'Michael', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00025', 'Martin', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00026', 'Newberry', '9654223322', 'abc@gmail.com',
          '563321146', 'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00027', 'Balnc', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00028', 'Perry', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00029', 'Gable', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com'),
      OrderInfo('P00030', 'Grimes', '9654223322', 'abc@gmail.com', '563321146',
          'James', '9654223322', 'abc@gmail.com')
    ];
    // dynamic result = getOrder();
    // List<dynamic> items = result as List<dynamic>;

    // List<OrderInfo> orderDetails = [];
    // // FutureBuilder<List<String>>(
    // //     future: getOrder(),
    // //     builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
    // //       List<String> items = snapshot.data!;

    // //       return items;
    // //     });

    // for (var item in items) {
    //   orderDetails.add(OrderInfo(item[0], item[1], item[2], item[3]));
    // }
    return orderDetails;
  }
}
