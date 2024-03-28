import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/screens/loginscreens/newpass.dart';

class verifyEmailScreen extends StatelessWidget {
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
                image: DecorationImage(image: AssetImage(bg4), fit: BoxFit.cover),
              ),
            ),
            Container(
              color: Color.fromARGB(180, 68, 72, 75),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 35,),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(logo),
                          height: size.height * 0.3,
                        ),
                        SizedBox(height: size.height*0.03),
                        Text(
                          'Verification code has been sent to your email. Please enter the verification code.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: size.height*0.05),
                        Form(
                          child: TextFormField(
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            decoration: InputDecoration(

                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Verification Code',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.07),
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => newPassScreen()));
                            },
                            child: Text(
                              'ACCURACY',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
