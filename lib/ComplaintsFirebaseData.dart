import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class MyFirebaseTable extends StatelessWidget
{
  CollectionReference complaints = FirebaseFirestore
      .instance
      .collection('complaintsData');

  late ComplaintsDataSource _complaintsDataSource;
  List<Complaints> complaintsDetailsFromFirebase = <Complaints>[];

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder(stream: complaints.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)
    {
      _complaintsDataSource.buildTableSummaryCellWidget(streamSnapshot);

    }
  }
}




class ComplaintsDataSource extends DataGridSource
{
  ComplaintsDataSource({required List<Complaints> complaintsList})
  {
    dataGridRows  = complaintsList.map<DataGridRow>((e) => DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'No', value: e.No),
          DataGridCell<DateTime>(columnName: 'RegisteredAt', value: e.RegisteredAt),
          DataGridCell<String>(columnName: 'Description', value: e.Description),
          DataGridCell<String>(columnName: 'Criteria', value: e.Criteria),
          DataGridCell<String>(columnName: 'AssignedTo', value: e.AssignedTo),
          DataGridCell<bool>(columnName: 'SolveStatus', value: e.SolveStatus),
          DataGridCell<DateTime>(columnName: 'SolvedAt', value: e.SolvedAt),
        ]
    )
    ).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row)
  {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}

class Complaints
{
  Complaints(this.No, this.RegisteredAt, this.Description, this.Criteria,this.AssignedTo, this.SolveStatus, this.SolvedAt);
  final int No;
  final DateTime RegisteredAt;
  final String Description;
  final String Criteria;
  final String AssignedTo;
  final bool SolveStatus;
  final DateTime SolvedAt;
}



