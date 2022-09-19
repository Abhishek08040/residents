import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ResidentDrawer extends StatefulWidget
{
  const ResidentDrawer({Key? key}) : super(key: key);

  @override
  State<ResidentDrawer> createState() => _ResidentDrawerState();
}

class _ResidentDrawerState extends State<ResidentDrawer>
{
  String displayPhotoURL = "https://cdn-icons-png.flaticon.com/512/456/456141.png";

  @override
  Widget build(BuildContext context)
  {
    getDisplayPhoto();

    return SafeArea(
      child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(top: 24.0, bottom: 64.0),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(displayPhotoURL),
                ),
                ListTile(
                  onTap: () {Navigator.pushReplacementNamed(
                      context, "/"
                    );
                  },
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.chat_bubble_outline),
                  title: Text("Messaging & Chats"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/complaints'
                    );
                  },
                  leading: Icon(Icons.thumb_down_off_alt_outlined),
                  title: Text("Complaints & Feedback"),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.redeem_outlined),
                  title: Text("Couriers & Visitors"),
                ),
                ListTile(
                  onTap: () async
                  {
                    showDialog(
                      context: context,
                      builder: (context)
                    {
                      FirebaseAuth.instance.signOut();
                      return SingleChildScrollView(
                        child: AlertDialog(
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
                              Text("Log-out?",
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
                                  "Are you sure you want to log out?",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
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
                                        child: Text("Cancel", style: GoogleFonts.openSans(),),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () async
                                        {
                                          var snackBar = SnackBar(
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: "Logged out Successfully!",
                                              message: 'You have been logged out successfully!',
                                              contentType: ContentType.success,
                                            ),
                                          );

                                          Navigator.pushNamed(context, '/login');

                                          WidgetsBinding.instance.addPostFrameCallback((timeStamp)
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          });
                                        },
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
                                        child: Text("Yes", style: GoogleFonts.openSans(),),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  leading: Icon(Icons.logout_outlined),
                  title: Text("Log out"),
                ),
              ],
            ),
          )),
    );
  }

  getDisplayPhoto() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userID').toString();

    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl =
    await storageRef.child("/residents display pictures/$userID/displayPicture.png").getDownloadURL();

    setState(()
    {
      displayPhotoURL = imageUrl;
    });
  }
}
