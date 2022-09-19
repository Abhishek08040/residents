import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'Drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget
{
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
{

  final Color colorDeepBlue = const Color.fromARGB(255, 25, 29, 50);
  final Color colorWhite = const Color.fromARGB(255, 246, 255, 248);
  final Color colorLightBlue = const Color.fromARGB(255, 49, 175, 212);
  final Color colorPink = Colors.pink;
  final Color colorLightPink = const Color.fromARGB(255, 239, 188, 213);
  final Color colorGray = const Color.fromARGB(255, 67, 67, 67);
  final _drawerStatus = AdvancedDrawerController();


  @override
  Widget build(BuildContext context)
  {

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
      drawer: ResidentDrawer(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              _drawerStatus.value = AdvancedDrawerValue.visible();
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Icon(Icons.menu),
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: const Color.fromARGB(255, 20, 15, 45),
          elevation: 0,
        ),
        body: Container(),
      ),
    );
  }
}
