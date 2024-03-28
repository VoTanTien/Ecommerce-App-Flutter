import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';

class editProfileScreen extends StatefulWidget {
  @override
  State<editProfileScreen> createState() => _editProfileScreenState();
}

class _editProfileScreenState extends State<editProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          title: Text('Edit Profile',
              style: GoogleFonts.inter(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: blackColor,
          leading: BackButton(color: Colors.white,),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(avatar),
                      radius: 50,
                    ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt_rounded),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Public Information',
                style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
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
                  onPressed: () {},
                  child: Text(
                    'Complete',
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
      ),
    );
  }
}
