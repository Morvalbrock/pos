import 'dart:async';
import 'package:mysql1/mysql1.dart';

Future<List<ResultRow>> SelectionQry(String Query) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'agilan',
      db: 'mowvacpn_gst',
      password: '1234'));

  // await conn.query(
  //     'CREATE TABLE users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), email varchar(255), age int)');

  // Results users = await conn.query("SELECT * FROM users;");
  // for (var row in users) {
  //   print('Name: ${row[0]}, Name: ${row[1]} ,email: ${row[2]}, age:${row[3]}');
  // }]
  final results = await conn.query(Query);
  List<ResultRow> resultMap = [];
  for (var row in results) {
    resultMap.add(row);
  }

  await conn.close();
  return resultMap;
}

Future<dynamic> deletequery(String Query) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'agilan',
      db: 'mowvacpn_gst',
      password: '1234'));
  Results rs = await conn.query(Query);

  await conn.close();
  if (rs.affectedRows != 0) {
    return true;
  } else {
    return false;
  }
}

Future<dynamic> updatequery(String Query) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'agilan',
      db: 'mowvacpn_gst',
      password: ''));
  Results rs = await conn.query(Query);

  await conn.close();
  if (rs.affectedRows != 0) {
    return true;
  } else {
    return false;
  }
}

Future<dynamic> insertquery(String Query) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'agilan',
      db: 'mowvacpn_gst',
      password: ''));
  Results rs = await conn.query(Query);

  await conn.close();
  if (rs.affectedRows != 0) {
    return true;
  } else {
    return false;
  }
}
