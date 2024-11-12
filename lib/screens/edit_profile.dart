import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';

import '../services/database_service.dart';

class editProfileScreen extends StatefulWidget {
  @override
  State<editProfileScreen> createState() => _editProfileScreenState();
}

class _editProfileScreenState extends State<editProfileScreen> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final databaseService = DatabaseService();
    try {
      final userData = await databaseService.getUserData();
      setState(() {
        _nameController.text = userData['name']!;
        _emailController.text = userData['email']!;
        _phoneController.text = userData['phone']!;
      });
    } catch (e) {
      // Handle error, for example by showing a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load user data")),
      );
    }
  }

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
                height: size.height * 0.02,
              ),
              TextFormField(
                controller: _nameController,
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
                height: size.height * 0.05,
              ),
              TextFormField(
                controller: _emailController,
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
                height: size.height * 0.05,
              ),
              TextFormField(
                controller: _phoneController,
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
                height: size.height * 0.05,
              ),
              // TextFormField(
              //   cursorColor: Colors.white,
              //   initialValue: '123 Street A, District 1, Ho Chi Minh City',
              //   style: TextStyle(fontSize: 20, color: Colors.white),
              //   decoration: InputDecoration(
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(width: 2, color: Colors.white),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     labelText: 'Address',
              //     labelStyle: TextStyle(color: Colors.white),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.red, width: 2),
              //         borderRadius: BorderRadius.circular(20)),
              //   ),
              // ),
              SizedBox(
                height: size.height * 0.05,
              ),
              // TextFormField(
              //   cursorColor: Colors.white,
              //   initialValue: 'tienpro1234',
              //   style: TextStyle(fontSize: 20, color: Colors.white),
              //   decoration: InputDecoration(
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(width: 2, color: Colors.white),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     labelText: 'Password',
              //     labelStyle: TextStyle(color: Colors.white),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.red, width: 2),
              //         borderRadius: BorderRadius.circular(20)),
              //   ),
              // ),
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
                  onPressed: () {

                  },
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
