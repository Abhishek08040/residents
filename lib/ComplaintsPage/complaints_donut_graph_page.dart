import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'complains_donut_graph.dart';

class ComplaintsDonutGraphPage extends StatefulWidget {
  const ComplaintsDonutGraphPage({Key? key}) : super(key: key);

  @override
  State<ComplaintsDonutGraphPage> createState() => _ComplaintsDonutGraphPageState();
}

class _ComplaintsDonutGraphPageState extends State<ComplaintsDonutGraphPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Hero(
      tag: 'donutGraph',
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text("Your\nComplaints",
                  style: GoogleFonts.poppins(textStyle: TextStyle(
                      color: Color(0xff403b58)),
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Divider(thickness: 2,),
              SizedBox(
                  height: 460,
                  child: ComplaintsDonutGraph()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
