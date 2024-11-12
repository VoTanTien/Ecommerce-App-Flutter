import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/image_strings.dart';

import '../../services/auth_service.dart';

class signupScreen extends StatefulWidget {
  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool eyePass = false;
  bool eyePassComfirm = false;
  bool? checkPrivacy = false;
  final _formKey = GlobalKey<FormState>();

  void _signUp() async {
    if (_formKey.currentState!.validate() ) {// Validate the form

      if (_nameController.text.isEmpty) {
        _showErrorToast("Please enter your name.");
        return;
      }
      if (_phoneController.text.isEmpty) {
        _showErrorToast("Please enter your phone number.");
        return;
      }
      if (_emailController.text.isEmpty) {
        _showErrorToast("Please enter your email.");
        return;
      }

      if (checkPrivacy != true) {
        _showErrorToast("Please accept the Privacy Policy and Terms of Use.");
        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        _showErrorToast("Passwords do not match.");
        return;

      }
      await AuthService().signup(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phone: _phoneController.text,
        context: context,
      );
    }

  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

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
                  image: DecorationImage(
                      image: AssetImage(bg3), fit: BoxFit.cover)),
            ),
            Container(
              color: Color.fromARGB(200, 68, 72, 75),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image(image: AssetImage(logo), height: size.height * 0.2),
                      SizedBox(height: size.height * 0.02),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              cursorColor: Colors.white,
                              style: TextStyle(fontSize: 20, color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            TextFormField(
                              controller: _phoneController,
                              cursorColor: Colors.white,
                              style: TextStyle(fontSize: 20, color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
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
                            SizedBox(height: size.height * 0.02),
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
                            SizedBox(height: size.height * 0.02),
                            TextFormField(
                              controller: _confirmPasswordController,
                              cursorColor: Colors.white,
                              style: TextStyle(fontSize: 20, color: Colors.white),
                              obscureText: !eyePassComfirm, // Use obscureText based on eyePassConfirm
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    !eyePassComfirm
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => setState(() {
                                    eyePassComfirm = !eyePassComfirm;
                                  }),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Checkbox(
                                  value: checkPrivacy,
                                  side: BorderSide(color: Colors.white, width: 2),
                                  activeColor: Colors.red,
                                  onChanged: (val) {
                                    setState(() {
                                      checkPrivacy = val;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        style: GoogleFonts.inter(
                                            fontSize: 16, color: Colors.white),
                                        children: <TextSpan>[
                                          TextSpan(text: 'I accept the '),
                                          TextSpan(
                                            text:
                                                'Privacy Policy and the Store Terms of Use ',
                                            style: GoogleFonts.inter(
                                                fontSize: 16,
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    Colors.redAccent),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // backgroundColor: Color(0xFFD22E07),
                                  backgroundColor:
                                      Color.fromARGB(255, 210, 46, 7),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: _signUp,
                                child: Text(
                                  'SIGN UP',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'You already a member?',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Sign In',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


