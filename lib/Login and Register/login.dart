import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dashboard.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success = false;
  String _userEmail = "";
  String message = "";

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Login", style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                    ),),
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Enter your username:", style: GoogleFonts.andikaNewBasic(),),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if (value!.isEmpty)
                              {
                                return "Please enter your email";
                              }
                            else if (!value.isEmail)
                              {
                                return "Invalid email";
                              }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Enter your password:", style: GoogleFonts.andikaNewBasic(),),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter a password";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Text(message, style: GoogleFonts.andikaNewBasic(color: Colors.red),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async
                        {
                          if (_formKey.currentState!.validate())
                          {
                            try {
                              UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                              );
                              User? user = userCredential.user;
                              message = "";
                              setState(() {
                                if (user != null)
                                  {
                                    _success = true;
                                    _userEmail = user.email!;
                                  }
                                else
                                  {
                                    _success = false;
                                  }

                              });

                              var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: "Logged in Successfully!",
                                  message: 'You have been logged in successfully!',
                                  contentType: ContentType.success,
                                ),
                              );


                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('userID', user!.uid);

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Dashboard()),
                              );

                              WidgetsBinding.instance.addPostFrameCallback((timeStamp)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              });


                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                message = 'No user found for that email.';
                              } else if (e.code == 'wrong-password') {
                                message = 'Wrong password provided for that user.';
                              }
                            setState(() {

                            });
                            }
                          }
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
                        child: Text("Login", style: GoogleFonts.openSans(),),
                      ),
                    ),
                    const SizedBox(height: 20,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No account?", style: GoogleFonts.andikaNewBasic(),),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text("Sign up", style: GoogleFonts.andikaNewBasic(
                              color: Colors.blue
                          ),),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 1, color: Colors.black,),),
                        Text(" OR ", style: GoogleFonts.sourceSansPro(),),
                        Expanded(child: Divider(thickness: 1, color: Colors.black,),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {

                        },
                        icon: Image.asset('assets/images/google.png', height: 40, width: 40,),
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
                        label: Text("Sign in with Google", style: GoogleFonts.openSans(),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
