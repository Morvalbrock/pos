import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/addSupplier.dart';
import 'package:pos/edit_product.dart';
import 'package:pos/edit_supplier.dart';
import 'package:pos/view_supplier.dart';
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
final List<inviceInfo> product = [];
List<inviceInfo> paginatedDataSource = [];
final int rowsPerPage = 10;

late OrderInfoDataSource _productInfoDataSource;

final GlobalKey<SfDataGridState> _keys = GlobalKey<SfDataGridState>();

class InviceReport extends StatefulWidget {
  const InviceReport({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<InviceReport> {
  static const double dataPagerHeight = 60;

  @override
  void initState() {
    super.initState();
    getOrder();

    EasyLoading.show(status: 'loading...');
    _productInfoDataSource = OrderInfoDataSource();
    Timer(const Duration(seconds: 5), () {
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
        'SELECT * FROM  tbl_invoice WHERE comp_id = "$comp_id" ');
    product.clear();
    for (var item in rs) {
      // print(item['orderID']);
      inviceInfo lst = inviceInfo(
        item['id'],
        item['comp_id'],
        item['inv_no'],
        item['inv_date'],
        item['cus_id'],
        item['disc_per'],
        item['disc_amt'],
        item['card'],
        item['cheque'],
        item['wallet'],
        item['credit_note'],
        item['unpaid_amt'],
        item['cash'],
        item['og_total'],
        item['disc_total'],
        item['created_at'],
        item['updated_at'],
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
            backgroundColor: const Color.fromRGBO(236, 133, 36, 1),
            title: const Text('Invicereport Page'),
          ),
          drawer: Customdrawer(context),
          body: LayoutBuilder(builder: (context, constraint) {
            if (product.isEmpty) {
              return const SizedBox();
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
                              color: const Color.fromRGBO(72, 117, 146, 1),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.62,
                        child: SizedBox(
                            height: constraint.maxHeight - dataPagerHeight,
                            width: constraint.maxWidth,
                            child: SfDataGridTheme(
                              data: SfDataGridThemeData(
                                headerColor:
                                    const Color.fromRGBO(21, 83, 120, 1),
                                rowHoverColor:
                                    const Color.fromRGBO(166, 216, 245, 1),
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
                                    // print(row.getCells()[0].value);
                                    // this.id,
                                    // this.comp_id,
                                    // this.sup_id,
                                    // this.sup_name,
                                    // this.sup_address,
                                    // this.sup_mobile,
                                    // this.sup_email,
                                    // this.sup_gst,
                                    // this.sup_details,
                                    // this.status,
                                    // this.created_at,
                                    // this.update_at,
                                    Map<String, dynamic> fetchedData = {
                                      'id': row.getCells()[0].value,
                                      'comp_id': row.getCells()[1].value,
                                      'sup_id': row.getCells()[2].value,
                                      'sup_name': row.getCells()[3].value,
                                      'sup_address': row.getCells()[4].value,
                                      'sup_mobile': row.getCells()[5].value,
                                      'sup_email': row.getCells()[6].value,
                                      'sup_gst': row.getCells()[7].value,
                                      'sup_details': row.getCells()[8].value,
                                      'status': row.getCells()[9].value,
                                      'created_at': row.getCells()[10].value,
                                      'update_at': row.getCells()[11].value,
                                    };
                                  },
                                  columnWidthMode: ColumnWidthMode.fill,
                                  allowEditing: true,
                                  headerGridLinesVisibility:
                                      GridLinesVisibility.both,
                                  columns: <GridColumn>[
                                    // this.id,
                                    // this.comp_id,
                                    // this.inv_no,
                                    // this.inv_date,
                                    // this.cus_id,
                                    // this.disc_per,
                                    // this.disc_amt,
                                    // this.card,
                                    // this.cheque,
                                    // this.wallet,
                                    // this.credit_note,
                                    // this.unpaid_amt,
                                    // this.cash,
                                    // this.og_total,
                                    // this.disc_total,
                                    // this.created_at,
                                    // this.updated_at,
                                    GridColumn(
                                      columnName: 'id',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Id',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'comp_id',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                      columnName: 'inv_no',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: const Text(
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
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Invice Date',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'cus_id',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                        columnName: 'disc_per',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                      columnName: 'disc_amt',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Discount Amt',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: '	card',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                        columnName: '	cheque',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                        columnName: 'wallet',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                        columnName: 'credit_note',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                        columnName: 'unpaid_amt',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                        columnName: 'cash',
                                        visible: false,
                                        label: const Text('')),

                                    GridColumn(
                                      columnName: 'og_total',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Total',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),

                                    GridColumn(
                                      columnName: 'disc_total',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Discount Total',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'created_at',
                                        visible: false,
                                        label: const Text('')),
                                    GridColumn(
                                        columnName: 'updated_at',
                                        visible: false,
                                        label: const Text('')),

                                    GridColumn(
                                      columnName: 'button',
                                      label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Details ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
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
                          selectedItemColor:
                              const Color.fromRGBO(21, 83, 120, 1)),
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

class inviceInfo {
  inviceInfo(
    this.id,
    this.comp_id,
    this.inv_no,
    this.inv_date,
    this.cus_id,
    this.disc_per,
    this.disc_amt,
    this.card,
    this.cheque,
    this.wallet,
    this.credit_note,
    this.unpaid_amt,
    this.cash,
    this.og_total,
    this.disc_total,
    this.created_at,
    this.updated_at,
  );
  final int? id;
  final String? comp_id;
  final String? inv_no;
  final DateTime? inv_date;
  final String? cus_id;
  final String? disc_per;
  final String? disc_amt;

  final String? card;
  final String? cheque;
  final String? wallet;

  final String? credit_note;
  final String? unpaid_amt;

  final String? cash;
  final String? og_total;
  final String? disc_total;

  final DateTime? created_at;
  final DateTime? updated_at;
}

class OrderInfoDataSource extends DataGridSource {
  OrderInfoDataSource() {
    paginatedDataSource = List.from(product.toList(growable: false));
    buildPaginatedDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows.isEmpty ? [] : dataGridRows;

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
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          child: dataGridCell.columnName == 'button'
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('Invice'),
                  );
                })
              : Text(dataGridCell.value.toString()));
    }).toList());
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = paginatedDataSource.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'id', value: dataGridRow.id),
        DataGridCell(columnName: 'comp_id', value: dataGridRow.comp_id),
        DataGridCell(columnName: 'inv_no', value: dataGridRow.inv_no),
        DataGridCell(columnName: 'inv_date', value: dataGridRow.inv_date),
        DataGridCell(columnName: 'cus_id', value: dataGridRow.cus_id),
        DataGridCell(columnName: 'disc_per', value: dataGridRow.disc_per),
        DataGridCell(columnName: 'disc_amt', value: dataGridRow.disc_amt),
        DataGridCell(columnName: 'card', value: dataGridRow.card),
        DataGridCell(columnName: 'cheque', value: dataGridRow.cheque),
        DataGridCell(columnName: 'wallet', value: dataGridRow.wallet),
        DataGridCell(columnName: 'credit_note', value: dataGridRow.credit_note),
        DataGridCell(columnName: 'unpaid_amt', value: dataGridRow.unpaid_amt),
        DataGridCell(columnName: 'cash', value: dataGridRow.cash),
        DataGridCell(columnName: 'og_total', value: dataGridRow.og_total),
        DataGridCell(columnName: 'disc_total', value: dataGridRow.disc_total),
        DataGridCell(columnName: 'created_at', value: dataGridRow.created_at),
        DataGridCell(columnName: 'update_at', value: dataGridRow.updated_at),
        const DataGridCell<Widget>(columnName: 'button', value: null),
      ]);
    }).toList(growable: false);
  }
}
