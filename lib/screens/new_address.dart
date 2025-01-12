import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/objects/address.dart';
import 'package:t_t_project/objects/user.dart';
import 'package:t_t_project/services/database_service.dart';

class NewAddress extends StatefulWidget {
  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  bool isDefault = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

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
        nameController.text = userData['name']!;
        phoneController.text = userData['phone']!;
      });
    } catch (e) {
      print('error load user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          title: Text('New Address',
              style: GoogleFonts.inter(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: blackColor,
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact',
                style: GoogleFonts.inter(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.white,
                controller: nameController,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.white,
                controller: phoneController,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Address',
                style: GoogleFonts.inter(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.white,
                controller: addressController,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Set as default address',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Switch.adaptive(
                    value: isDefault,
                    onChanged: (value) {
                      setState(() {
                        isDefault = value;
                      });
                    },
                    activeColor: redColor,
                  ),
                ],
              ),
              SizedBox(
                height: 250,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Color(0xFFD22E07),
                      backgroundColor: Color.fromARGB(255, 210, 46, 7),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        if (addressController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter new address')),
                          );
                        } else {
                          await DatabaseService().addAddress(
                              nameController.text,
                              phoneController.text,
                              addressController.text,
                              isDefault);
                        }
                      } catch (e) {}
                    },
                    child: Text(
                      'COMPLETE',
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
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
