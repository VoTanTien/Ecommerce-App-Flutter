import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/screens/loginscreens/login.dart';

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(bg1), fit: BoxFit.cover),
            ),
          ),
          Container(
            color: Color.fromARGB(180, 68, 72, 75),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Column(
              children: [
                Image(
                  image: AssetImage(logo),
                  height: size.height * 0.4,
                ),
                SizedBox(height: size.height*0.05),
                Text(
                  'Ready to equip the most advanced electronic products? Explore the products in our store!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: size.height * 0.18),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> loginScreen()));
                    },
                    child: Text(
                      'GET STARTED',
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
    );
  }
}
