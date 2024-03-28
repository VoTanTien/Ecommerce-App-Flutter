import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/image_strings.dart';

class signupScreen extends StatefulWidget {
  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  bool eyePass = false;
  bool eyePassComfirm = false;
  bool? checkPrivacy = false;

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
                      DecorationImage(image: AssetImage(bg3), fit: BoxFit.cover)),
            ),
            Container(
              color: Color.fromARGB(200, 68, 72, 75),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                child: Column(
                  children: [
                    Image(image: AssetImage(logo), height: size.height * 0.2),
                    SizedBox(height: size.height * 0.02),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
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
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                              labelText: 'Comfirm Password',
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
                                              decorationColor: Colors.redAccent),
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
                                backgroundColor: Color.fromARGB(255, 210, 46, 7),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {},
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
                                onPressed: (){
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
          ],
        ),
      ),
    );
  }
}
