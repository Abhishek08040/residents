import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'ComplaintsDatabase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color colorDeepBlue = const Color.fromARGB(255, 25, 29, 50);
  final Color colorWhite = const Color.fromARGB(255, 246, 255, 248);
  final Color colorLightBlue = const Color.fromARGB(255, 49, 175, 212);
  final Color colorPink = const Color.fromARGB(255, 219, 48, 105);
  final Color colorLightPink = const Color.fromARGB(255, 239, 188, 213);
  final Color colorGray = const Color.fromARGB(255, 67, 67, 67);
  final _drawerStatus = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: colorDeepBlue,
      animationCurve: Curves.easeInOut,
      controller: _drawerStatus,
      animationDuration: const Duration(microseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
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
                  color: colorPink,
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/800/7405/7405992.png"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.home_filled),
                title: Text("Home"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.home_filled),
                title: Text("Home"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.home_filled),
                title: Text("Home"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.home_filled),
                title: Text("Home"),
              ),
            ],
          ),
        )),
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              "Complaints",
            ),
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
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 825,
            ),
            child: Column(children:
            [
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        "Rate us",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: colorGray,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextField(
                        maxLines: 4,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter your comments",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Submit",
                            style: GoogleFonts.mukta(
                                textStyle: TextStyle(color: Colors.white),
                                fontSize: 15),
                          ),
                          decoration: new BoxDecoration(
                            color: colorPink,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyFirebaseTable(),
            ]),
          ),
        ),
      ),
    );
  }
}
