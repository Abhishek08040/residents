import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
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
  }

  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
    future: complaints.get(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
    {
      if (snapshot.connectionState == ConnectionState.waiting)
      {
        return const CircularProgressIndicator();
      }

      else if (snapshot.hasData)
        {
          int no = 0;
          String registeredAt;
          String description;
          String criteria;
          String assignedTo;
          bool solveStatus;
          String solvedAt;
          
          var complainRow;
          int itemCount = snapshot.data.docs.length;
          List<Complaints> complaintsList = <Complaints>[];

          for (int i = 0; i < itemCount; i++)
          {
            complainRow = snapshot.data.docs[i].data();

            no = i + 1;
            registeredAt = complainRow['Registered at'];
            description = complainRow['Description'];
            criteria = complainRow['Criteria'];
            assignedTo = complainRow['Assigned to'];
            solveStatus = complainRow['Solve Status'];
            solvedAt = complainRow['Solved at'];

            complaintsList.add(Complaints(
                no,
                registeredAt,
                description,
                criteria,
                assignedTo,
                solveStatus,
                solvedAt,
                ));
          }

          _complaintsDataSource = ComplaintsDataSource(complaintsList : complaintsList);

          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 255, 248),
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              border: Border.all(color: const Color.fromARGB(255, 67, 67, 67)),
            ),
            child: SfDataGrid (
                source: _complaintsDataSource,
                columnWidthMode: ColumnWidthMode.lastColumnFill,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columns: [
                  GridColumn(
                      columnName: 'no',
                      label: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 49, 175, 212),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        alignment: Alignment.center,
                        child: const Text('No', overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.white),),
                      )
                  ),
                  GridColumn(
                      columnName: 'registeredAt',
                      label: Container(
                        color: const Color.fromARGB(255, 49, 175, 212),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text('Registered at', overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.white),),
                      )
                  ),
                  GridColumn(
                      columnName: 'description',
                      label: Container(
                        color: const Color.fromARGB(255, 49, 175, 212),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text('Description', overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.white),),
                      )
                  ),
                  GridColumn(
                      columnName: 'criteria',
                      label: Container(
                        color: const Color.fromARGB(255, 49, 175, 212),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text('Criteria', overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.white),),
                      )
                  ),
                  GridColumn(
                      columnName: 'assignedTo',
                      label: Container(
                        color: const Color.fromARGB(255, 49, 175, 212),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text('Assigned to', overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.white),),
                      )
                  ),
                  GridColumn(
                      columnName: 'solveStatus',
                      label: Container(
                        color: const Color.fromARGB(255, 49, 175, 212),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text('Status', overflow: TextOverflow.visible,
                            style: TextStyle(color: Colors.white)),
                      )
                  ),
                  GridColumn(
                      columnName: 'solvedAt',
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
            ),
          );
        }

      else if (!snapshot.hasData)
        {
          return Container(
              child: Text("No Complaints!!",
                style: GoogleFonts.urbanist(textStyle: TextStyle(
                  fontSize: 20,
                )),
              )
          );
        }

      return Container(
          child: Text("An Error has occurred ..",
            style: GoogleFonts.urbanist(textStyle: TextStyle(
              fontSize: 20,
            )),
          )
      );

    }

    );
  }
}

class ComplaintsDataSource extends DataGridSource
{
  ComplaintsDataSource({required List<Complaints> complaintsList})
  {
    dataGridRows  = complaintsList.map<DataGridRow>((e) => DataGridRow
      (
        cells: [
          DataGridCell<int>(columnName: 'no', value: e.no),
          DataGridCell<String>(columnName: 'registeredAt', value: e.registeredAt),
          DataGridCell<String>(columnName: 'description', value: e.description),
          DataGridCell<String>(columnName: 'criteria', value: e.criteria),
          DataGridCell<String>(columnName: 'assignedTo', value: e.assignedTo),
          DataGridCell<bool>(columnName: 'solveStatus', value: e.solveStatus),
          DataGridCell<String>(columnName: 'solvedAt', value: e.solvedAt),
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
    bool statusValue = row.getCells()[5].value;
    Icon statusIcon = statusValue ?
          Icon(Icons.task_alt, color: Colors.green,)
        : Icon(Icons.error_outline_outlined, color: Colors.red,);

    String solvedAtValue = row.getCells()[6].value;
    Color solvedAtColor = solvedAtValue=="Unresolved" ?
          Colors.red
        : Colors.green;

    return DataGridRowAdapter
      (
        cells: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(row.getCells()[0].value.toString()),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(row.getCells()[1].value.toString()),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(row.getCells()[2].value.toString()),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(row.getCells()[3].value.toString()),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(row.getCells()[4].value.toString()),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: statusIcon,
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(row.getCells()[6].value.toString(), style: TextStyle(color: solvedAtColor),),
          ),
        ]
    );
  }
}

class Complaints
{
  Complaints(this.no, this.registeredAt, this.description, this.criteria,this.assignedTo, this.solveStatus, this.solvedAt);
  final int no;
  final String registeredAt;
  final String description;
  final String criteria;
  final String assignedTo;
  final bool solveStatus;
  final String solvedAt;
}
