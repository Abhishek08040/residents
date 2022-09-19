import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:residents_app/ComplaintsPage/complaints_dashboard.dart';
import 'package:residents_app/ComplaintsPage/complaints_history_table.dart';
import 'package:residents_app/ComplaintsPage/raise_a_complaint.dart';
import 'package:residents_app/ComplaintsPage/view_unsolved_complaints.dart';
import 'ComplaintsPage/complaints_donut_graph_page.dart';
import 'Dashboard.dart';
import 'Login and Register/add_family_members.dart';
import 'Login and Register/login.dart';
import 'Login and Register/signup.dart';
import 'firebase/firebase_options.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: web);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    User? user = FirebaseAuth.instance.currentUser;
    String initialRoute;

    if (user!=null)
    {
      initialRoute = '/';
    }
    else
    {
      initialRoute = '/login';
    }

    return MaterialApp
      (
      title: "Residents Page",
      debugShowCheckedModeBanner: false,
      theme: ThemeData
        (
          colorScheme: ColorScheme.fromSwatch().copyWith
            (
            primary: const Color.fromARGB(255, 20, 15, 45),
            secondary: const Color.fromARGB(255, 217, 4, 41),
          )
      ),
      initialRoute: initialRoute,
      routes: {
        '/':(context) => const Dashboard(),
        '/complaints': (context) => const ComplaintsDashboardPage(),
        '/raise_complaint': (context) => const RaiseAComplaint(),
        '/complaints_details': (context) => const ComplaintsHistoryTable(),
        '/complaint_donut_graph': (context) => const ComplaintsDonutGraphPage(),
        '/unsolved_complaints': (context) => const UnsolvedComplaints(),
        '/signup': (context) => const RegisterUser(),
        '/login': (context) => const Login(),
        '/add_family_details': (context) => const AddFamilyMembers(),
      },
    );
  }
}
