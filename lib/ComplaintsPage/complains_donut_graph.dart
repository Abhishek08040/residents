import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintsDonutGraph extends StatefulWidget {
  const ComplaintsDonutGraph({Key? key}) : super(key: key);

  @override
  State<ComplaintsDonutGraph> createState() => _ComplaintsDonutGraphState();
}

class _ComplaintsDonutGraphState extends State<ComplaintsDonutGraph>
{
  late TooltipBehavior _tooltipBehavior;

  CollectionReference complaints = FirebaseFirestore
      .instance
      .collection('complaintsData');

  @override
  void initState()
  {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      future: complaints.get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
      {
        if (snapshot.connectionState == ConnectionState.waiting ||
          snapshot.connectionState == ConnectionState.none)
        {
          return const Center(child: CircularProgressIndicator());
        }

        else if(!snapshot.hasData || snapshot.data.docs.length < 1)
          {
            return DefaultTextStyle(
              style: GoogleFonts.poppins(textStyle: const TextStyle(
                  color: Color(0xff403b58)),
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
              child: const Center(
                child: Text("No Complaints Filed!!",
                ),
              ),
            );
          }

        else if (snapshot.hasData && snapshot.connectionState == ConnectionState.done)
        {
          int itemCount = snapshot.data.docs.length;
          Map complaintsByCriteria = {};
          String currentCriteria;

          for (int i = 0; i < itemCount; i++)
          {
            currentCriteria = snapshot.data.docs[i].data()['Criteria'];

            if (!complaintsByCriteria.containsKey(currentCriteria))
            {
              complaintsByCriteria[currentCriteria] = 1;
            }
            else
            {
              ++complaintsByCriteria[currentCriteria];
            }
          }

            List<ComplaintsDonutGraphXYData> complaintsByCriteriaList = <ComplaintsDonutGraphXYData>[];

            complaintsByCriteria.forEach((key, value)
            {
              complaintsByCriteriaList.add(ComplaintsDonutGraphXYData(key, value));
            });

            return SfCircularChart(

              tooltipBehavior: _tooltipBehavior,

              legend: Legend(
                isVisible: true,
                position: LegendPosition.auto,
              ),

              series: <CircularSeries>[
                DoughnutSeries<ComplaintsDonutGraphXYData, String>
                (
                  dataSource: complaintsByCriteriaList,
                  xValueMapper: (ComplaintsDonutGraphXYData data, _) => data.complaintsCriteria,
                  yValueMapper: (ComplaintsDonutGraphXYData data, _) => data.totalComplaints,
                  dataLabelSettings: const DataLabelSettings(isVisible: true)
                )
              ],
            );
        }

        return DefaultTextStyle(
          style: GoogleFonts.poppins(textStyle: const TextStyle(
              color: Color(0xff403b58)),
            fontSize: 22,
            fontWeight: FontWeight.w300,
          ),
          child: const Center(
            child: Text("An error has occurred!!",
            ),
          ),
        );

      },
    );
  }
}


class ComplaintsDonutGraphXYData
{
  ComplaintsDonutGraphXYData(this.complaintsCriteria, this.totalComplaints);

  final String complaintsCriteria;
  final int totalComplaints;
}