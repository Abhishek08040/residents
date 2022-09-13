import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:residents_app/Drawer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'complains_donut_graph.dart';
import 'package:residents_app/global_variables.dart' as globals;

class ComplaintsDashboardPage extends StatefulWidget {
  const ComplaintsDashboardPage({Key? key}) : super(key: key);

  @override
  State<ComplaintsDashboardPage> createState() => _ComplaintsDashboardPageState();
}

class _ComplaintsDashboardPageState extends State<ComplaintsDashboardPage>
{

  final _drawerStatus = AdvancedDrawerController();

  double ratings = 3;
  String comments = "";

  @override
  Widget build(BuildContext context)
  {
    FirebaseFirestore
        .instance
        .collection('complaintsData')
        .where("Solve Status",isEqualTo: true)
        .get()
        .then((value)
    {
      setState(() {
        globals.solvedComments = value.docs.length;
      });
    });

    FirebaseFirestore
        .instance
        .collection('complaintsData')
        .where("Solve Status",isEqualTo: false)
        .get()
        .then((value)
    {
      setState(() {
        globals.unsolvedComments = value.docs.length;
      });
    });

    int unsolvedComments = globals.unsolvedComments;
    int solvedComments = globals.solvedComments;

    return AdvancedDrawer(
      backdropColor: const Color.fromARGB(255, 25, 29, 50),
      animationCurve: Curves.easeInOut,
      controller: _drawerStatus,
      animationDuration: const Duration(microseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      ),

      drawer: ResidentDrawer(),

      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          leading: InkWell(
            onTap: () async {
              _drawerStatus.value = AdvancedDrawerValue.visible();
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Icon(Icons.menu),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CatalogHeader(),
                SizedBox(
                  height: 208,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Rate us", style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Center(
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate:  (rating)
                          {
                            ratings = rating;
                          },
                        ),
                      ),
                      Center(
                        child: TextField(
                          maxLines: 2,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Enter your suggestions/ feedback",
                          ),
                          onChanged: (value){
                            comments = value;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              confirmationPopup(ratings, comments);
                              },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Vx.blue900,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ),
                            ),
                            child: "Submit".text.make(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                "Unsolved Complaints".text.normal.make(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'unsolved_complaints',
                      child: VxBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Material(
                              child: InkWell(
                                  onTap: (){Navigator.pushNamed(context, '/unsolved_complaints');},
                                  child: Icon(Icons.query_stats_outlined,
                                    size: 35,
                                    color: Vx.blue900,).
                                  box.roundedFull.make().p16()),
                              color: Colors.transparent,
                            ),
                            Text("View Unsolved", style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w600,
                              textStyle: TextStyle(
                                color: Vx.blue900,
                              ),),),
                            Text("Complaints", style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w600,
                              textStyle: TextStyle(
                                color: Vx.blue900,
                              ),),),
                          ],
                        ),
                      ).roundedLg.square(100).color(Vx.blue300).shadow3xl.make().py16(),
                    ),
                    VxBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(unsolvedComments.toString(), style: GoogleFonts.poppins(
                            fontSize: 32,
                            textStyle: TextStyle(
                            color: Vx.blue900,
                          ),),),
                          Text("Unsolved", style: GoogleFonts.poppins(
                            fontSize: 10, fontWeight: FontWeight.w600,
                            textStyle: TextStyle(
                              color: Vx.blue900,
                            ),),),
                          Text("Complaints", style: GoogleFonts.poppins(
                            fontSize: 10, fontWeight: FontWeight.w600,
                            textStyle: TextStyle(
                              color: Vx.blue900,
                            ),),),
                        ],
                      ),
                    ).roundedLg.square(100).color(Vx.blue300).shadow3xl.make().py16(),
                  ],
                ),
                "Solved Complaints".text.normal.make(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'complaints_details',
                      child: VxBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/complaints_details');
                                  },
                                  child: Icon(Icons.manage_history_outlined,
                                    size: 35,
                                    color: Vx.blue900,).
                                  box.roundedFull.make().p16()),
                            ),
                            Text("View", style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w600,
                              textStyle: TextStyle(
                                color: Vx.blue900,
                              ),),),
                            Text("Details", style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w600,
                              textStyle: TextStyle(
                                color: Vx.blue900,
                              ),
                              ),
                            ),
                          ],
                        ),
                      ).roundedLg.square(100).color(Vx.blue300).shadow3xl.make().py16(),
                    ),
                    VxBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(solvedComments.toString(), style: GoogleFonts.poppins(
                            fontSize: 32,
                            textStyle: TextStyle(
                              color: Vx.blue900,
                            ),),),
                          Text("Solved", style: GoogleFonts.poppins(
                            fontSize: 10, fontWeight: FontWeight.w600,
                            textStyle: TextStyle(
                              color: Vx.blue900,
                            ),),),
                          Text("Complaints", style: GoogleFonts.poppins(
                            fontSize: 10, fontWeight: FontWeight.w600,
                            textStyle: TextStyle(
                              color: Vx.blue900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).roundedLg.square(100).color(Vx.blue300).shadow3xl.make().py16(),
                  ],
                ),
                SizedBox(height:15),
                "Your Complaints".text.normal.make(),
                Hero(
                  tag: 'donutGraph',
                  child: Material(
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/complaint_donut_graph');
                      },
                      child: SizedBox(
                          height: 180,
                          child: ComplaintsDonutGraph(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, '/raise_complaint');
          },
          elevation: 12,

          child: Icon(Icons.add, size: 35,),
          tooltip: "Add a new complaint",
        ),
      ),
    );
  }

  void confirmationPopup(double ratings, String comments)
  {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),

            contentPadding: EdgeInsets.all(20),

            title: Column(
              children: [
                Text("Confirm",
                  style: GoogleFonts.poppins(textStyle: TextStyle(
                      color: Color(0xff403b58)),
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text("Feedback",
                  style: GoogleFonts.poppins(textStyle: TextStyle(
                      color: Color(0xff403b58)),
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),

            content: Container(
              width: 400,
              height: 225,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(color: Colors.black,),
                  SizedBox(height: 20,),
                  Text(
                    "Your rating:",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < ratings; i++) Icon(
                          Icons.star, color: Colors.amber, size: 25,),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    "Your comments:",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text((comments.isEmpty) ? "No comments!" : comments,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 15,
                      )
                  ),),

                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Vx.blue900,
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10),
                                )
                            ),
                          ),
                          child: Text("Cancel", style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () async
                          {
                            Map <String, dynamic> ratingsAndCommentsData = {
                            "Ratings": ratings,
                            "Comments":comments,
                            };
                            FirebaseFirestore.instance.collection('residentsRatingsAndComments').add(ratingsAndCommentsData);
                            Navigator.pushNamed(context, '/complaints');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Vx.blue900,
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10),
                                )
                            ),
                          ),
                          child: Text("Confirm", style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


class CatalogHeader extends StatelessWidget
{
  const CatalogHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: Text("Complaints", style: GoogleFonts.poppins(textStyle: TextStyle(
          color: Color(0xff403b58)),
          fontSize: 32,
          fontWeight: FontWeight.w300
        ),
      ),
    );
  }
}

