import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class UnsolvedComplaints extends StatefulWidget {
  const UnsolvedComplaints({Key? key}) : super(key: key);

  @override
  State<UnsolvedComplaints> createState() => _UnsolvedComplaintsState();
}

class _UnsolvedComplaintsState extends State<UnsolvedComplaints>
{
  bool isComplaintSolved = false;
  double ratings = 3;
  String comments = "";

  CollectionReference complaints = FirebaseFirestore
      .instance
      .collection('complaintsData');

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Hero(
      tag: 'unsolved_complaints',
      child: FutureBuilder(
        future: complaints.where("Solve Status",isEqualTo: false).get(),
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
            String complainID;
            String registeredAt;
            String title;
            String description;
            String criteria;
            String assignedTo;
            var complainRow;

            int itemCount = snapshot.data.docs.length;
            List<UnsolvedComplaintsData> unsolvedComplaintsList = <UnsolvedComplaintsData>[];

            for (int i = 0; i < itemCount; i++)
            {
              complainRow = snapshot.data.docs[i].data();

              complainID = snapshot.data.docs[i].id;
              registeredAt = complainRow['Registered at'];
              title = complainRow['Title'];
              description = complainRow['Description'];
              criteria = complainRow['Criteria'];
              assignedTo = complainRow['Assigned to'];

              unsolvedComplaintsList.add(
                UnsolvedComplaintsData(
                    complainID,
                    registeredAt,
                    title,
                    description,
                    criteria,
                    assignedTo
                    )
                );
            }
            return  DefaultTabController(
              length: itemCount,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.redAccent,
                  elevation: 0,
                  bottom: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),

                      tabs: [
                        for (int i = 0; i<itemCount; i++) Tab(
                          child: Text((i+1).toString(),
                            style: GoogleFonts.poppins(textStyle: TextStyle(
                            ),
                              fontSize: 20,
                              color: Color(0xff89023e),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                body: TabBarView(
                  children:
                  [
                    for (int i = 0; i < itemCount; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Expanded(
                              child: Card(
                                elevation: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Complaints ID: "+ unsolvedComplaintsList[i].complaintID, style: GoogleFonts.lato(
                                        color: Vx.blue900,
                                        fontSize: 16,
                                      ),),
                                      SizedBox(height: 10,),

                                      Text("Registered at "+ unsolvedComplaintsList[i].registeredAt, style: GoogleFonts.lato(
                                        color: Vx.blue900,
                                        fontSize: 16,
                                      ),),
                                      SizedBox(height: 10,),

                                      Text("Title: "+ unsolvedComplaintsList[i].title, style: GoogleFonts.lato(
                                        color: Vx.blue900,
                                        fontSize: 16,
                                      ),),
                                      SizedBox(height: 10,),

                                      Text("Description: "+ unsolvedComplaintsList[i].description , style: GoogleFonts.lato(
                                        color: Vx.blue900,
                                        fontSize: 16,
                                      ),),

                                      SizedBox(height: 10,),

                                      Text("Criteria: "+ unsolvedComplaintsList[i].criteria, style: GoogleFonts.lato(
                                        color: Vx.blue900,
                                        fontSize: 16,
                                      ),),

                                      SizedBox(height: 10,),

                                      Text("Allocated to: " , style: GoogleFonts.lato(
                                        color: Vx.blue900,
                                        fontSize: 16,
                                      ),),

                                      Container(
                                        child: SizedBox(
                                          width: 350,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                "Staff".text.xl2.make(),
                                                SizedBox(height: 8,),
                                                CircleAvatar(
                                                  radius: 42,
                                                  backgroundColor: Colors.redAccent,
                                                  child: CircleAvatar(
                                                    radius: 40,
                                                    child: ClipOval(
                                                      child: Image.network(
                                                        "https://cdn-icons-png.flaticon.com/800/7405/7405992.png",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15,),
                                                Text(
                                                  "Name: "+ unsolvedComplaintsList[i].assignedTo, style: GoogleFonts.lato(
                                                  textStyle: TextStyle(fontSize: 15,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                ),
                                                Text("Phone: +91 9182989384",
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(height: 16,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 35,
                                                      child: ElevatedButton(
                                                        onPressed: () {
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
                                                        child: Text("Call", style: GoogleFonts.lato(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 20,),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 35,
                                                      child: ElevatedButton(
                                                        onPressed: () {

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
                                                        child: Text("Chat", style: GoogleFonts.lato(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 20,),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    SizedBox(height: 12,),

                                                    Text("Complaint Solved? ",
                                                      style: GoogleFonts.lato(textStyle: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                      ),
                                                    ),

                                                    Switch(
                                                      value: isComplaintSolved,
                                                      onChanged: (value)
                                                      {
                                                        if (isComplaintSolved == false)
                                                        {
                                                          setState(() {
                                                            isComplaintSolved = true;

                                                            showDialog(
                                                                context: context,
                                                                builder: (context)
                                                                {
                                                                  return AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(40),
                                                                    ),

                                                                    contentPadding: EdgeInsets.all(20),

                                                                    title: Column(
                                                                      children: [
                                                                        Text("Complaint",
                                                                          style: GoogleFonts.poppins(textStyle: TextStyle(
                                                                              color: Color(0xff403b58)),
                                                                            fontSize: 32,
                                                                            fontWeight: FontWeight.w300,
                                                                          ),
                                                                        ),
                                                                        Text("Resolved?",
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
                                                                      height: 290,

                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Divider(color: Colors.black,),
                                                                          SizedBox(height: 20,),
                                                                          Text(
                                                                            "Rate us..",
                                                                            style: GoogleFonts.lato(
                                                                              textStyle: TextStyle(fontSize: 20,
                                                                                  fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 15,),
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
                                                                              onRatingUpdate:  (value)
                                                                              {
                                                                                ratings = value;
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 15,),
                                                                          Center(
                                                                            child: TextField(
                                                                              maxLines: 2,
                                                                              minLines: 1,
                                                                              onChanged: (value)
                                                                              {
                                                                                comments = value;
                                                                              },
                                                                              decoration: InputDecoration(
                                                                                border: UnderlineInputBorder(),
                                                                                labelText: "Enter your comments",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 15,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 35,
                                                                                child: ElevatedButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                    setState(() {
                                                                                      isComplaintSolved = false;
                                                                                    });
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
                                                                                  onPressed: () {
                                                                                    DateTime now = DateTime.now();
                                                                                    DateFormat format = DateFormat('dd-MM-yyyy').add_jm();
                                                                                    String formatted = format.format(now);


                                                                                    Map <String, dynamic> ratingsAndCommentsData = {
                                                                                      "Ratings": ratings,
                                                                                      "Solved at": formatted,
                                                                                      "Comments":comments,
                                                                                      "Solve Status":true,
                                                                                    };
                                                                                    FirebaseFirestore
                                                                                        .instance
                                                                                        .collection('complaintsData')
                                                                                        .doc(unsolvedComplaintsList[i].complaintID)
                                                                                        .update(ratingsAndCommentsData);

                                                                                    const snackBar = SnackBar(
                                                                                      content: Text('Complaint marked as resolved!!'),
                                                                                    );

                                                                                    Navigator.pushNamed(context, '/complaints');

                                                                                    WidgetsBinding.instance.addPostFrameCallback((timeStamp)
                                                                                    {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                    });

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
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                            );
                                                          });
                                                        }
                                                        else
                                                        {
                                                          setState(() {
                                                            isComplaintSolved = false;
                                                          });
                                                        }
                                                    },
                                                      activeColor: Colors.green,
                                                      inactiveThumbColor: Colors.redAccent,
                                                      inactiveTrackColor: Vx.red300,

                                                    ),
                                                  ],
                                                ),
                                              ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

class UnsolvedComplaintsData
{
  UnsolvedComplaintsData(
      this.complaintID, this.registeredAt,
      this.title, this.description,
      this.criteria, this.assignedTo
      );

  final String complaintID;
  final String registeredAt;
  final String title;
  final String description;
  final String criteria;
  final String assignedTo;
}