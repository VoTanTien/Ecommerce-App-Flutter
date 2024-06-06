import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/address_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/screens/new_address.dart';

class AddressScreen extends StatefulWidget{
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: blackColor,
          appBar: AppBar(
            title: Text('Delivery Address',
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
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Wrap(
                    spacing: 0,
                    runSpacing: 10,
                    children: List.generate(
                      3, (index) => AddressItem(
                      name: 'Vo Tan Tien',
                      phone: '0379743117',
                      address: 'Street A, District 7, Ho Chi Minh City',
                      isDefault: true,
                    ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      backgroundColor: redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (cntext) => NewAddress()));
                    },
                    child: Text(
                      'Add new address',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}