import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/addunit.dart';
import 'package:pos/edit_unit.dart';
import 'package:pos/view_unit.dart';
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

class Unitpage extends StatefulWidget {
  const Unitpage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Unitpage> {
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
        'SELECT * FROM  tbl_unit  WHERE comp_id = "$comp_id"');
    product.clear();
    for (var item in rs) {
      // print(item['orderID']);
      OrderInfo lst = OrderInfo(
        item['id'],
        item['comp_id'],
        item['u_id'],
        item['u_name'],
        item['u_status'],
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Paginated SfDataGrid',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(236, 133, 36, 1),
            title: Text('Unit Page'),
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
                                    builder: (context) => AddUnit(),
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
                                rowHoverColor: Color.fromRGBO(166, 216, 245, 1),
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

                                    Map<String, dynamic> fetchedData = {
                                      'id': row.getCells()[0].value,
                                      'comp_id': row.getCells()[1].value,
                                      'u_id': row.getCells()[2].value,
                                      'u_name': row.getCells()[3].value,
                                      'u_status': row.getCells()[4].value,
                                      'created_at': row.getCells()[5].value,
                                      'update_at': row.getCells()[6].value,
                                    };

                                    showDialog(
                                        context: context,
                                        builder:
                                            (BuildContext context) =>
                                                AlertDialog(
                                                    title: const Text('Action'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: const Text(
                                                              'Close'))
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
                                                                      View_unit(
                                                                          unitInfo:
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
                                                                      Editing_unit(
                                                                          unitInfo:
                                                                              fetchedData),
                                                                ),
                                                              );
                                                            },
                                                            icon: Icon(
                                                                Icons.edit)),
                                                        IconButton(
                                                            tooltip: 'Delete',
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
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
                                                                    height:
                                                                        100.0,
                                                                    child:
                                                                        Column(
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
                                                                                  dynamic rs = await deletequery('DELETE FROM `tbl_unit` WHERE `id` =' + fetchedData["id"].toString());

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
                                      columnName: 'u_id',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Id',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'u_name',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            ' Name',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'u_status',
                                        label: Container(
                                            padding: EdgeInsets.all(8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Status',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
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
        ));
  }
}

class OrderInfo {
  OrderInfo(
    this.id,
    this.comp_id,
    this.u_id,
    this.u_name,
    this.u_status,
    this.created_at,
    this.update_at,
  );
  final int? id;
  final String? comp_id;

  final String? u_id;
  final String? u_name;

  final String? u_status;

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
        DataGridCell(columnName: 'sz_id', value: dataGridRow.u_id),
        DataGridCell(columnName: 'sz_name', value: dataGridRow.u_name),
        DataGridCell(columnName: 'sz_status', value: dataGridRow.u_status),
        DataGridCell(columnName: 'created_at', value: dataGridRow.created_at),
        DataGridCell(columnName: 'update_at', value: dataGridRow.update_at),
      ]);
    }).toList(growable: false);
  }
}
