import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/account.dart';
import 'package:pos/custom.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductInfo {
  ProductInfo(
    this.id,
    this.comp_id,
    this.stk_id,
    this.pur_id,
    this.sup_id,
    this.p_name,
    this.p_id,
    this.hsn,
    this.inward,
    this.outward,
    this.balance,
    this.u_name,
    this.price,
    this.sup_name,
    this.inv_no,
    this.inv_date,
    this.serial_no,
    this.disc_no,
    // this.disc,
    this.disc_amount_no,
    this.amount_no,
    this.total_no,
  );

  final int id;
  final String comp_id;
  final String stk_id;
  final String pur_id;
  final String sup_id;
  final String p_name;
  final String p_id;
  final String hsn;
  final String inward;
  final String outward;
  final String balance;
  final String u_name;
  final String price;
  final String sup_name;
  final String inv_no;
  final DateTime inv_date;
  final String serial_no;
  final String disc_no;
  // final String disc;
  final String disc_amount_no;

  final String amount_no;
  final String total_no;
}

// class ProductDataSource extends DataGridSource {
//   ProductDataSource(List<ProductInfo> product);

//   StockDataSource(List<ProductInfo> product) {
//     _productdetails = product;
//     buildDataGridRows();
//   }
class ProductDataSource extends DataGridSource {
  ProductDataSource(List<ProductInfo> product) {
    _productdetails = product;
    buildDataGridRows();
  }

  void buildDataGridRows() {
    // late int i = 0;
    Map<String, dynamic> dynamicVariables = {};
    dataGridRows = _productdetails.map<DataGridRow>((ProductInfo product) {
      String i = product.serial_no;
      String txtqty = "txtqty$i";
      dynamic value = "${i}";
      dynamicVariables[txtqty] = value;

      String data = product.disc_no;
      String txtdisc = 'txtdisc$data';
      dynamic values = "${data}";
      dynamicVariables[txtdisc] = values;

      String datas = product.disc_no;
      String txtdisc_per = 'txtdisc_per$datas';
      dynamic values_per = "${datas}";
      dynamicVariables[txtdisc_per] = values_per;

      String datass = product.amount_no;
      String txtamount = 'txtamount$datass';
      dynamic values_amount = "${datas}";
      dynamicVariables[txtamount] = values_amount;

      String datasss = product.total_no;
      String txt_total = 'txt_total$datasss';
      dynamic values_total = "${datas}";
      dynamicVariables[txt_total] = values_total;

      return DataGridRow(cells: [
        DataGridCell<int>(
          columnName: 'id',
          value: product.id,
        ),
        DataGridCell<String>(columnName: 'comp_id', value: product.comp_id),
        DataGridCell<String>(columnName: 'stk_id', value: product.stk_id),
        DataGridCell<String>(columnName: 'pur_id', value: product.pur_id),
        DataGridCell<String>(columnName: 'sup_id', value: product.sup_id),
        DataGridCell<String>(columnName: 'p_name', value: product.p_name),
        DataGridCell<String>(columnName: 'p_id', value: product.p_id),
        DataGridCell<String>(columnName: 'hsn', value: product.hsn),
        DataGridCell<String>(columnName: 'inward', value: product.inward),
        DataGridCell<String>(columnName: 'outward', value: product.outward),
        DataGridCell<String>(columnName: 'balance', value: product.balance),
        DataGridCell<String>(columnName: 'u_name', value: product.u_name),
        DataGridCell<String>(columnName: 'price', value: product.price),
        DataGridCell<String>(columnName: 'sup_name', value: product.sup_name),
        DataGridCell<String>(columnName: 'inv_no', value: product.inv_no),
        DataGridCell<DateTime>(columnName: 'inv_date', value: product.inv_date),
        const DataGridCell<String>(columnName: 'qty', value: null),
        DataGridCell<String>(
            columnName: 'txtqty', value: dynamicVariables[txtqty]),
        const DataGridCell<String>(columnName: 'amount', value: null),
        DataGridCell<String>(
            columnName: 'txtamount', value: dynamicVariables[txtamount]),
        const DataGridCell<String>(columnName: 'disc', value: null),
        DataGridCell<String>(
            columnName: 'txtdisc', value: dynamicVariables[txtdisc]),
        const DataGridCell<String>(columnName: 'disc_amount', value: null),
        DataGridCell<String>(
            columnName: 'txtdisc_per', value: dynamicVariables[txtdisc_per]),
        const DataGridCell<String>(columnName: 'total', value: null),
        DataGridCell<String>(
            columnName: 'txt', value: dynamicVariables[txt_total]),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];
  List<ProductInfo> _productdetails = [];
  @override
  List<DataGridRow> get rows => dataGridRows.isEmpty ? [] : dataGridRows;
  // final DataGridController _dataGridController = DataGridController();
  final List<TextEditingController> _controllertextfield =
      List.generate(6, (i) => TextEditingController());

  // List<ProductInfo> getAllRowData() {
  //   final selectedRows = _dataGridController.selectedRows;
  //   final List<ProductInfo> allData = selectedRows.map((gridRow) {
  //     final ProductInfo data = gridRow as ProductInfo;
  //     return data;
  //   }).toList();

  //   return allData;
  // }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell dataGridCell) {
        if (dataGridCell.columnName == 'qty') {
          print(dataGridCell.value.toString());
          return Container(
            alignment: Alignment.center,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: SalesTextfield('qty ', 100, _controllertextfield, '0',
                    dataGridCell.value.toString()),
              );
            }),
          );
        } else if (dataGridCell.columnName == 'amount') {
          return Container(
            alignment: Alignment.center,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: SalesTextfield('amount ', 100, _controllertextfield, '0',
                    dataGridCell.value.toString()),
              );
            }),
          );
        } else if (dataGridCell.columnName == 'disc') {
          return Container(
            alignment: Alignment.center,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: SalesTextfield('disc ', 100, _controllertextfield, '0',
                    dataGridCell.value.toString()),
              );
            }),
          );
        } else if (dataGridCell.columnName == 'disc_amount') {
          return Container(
            alignment: Alignment.center,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: SalesTextfield('disc_amount ', 100, _controllertextfield,
                    '0', dataGridCell.value.toString()),
              );
            }),
          );
        } else if (dataGridCell.columnName == 'total') {
          return Container(
            alignment: Alignment.center,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: SalesTextfield('total ', 100, _controllertextfield, '0',
                    dataGridCell.value.toString()),
              );
            }),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text(
              dataGridCell.value.toString(),
            ),
          );
        }
      }).toList(),
    );
  }
}
