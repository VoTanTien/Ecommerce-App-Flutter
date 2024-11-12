import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/screens/home.dart';
import 'package:t_t_project/screens/loginscreens/enter_email.dart';
import 'package:t_t_project/screens/loginscreens/signup.dart';

import '../../services/auth_service.dart';

class loginScreen extends StatefulWidget {
  loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool eyePass = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height,
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(bg2), fit: BoxFit.cover),
              ),
            ),
            Container(
              color: Color.fromARGB(180, 68, 72, 75),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(logo),
                      height: size.height * 0.2,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'YOUR ACCOUNT FOR EVERYTHING RELATED WITH STORE',
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.gudea(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          TextFormField(
                            controller: _passwordController,
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            obscureText: !eyePass,
                            validator: (value) {   // Add validator
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  !eyePass
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () => setState(() {
                                  eyePass = !eyePass;
                                }),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => enterEmailScreen()));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.inter(
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'By logging in you accept the',
                      style:
                          GoogleFonts.inter(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      'Privacy Policy and the Store Terms of Use',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.redAccent),
                    ),
                    SizedBox(height: size.height * 0.05),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Color(0xFFD22E07),
                          backgroundColor: Color.fromARGB(255, 210, 46, 7),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () async {
                          await AuthService().signin(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context,
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
                        },
                        child: Text(
                          'SIGN IN',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signupScreen()));
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
