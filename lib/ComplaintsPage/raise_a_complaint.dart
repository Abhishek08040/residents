import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:intl/intl.dart';

class RaiseAComplaint extends StatefulWidget {
  const RaiseAComplaint({Key? key}) : super(key: key);

  @override
  State<RaiseAComplaint> createState() => _RaiseAComplaintState();
}

class _RaiseAComplaintState extends State<RaiseAComplaint>
{
  List<PlatformFile> files_added = <PlatformFile>[];

  final List<SelectedListItem> criteriaList = [
    SelectedListItem(name: "Servicing", isSelected: false),
    SelectedListItem(name: "Mechanical", isSelected: false),
    SelectedListItem(name: "Invoicing & Accounting", isSelected: false),
    SelectedListItem(name: "Bills Payment", isSelected: false),
    SelectedListItem(name: "Repair and Construction", isSelected: false),
    SelectedListItem(name: "Amenities", isSelected: false),
    SelectedListItem(name: "Events", isSelected: false),
    SelectedListItem(name: "Club House and Gym", isSelected: false),
    SelectedListItem(name: "Staffs", isSelected: false),
    SelectedListItem(name: "Networking", isSelected: false),
    SelectedListItem(name: "Parking", isSelected: false),
    SelectedListItem(name: "Threats or Assault", isSelected: false),
    SelectedListItem(name: "Others", isSelected: false),
  ];

  String selectedCriteria = '';
  String complaintTitle = '';
  String complaintDescription = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Raise a\nNew Complaint",
                  style: GoogleFonts.poppins(textStyle: TextStyle(
                    color: Color(0xff403b58)),
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                Text("Choose a criteria for your problem. Add a description. Add files if you want!",
                  style: GoogleFonts.qwitcherGrypen(textStyle: TextStyle(
                    color: Color(0xff403b58)),
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 10,),

                TextFormField(
                  readOnly: true,
                  onTap: (){
                    DropDownState(
                      DropDown(
                        bottomSheetTitle: "Select a Criteria".text.xl2.make(),
                        data: criteriaList,
                        selectedItems: (List<dynamic> selectedList)
                        {
                          selectedCriteria = selectedList[0].name.toString();
                          setState(()
                          {

                          });
                        }),
                    ).showModal(context);
                  },

                  validator: (value)
                  {
                    if (selectedCriteria.isEmpty)
                    {
                      return "Please Select a Criteria ";
                    }
                    else
                    {
                      return null;
                    }
                  },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: (selectedCriteria=="") ? "Select a Criteria " : selectedCriteria,
                  ),
                ),

                SizedBox(height: 8,),

                TextFormField(
                  validator: (value)
                  {
                    if (value!.isEmpty)
                    {
                      return "Please provide a title ";
                    }
                    else
                    {
                      return null;
                    }
                  },

                  onChanged: (value)
                  {
                    complaintTitle = value;
                  },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Give a title for your problem.",
                    labelText: "Provide a Title",
                  ),
                ),

                SizedBox(height: 8,),

                TextFormField(
                  validator: (value)
                  {
                    if (value!.isEmpty)
                      {
                        return "Please provide a description ";
                      }
                    else
                      {
                        return null;
                      }
                  },
                  maxLines: 3,
                  minLines: 3,
                  onChanged: (value)
                  {
                    complaintDescription = value;
                  },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Describe your issues.",
                    labelText: "Enter your complaint details",
                  ),
                ),

                SizedBox(height: 8,),

                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Add files",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                        ),
                      ),

                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () async
                          {
                            final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                            if (result==null) return ;
                            files_added += result.files;
                            setState(()
                            {

                            });
                          },

                          icon: Icon(Icons.file_upload_outlined, size: 20,),

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

                          label: Text("Browse",
                            style: GoogleFonts.lato(textStyle: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),

                SingleChildScrollView(
                  child: SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: files_added.length,
                      itemBuilder: (BuildContext context, int index)
                      {
                        return ListTile(
                          title: Text(files_added[index].name.toString()),
                          trailing: SizedBox(
                            height: 35,
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.delete_outline, color: Colors.black,),
                              onPressed: () async{
                                files_added.remove(files_added[index]);
                                setState(()
                                {

                                });
                              },
                              label: Text("Remove", style: TextStyle(color: Colors.black),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 206, 208, 206),
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Vx.black),
                                    )
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
          onPressed: ()
          {
            if (formKey.currentState!.validate())
            {
              registerComplaint(
                selectedCriteria,
                complaintTitle,
                complaintDescription,
                files_added,
              );

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
                          Text("Registered!!",
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
                              "Your complaint has been successfully raised to:",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 15,),
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
                              "Name: Rohan", style: GoogleFonts.lato(
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
                            SizedBox(height: 15,),

                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                  onPressed: () {
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
                                  child: Text("Okay", style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
          },

          icon: Icon(Icons.save_outlined, size: 20,),
          label: Text("Submit"),

      ),
    );
  }

  Future<void> registerComplaint(
      String selectedCriteria,
      String complaintTitle,
      String complaintDescription,
      List<PlatformFile> files_added,
      )
  async {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('dd-MM-yyyy').add_jm();
    String formatted = format.format(now);

    Map <String, dynamic> newComplaint =
    {
      "Complainers Name" : 'Ak',
      "Complainers Room" : '152/239 A',
      "Assigned to": 'Aman',
      "Criteria": selectedCriteria,
      "Description" : complaintDescription,
      "Registered at" : formatted,
      "Solve Status" : false,
      "Title" : complaintTitle,
    };

    FirebaseFirestore.instance.collection('complaintsData').add(newComplaint)
        .then((value) =>
        files_added.forEach((element)
        async {
          if (element != null)
          {
            var fileBytes = element.bytes;
            var fileName = element.name;

            await FirebaseStorage.instance.ref('attached files with complaints/${value.id}/$fileName').putData(fileBytes!,);
          }
        }),
    );
  }
}

