import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ComplaintsHistoryTable extends StatefulWidget
{
  const ComplaintsHistoryTable({Key? key}) : super(key: key);

  @override
  State<ComplaintsHistoryTable> createState() => _ComplaintsHistoryTableState();
}

class _ComplaintsHistoryTableState extends State<ComplaintsHistoryTable>
{

  CollectionReference complaints = FirebaseFirestore
      .instance
      .collection('complaintsData');

  late ComplaintsDataSource _complaintsDataSource;

  @override

  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {

    return Hero(
      tag: 'complaints_details',
      child: FutureBuilder(
      future: complaints.where("Solve Status",isEqualTo: true).get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
      {

        if (snapshot.connectionState == ConnectionState.waiting)
        {
          return Scaffold(
              appBar: AppBar(backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                elevation: 0.0,),
              body: Center(child: CircularProgressIndicator())
          );
        }


        else if (!snapshot.hasData || snapshot.data.docs.length < 1)
        {
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              elevation: 0.0,),
            body: DefaultTextStyle(
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  color: Color(0xff403b58)),
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
              child: Center(
                child: Text("No Complaints!",
                ),
              ),
            ),
          );
        }


        else if (snapshot.hasData && snapshot.connectionState == ConnectionState.done)
          {
            int no;
            String registeredAt;
            String title;
            String description;
            String criteria;
            String assignedTo;
            String solvedAt;
            int ratings;
            String comments = "";
            String filesAttached = "";

            var complainRow;

            int itemCount = snapshot.data.docs.length;
            List<Complaints> complaintsList = <Complaints>[];

            for (int i = 0; i < itemCount; i++)
            {
              complainRow = snapshot.data.docs[i].data();

              no = i + 1;
              registeredAt = complainRow['Registered at'];
              title = complainRow['Title'];
              description = complainRow['Description'];
              criteria = complainRow['Criteria'];
              assignedTo = complainRow['Assigned to'];
              solvedAt = complainRow['Solved at'];
              ratings = complainRow['Ratings'];

              complaintsList.add(Complaints(
                  no,
                  registeredAt,
                  title,
                  description,
                  criteria,
                  assignedTo,
                  solvedAt,
                  ratings,
                  comments,
                  filesAttached,
                  )
              );
            }

            _complaintsDataSource = ComplaintsDataSource(complaintsList : complaintsList);

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                elevation: 0.0,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    child: Text("Complaints \nHistory",
                      style: GoogleFonts.poppins(textStyle: TextStyle(
                          color: Color(0xff403b58)),
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  Expanded(
                    child: SfDataGrid(
                        source: _complaintsDataSource,
                        defaultColumnWidth: 120,
                        headerGridLinesVisibility: GridLinesVisibility.horizontal,
                        columns: [
                          GridColumn(
                              columnName: 'no',
                              width: 60,
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                alignment: Alignment.centerRight,
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
                              columnName: 'title',
                              width: 150,
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Complaint Title', overflow: TextOverflow.visible,
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
                              columnName: 'ratings',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.centerLeft,
                                child: Text('Ratings', overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.white)),
                              )
                          ),
                          GridColumn(
                              columnName: 'solvedAt',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Solved at', overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.white)),
                              )
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            );
          }


        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0.0,),
          body: DefaultTextStyle(
            style: GoogleFonts.poppins(textStyle: TextStyle(
                color: Color(0xff403b58)),
              fontSize: 32,
              fontWeight: FontWeight.w300,
            ),
            child: Center(
              child: Text("Error loading\ncomplaints!",
              ),
            ),
          ),
        );




        }
      ),
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
          DataGridCell<String>(columnName: 'title', value: e.title),
          DataGridCell<String>(columnName: 'criteria', value: e.criteria),
          DataGridCell<String>(columnName: 'assignedTo', value: e.assignedTo),
          DataGridCell<int>(columnName: 'ratings', value: e.afterSolvedRatings),
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
    int ratingStars = row.getCells()[5].value;

    Row starsRow = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0; i<ratingStars; i++) Icon(Icons.star, color: Colors.amber, size: 16,),
      ],
    );


    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell)
        {
          return Container(
            alignment: (dataGridCell.columnName == 'no' || dataGridCell.columnName == 'ratings'
                              || dataGridCell.columnName == "title")
                ? Alignment.centerLeft
                : Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: (dataGridCell.columnName == 'ratings')
              ? starsRow
              : Text(dataGridCell.value.toString()),
          );
        }).toList()
    );
  }
}

class Complaints
{
  Complaints(this.no, this.registeredAt, this.title, this.description, this.criteria,
      this.assignedTo, this.solvedAt, this.afterSolvedRatings, this.afterSolvedComments, this.filesAttached);

  final int no;
  final String registeredAt;
  final String title;
  final String description;
  final String criteria;
  final String assignedTo;
  final String solvedAt;
  final int afterSolvedRatings;
  final String afterSolvedComments;
  final String filesAttached;
}
