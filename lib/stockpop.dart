import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockInfo {
  StockInfo(
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
}

class StockDataSource extends DataGridSource {
  StockDataSource(List<StockInfo> stock) {
    _Stocks = stock;
    buildDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];
  List<StockInfo> _Stocks = [];

  void buildDataGridRows() {
    dataGridRows = _Stocks.map<DataGridRow>((StockInfo stock) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: stock.id),
        DataGridCell<String>(columnName: 'comp_id', value: stock.comp_id),
        DataGridCell<String>(columnName: 'stk_id', value: stock.stk_id),
        DataGridCell<String>(columnName: 'pur_id', value: stock.pur_id),
        DataGridCell<String>(columnName: 'sup_id', value: stock.sup_id),
        DataGridCell<String>(columnName: 'p_name', value: stock.p_name),
        DataGridCell<String>(columnName: 'p_id', value: stock.p_id),
        DataGridCell<String>(columnName: 'hsn', value: stock.hsn),
        DataGridCell<String>(columnName: 'inward', value: stock.inward),
        DataGridCell<String>(columnName: 'outward', value: stock.outward),
        DataGridCell<String>(columnName: 'balance', value: stock.balance),
        DataGridCell<String>(columnName: 'u_name', value: stock.u_name),
        DataGridCell<String>(columnName: 'price', value: stock.price),
        DataGridCell<String>(columnName: 'sup_name', value: stock.sup_name),
        DataGridCell<String>(columnName: 'inv_no', value: stock.inv_no),
        DataGridCell<DateTime>(columnName: 'inv_date', value: stock.inv_date),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell dataGridCell) {
        return Container(
          alignment: dataGridCell.columnName == 'id'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.all(16.0),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
