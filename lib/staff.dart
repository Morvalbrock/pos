import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/addStaff.dart';
import 'package:pos/edit_staff.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

// import 'package:syncfusion_flutter_datagrid_export/export.dart';
// Local import
import 'main.dart';
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

class Staffpage extends StatefulWidget {
  const Staffpage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Staffpage> {
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
        'SELECT * FROM  users WHERE company_id = "$comp_id"');
    product.clear();
    for (var item in rs) {
      // print(item['orderID']);
      OrderInfo lst = OrderInfo(
          item['id'],
          item['company_id'],
          item['company_name'],
          item['owner_name'],
          item['mobile_no'],
          item['email'],
          item['username'],
          item['password'],
          item['gst_no'],
          item['address'].toString(),
          item['state'],
          item['website'],
          item['type'],
          item['bank_name'],
          item['branch_name'],
          item['ac_no'],
          item['ifsc_code'],
          item['privileges'].toString(),
          item['remember_token'],
          item['last_login'],
          item['email_verified_at'],
          item['created_at'],
          item['updated_at']);
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
            title: Text('Staff Page'),
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
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => new AddStaff(),
                                    ),
                                  );
                                },
                                child: const Center(
                                    child: Text(
                                  'ADD Staff',
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
                                  onCellTap: (details) {
                                    int selectedRowIndex =
                                        details.rowColumnIndex.rowIndex - 1;
                                    var row = _productInfoDataSource
                                        .effectiveRows
                                        .elementAt(selectedRowIndex);
                                    print(row.getCells()[0].value);
                                    //                                     this.id,
                                    // this.company_id,
                                    // this.company_name,
                                    // this.owner_name,
                                    // this.mobile_no,
                                    // this.email,
                                    // this.username,
                                    // this.password,
                                    // this.gst_no,
                                    // this.address,
                                    // this.state,
                                    // this.website,
                                    // this.type,
                                    // this.bank_name,
                                    // this.branch_name,
                                    // this.ac_no,
                                    // this.ifsc_code,
                                    // this.privileges,
                                    // this.remember_token,
                                    // this.last_login,
                                    // this.email_verified_at,
                                    // this.created_at,
                                    // this.updated_at,
                                    Map<String, dynamic> fetchedData = {
                                      'id': row.getCells()[0].value,
                                      'company_id': row.getCells()[1].value,
                                      'company_name': row.getCells()[2].value,
                                      'owner_name': row.getCells()[3].value,
                                      'mobile_no': row.getCells()[4].value,
                                      'email': row.getCells()[5].value,
                                      'username': row.getCells()[6].value,
                                      'password': row.getCells()[7].value,
                                      'gst_no': row.getCells()[8].value,
                                      'address': row.getCells()[9].value,
                                      'state': row.getCells()[10].value,
                                      'website': row.getCells()[11].value,
                                      'bank_name': row.getCells()[12].value,
                                      'branch_name': row.getCells()[13].value,
                                      'ac_no': row.getCells()[14].value,
                                      'ifsc_code': row.getCells()[15].value,
                                      'privileges': row.getCells()[17].value,
                                      'remember_token':
                                          row.getCells()[18].value,
                                      'last_login': row.getCells()[19].value,
                                      'email_verified_at':
                                          row.getCells()[20].value,
                                      'created_at': row.getCells()[21].value,
                                      'updated_at': row.getCells()[22].value,
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
                                                        tooltip: 'Edit',
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Editing_staff(
                                                                      staffInfo:
                                                                          fetchedData),
                                                            ),
                                                          );
                                                        },
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
                                        columnName: 'Id',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'company_id',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'company_name',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                      columnName: 'owner_name',
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
                                      columnName: 'email',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Email',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                      columnName: 'mobile_no',
                                      // visible: false,
                                      allowEditing: true,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Mobile No',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    GridColumn(
                                        columnName: 'username',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'password',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'gst_no',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'address',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'state',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'website',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'type',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'bank_name',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'branch_name',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'ac_no',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'ifsc_code',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'privileges',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'remember_token',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'last_login',
                                        visible: false,
                                        label: Text('')),
                                    GridColumn(
                                        columnName: 'email_verified_at',
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
                        visibleItemsCount: 5,
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
    this.company_id,
    this.company_name,
    this.owner_name,
    this.mobile_no,
    this.email,
    this.username,
    this.password,
    this.gst_no,
    this.address,
    this.state,
    this.website,
    this.type,
    this.bank_name,
    this.branch_name,
    this.ac_no,
    this.ifsc_code,
    this.privileges,
    this.remember_token,
    this.last_login,
    this.email_verified_at,
    this.created_at,
    this.updated_at,
  );
  final int? id;
  final String? company_id;
  final String? company_name;
  final String? owner_name;
  final String? mobile_no;
  final String? email;
  final String? username;

  final String? password;
  final String? gst_no;
  final String? address;
  final int? state;
  final String? website;
  final String? type;
  final String? bank_name;
  final String? branch_name;
  final String? ac_no;
  final String? ifsc_code;
  final String? privileges;
  final String? remember_token;
  final DateTime? last_login;
  final DateTime? email_verified_at;
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
        DataGridCell(columnName: 'company_id', value: dataGridRow.company_id),
        DataGridCell(
            columnName: 'company_name', value: dataGridRow.company_name),
        DataGridCell(columnName: 'owner_name', value: dataGridRow.owner_name),
        DataGridCell(columnName: 'email', value: dataGridRow.email),
        DataGridCell(columnName: 'mobile_no', value: dataGridRow.mobile_no),
        DataGridCell(columnName: 'username', value: dataGridRow.username),
        DataGridCell(columnName: 'password', value: dataGridRow.password),
        DataGridCell(columnName: 'gst_no', value: dataGridRow.gst_no),
        DataGridCell(columnName: 'address', value: dataGridRow.address),
        DataGridCell(columnName: 'state', value: dataGridRow.state),
        DataGridCell(columnName: 'website', value: dataGridRow.website),
        DataGridCell(columnName: 'type', value: dataGridRow.type),
        DataGridCell(columnName: 'bank_name', value: dataGridRow.bank_name),
        DataGridCell(columnName: 'branch_name', value: dataGridRow.branch_name),
        DataGridCell(columnName: 'ac_no', value: dataGridRow.ac_no),
        DataGridCell(columnName: 'ifsc_code', value: dataGridRow.ifsc_code),
        DataGridCell(columnName: 'privileges', value: dataGridRow.privileges),
        DataGridCell(
            columnName: 'remember_token', value: dataGridRow.remember_token),
        DataGridCell(columnName: 'last_login', value: dataGridRow.last_login),
        DataGridCell(
            columnName: 'email_verified_at',
            value: dataGridRow.email_verified_at),
        DataGridCell(columnName: 'created_at', value: dataGridRow.created_at),
        DataGridCell(columnName: 'updated_at', value: dataGridRow.updated_at),
      ]);
    }).toList(growable: false);
  }
}
