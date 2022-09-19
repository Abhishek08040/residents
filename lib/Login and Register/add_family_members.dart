import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AddFamilyMembers extends StatefulWidget {
  const AddFamilyMembers({Key? key}) : super(key: key);

  @override
  State<AddFamilyMembers> createState() => _AddFamilyMembersState();
}

class _AddFamilyMembersState extends State<AddFamilyMembers>
{
  int familyMemberIndex = 0;
  List<Map> familyMembersList = <Map>[];

  List<TextEditingController> _relation = <TextEditingController>[];
  List<TextEditingController> _nameOfFamilyMember = <TextEditingController>[];
  List<Row> familyMembers = <Row>[];

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey1,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Family Details", style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                  ),),
                  SizedBox(height: 10,),

                  SizedBox(
                    height: 350,
                    child: SingleChildScrollView(
                      child: Column(
                        children: familyMembers,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: ()
                          {
                            if (_formKey1.currentState!.validate())
                            {
                              _relation.add(TextEditingController());
                              _nameOfFamilyMember.add(TextEditingController());

                              setState(() {
                                familyMembers.add(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Text("Relation:", style: GoogleFonts
                                                .andikaNewBasic(),),
                                            TextFormField(
                                              controller: _relation[familyMemberIndex],
                                              onSaved: (value) {
                                                _relation[familyMemberIndex]
                                                    .text = value.toString();
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Empty!";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 25,),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Text("Name:", style: GoogleFonts
                                                .andikaNewBasic(),),
                                            TextFormField(
                                              controller: _nameOfFamilyMember[familyMemberIndex],
                                              onSaved: (value) {
                                                _nameOfFamilyMember[familyMemberIndex]
                                                    .text = value.toString();
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Empty!";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],),
                                );
                                ++familyMemberIndex;
                              });
                            }

                          },
                          icon: Icon(Icons.add),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.pink,
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          label: Text("Add Member", style: GoogleFonts.openSans(),),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: ()
                          {
                            for (int i = 0; i<familyMemberIndex; i++)
                            {
                              String relation = _relation[i].text;
                              String name = _nameOfFamilyMember[i].text;

                              Map member = Map();
                              member[relation] = name;
                              if (!relation.isEmpty && !name.isEmpty)
                              {
                                familyMembersList.add(member);
                              }
                            }
                            Navigator.pop(context, familyMembersList);
                          },
                          icon: Icon(Icons.check,),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.pink,
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          label: Text("Submit", style: GoogleFonts.openSans(),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
