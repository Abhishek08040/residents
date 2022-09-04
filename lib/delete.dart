import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_datagrid_loadmore/repositories/employee_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SfDataGridLoadMoreApp());
}

class SfDataGridLoadMoreApp extends StatelessWidget {
  final EmployeeDataGridSource employeeDataGridSource =
  EmployeeDataGridSource();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('DataGrid'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: employeeDataGridSource.getStream(),
            builder: (context, snapshot) {
              employeeDataGridSource.buildStream(snapshot);
              return SfDataGrid(
                source: employeeDataGridSource,
                columnWidthMode: ColumnWidthMode.fill,
                columns: [
                  GridNumericColumn(mappingName: 'employeeID', headerText: 'ID'),
                  GridTextColumn(mappingName: 'employeeName', headerText: 'Name'),
                  GridTextColumn(mappingName: 'designation', headerText: 'Role'),
                  GridNumericColumn(mappingName: 'salary', headerText: 'Salary'),
                ],
              );
            }
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  Employee(this.employeeID, this.employeeName, this.designation,
      this.salary,
      {this.reference});

  double employeeID;

  String employeeName;

  String designation;

  double salary;

  DocumentReference reference;

  factory Employee.fromSnapshot(DocumentSnapshot snapshot) {
    Employee newEmployee = Employee.fromJson(snapshot.data());
    newEmployee.reference = snapshot.reference;
    return newEmployee;
  }

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _employeeFromJson(json);

  Map<String, dynamic> toJson() => _employeeToJson(this);

  @override
  String toString() => 'employeeName ${employeeName}';
}

Employee _employeeFromJson(Map<String, dynamic> data) {
  return Employee(
    data['employeeID'],
    data['employeeName'],
    data['designation'],
    data['salary'],
  );
}

Map<String, dynamic> _employeeToJson(Employee instance) {
  return {
    'employeeID' : instance.employeeID,
    'employeeName': instance.employeeName,
    'designation': instance.designation,
    'salary': instance.salary,
  };
}
