import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: web);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);
  final Color color1 = const Color.fromARGB(255, 25, 29, 50);
  final Color color2 = const Color.fromARGB(255,219, 48, 105);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
      (
      title: "Complaints and Feedbacks",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData
        (
          colorScheme: ColorScheme.fromSwatch().copyWith
            (
            primary: color1,
            secondary: color2,
          )
      ),
      //   routes: {'/second': (context) => const SecondScreen(),},
    );
  }
}
