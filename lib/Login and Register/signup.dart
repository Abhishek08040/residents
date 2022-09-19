import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser>
{
  int _activeWidget = 1;
  int familyMemberIndex = 0;

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  Image _profilePicture = Image.asset('assets/images/user1.png', height: 88,);
  File _imagePath = File('assets/images/user1.png');
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _dateOfBirth = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _totalFamilyMembers = TextEditingController();

  String message = "";
  List<Map> _familyMembersList = <Map>[];

  @override
  void dispose()
  {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    _dateOfBirth.dispose();
    _profession.dispose();
    _totalFamilyMembers.dispose();
  }


  @override
  Widget build(BuildContext context)
  {

    switch (_activeWidget)
    {
      case 1:
        return page1();
      case 2:
        return page2();
      default:
        return page1();
    }
  }


  Scaffold page1()
  {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Center(
            child: Form(
              key: _formKey1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign up", style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                  ),),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Full Name:", style: GoogleFonts.andikaNewBasic(),),
                      TextFormField(
                        controller: _name,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return "Please enter your name";
                          }
                        },
                        onSaved: (value)
                        {
                          _name.text = value!;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Email:", style: GoogleFonts.andikaNewBasic(),),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return "Please enter your email";
                          }
                          if (!value.isEmail)
                          {
                            return "Invalid email!";
                          }
                        },
                        onSaved: (value)
                        {
                          _email.text = value.toString();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Choose a Password:", style: GoogleFonts.andikaNewBasic(),),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return "Please enter a password";
                          }
                        },
                        onSaved: (value)
                        {
                          _password.text = value.toString();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Confirm Password:", style: GoogleFonts.andikaNewBasic(),),
                      TextFormField(
                        obscureText: true,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return "Please confirm your password";
                          }
                          if (value != _password.text)
                          {
                            return "Password don't match!";
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Phone No:", style: GoogleFonts.andikaNewBasic(),),
                      TextFormField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return "Please enter your phone number";
                          }
                        },
                        onSaved: (value)
                        {
                          _phone.text = value.toString();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: ()
                      {
                        if (_formKey1.currentState !.validate())
                        {
                          setState(()
                          {
                            _activeWidget = 2;
                            message = "";
                          }
                          );
                        }
                      },
                      icon: Icon(Icons.navigate_next),
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
                      label: Text("Next", style: GoogleFonts.openSans(),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Scaffold page2()
  {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey2,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add More Details", style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                  ),),
                  SizedBox(height: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Profile Picture:", style: GoogleFonts.andikaNewBasic(),),
                      Center(
                        child: CircleAvatar(
                          radius: 52,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: ClipOval(
                              child: InkWell(
                                onTap: ()
                                async {
                                  final result = await FilePicker.platform
                                      .pickFiles(allowMultiple: false, type: FileType.image);
                                  if (result == null) return;
                                  setState(() {
                                    _profilePicture = Image.file(
                                      File(result.files[0].path!),
                                      height: 105,
                                      width: 105,
                                    );

                                    _imagePath = File(result.files[0].path!);

                                  });
                                },
                                child: _profilePicture,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Date of Birth:", style: GoogleFonts.andikaNewBasic(),),
                      InkWell(
                        onTap: ()
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context)
                              {
                                return Material(
                                  child: SfDateRangePicker(
                                    view: DateRangePickerView.decade,
                                    selectionMode: DateRangePickerSelectionMode.single,
                                    onSelectionChanged: (date)
                                    {
                                      Navigator.pop(context);
                                      setState(()
                                      {
                                        _dateOfBirth.text = date.value.toString().substring(0,10);
                                      });
                                    },
                                  ),
                                );
                              });
                        },
                        child: TextFormField(
                          autofocus: true,
                          enabled: false,
                          controller: _dateOfBirth,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Your Profession:", style: GoogleFonts.andikaNewBasic(),),
                      TextFormField(
                        controller: _profession,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return "Please enter your profession";
                          }
                        },
                        onSaved: (value)
                        {
                          _profession.text = value.toString();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Add Family Details:", style: GoogleFonts.andikaNewBasic(),),
                      InkWell(
                        onTap: () async
                        {
                          _familyMembersList = await Navigator.pushNamed(context, '/add_family_details', ) as List<Map>;
                          _totalFamilyMembers.text = _familyMembersList.length.toString() + " members added";
                        },
                        child: TextFormField(
                          controller: _totalFamilyMembers,
                          enabled: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Text(message, style: GoogleFonts.andikaNewBasic(color: Colors.red),),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _activeWidget = 1;
                            });
                          },
                          icon: Icon(Icons.arrow_back_ios_outlined),
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
                          label: Text("Go Back", style: GoogleFonts.openSans(),),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () async
                          {
                            if (_formKey2.currentState!.validate())
                            {
                              try {
                                message = "";
                                registerResident();

                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: "Successfully Created!",
                                    message: 'Your Account has been Created Successfully!',
                                    contentType: ContentType.success,
                                  ),
                                );

                                Navigator.pushReplacementNamed(context, '/login');

                                WidgetsBinding.instance.addPostFrameCallback((timeStamp)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                });

                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  message = 'The password provided is too weak.';
                                } else if (e.code == 'email-already-in-use') {
                                  message = 'The account already exists for that email.';
                                }
                              } catch (e) {
                              }
                              setState(() {

                              });
                            }
                          },
                          icon: Icon(Icons.check, ),
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
                          label: Text("Create Account", style: GoogleFonts.openSans(),),
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


  Future<void> registerResident() async
  {
    Map <String, dynamic> newResident =
    {
      "Name": _name.text,
      "Email": _email.text,
      "Phone": _phone.text,
      "DateOfBirth" : _dateOfBirth.text,
      "Profession":_profession.text,
      "Family Members":_familyMembersList,
    };

    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    );

    var collection = FirebaseFirestore.instance.collection('Residents');
    collection.doc(userCredential.user!.uid).set(newResident)
        .then((value) => FirebaseStorage.instance.ref(
        'residents display pictures/${userCredential.user!.uid}/displayPicture.PNG')
        .putFile(_imagePath,));

  }
}

