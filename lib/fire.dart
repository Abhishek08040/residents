import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MyFirebaseTable extends StatefulWidget
{
  const MyFirebaseTable({Key? key}) : super(key: key);

  @override
  State<MyFirebaseTable> createState() => _MyFirebaseTableState();
}

class _MyFirebaseTableState extends State<MyFirebaseTable>
{
  
    CollectionReference complaints = FirebaseFirestore
        .instance
        .collection('complaintsData');

    late ComplaintsDataSource _complaintsDataSource;
    List<Complaints> complaintsDetailsFromFirebase = <Complaints>[];

  @override

  void initState()
  {
    super.initState();
    complaintsDetailsFromFirebase = getComplaintsData();
    _complaintsDataSource = ComplaintsDataSource(complaintsList : complaintsDetailsFromFirebase);
  }

  Widget build(BuildContext context)
  {
      return SfDataGrid(
          source: _complaintsDataSource,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columns: [
            GridColumn(
                columnName: 'No',
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 175, 212),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18.0),),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  alignment: Alignment.center,
                  child: Text('No', overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.white),),
                )
            ),
            GridColumn(
                columnName: 'RegisteredAt',
                label: Container(
                  color: const Color.fromARGB(255, 49, 175, 212),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Registered at', overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.white),),
                )
            ),
            GridColumn(
                columnName: 'Description',
                label: Container(
                  color: const Color.fromARGB(255, 49, 175, 212),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Description', overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.white),),
                )
            ),
            GridColumn(
                columnName: 'Criteria',
                label: Container(
                  color: const Color.fromARGB(255, 49, 175, 212),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Criteria', overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.white),),
                )
            ),
            GridColumn(
                columnName: 'AssignedTo',
                label: Container(
                  color: const Color.fromARGB(255, 49, 175, 212),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Assigned to', overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.white),),
                )
            ),
            GridColumn(
                columnName: 'SolveStatus',
                label: Container(
                  color: const Color.fromARGB(255, 49, 175, 212),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Status', overflow: TextOverflow.visible,
                      style: TextStyle(color: Colors.white)),
                )
            ),
            GridColumn(
                columnName: 'SolvedAt',
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 175, 212),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Solved at', overflow: TextOverflow.visible,
                      style: TextStyle(color: Colors.white)),
                )
            ),
          ]
      );
  }




  List<Complaints> getComplaintsData()
  {
    return [
      Complaints(1, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),
      Complaints(2, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),
      Complaints(3, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),
      Complaints(4, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),
      Complaints(5, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),
      Complaints(6, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),
      Complaints(7, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),
      Complaints(8, DateTime.parse('1969-07-20 20:18:04Z'), "Description", "Criteria", "Mechanical", true, DateTime.parse('1969-07-20 20:18:04Z')),

      ];
  }

  List<Complaints> loadComplaintData()
  {
    complaintsDetailsFromFirebase = <Complaints>[];

        StreamBuilder(
        stream: complaints.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)
        {
          if (streamSnapshot.hasData) {
            int itemCount = streamSnapshot.data!.docs.length;
            complaintsDetailsFromFirebase = <Complaints>[];

            DocumentSnapshot documentSnapshot;
            int No;
            DateTime RegisteredAt;
            String Description;
            String Criteria;
            String AssignedTo;
            bool SolveStatus;
            DateTime SolvedAt;

            for (int i = 0; i < itemCount; i++) {
              documentSnapshot = streamSnapshot.data!.docs[i];

              No = i + 1;
              //RegisteredAt = DateTime.fromMicrosecondsSinceEpoch(documentSnapshot['Registered at']*1000);
              Description = documentSnapshot['Description'];
              Criteria = documentSnapshot['Criteria'];
              AssignedTo = documentSnapshot['Assigned to'];
              SolveStatus = documentSnapshot['Solve Status'];
              //SolvedAt = DateTime.fromMicrosecondsSinceEpoch(documentSnapshot['Solved at']*1000);

              complaintsDetailsFromFirebase.add(
                  Complaints
                    (
                    No,
                    DateTime.parse('1969-07-20 20:18:04Z'),
                    Description,
                    Criteria,
                    AssignedTo,
                    SolveStatus,
                    DateTime.parse('1969-07-20 20:18:04Z'),
                  ));
            }
          }
          throw new NullThrownError();
        }
        );

     return complaintsDetailsFromFirebase;
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
