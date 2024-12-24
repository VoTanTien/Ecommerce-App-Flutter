import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/screens/home.dart';
import 'package:t_t_project/services/database_service.dart';

class successScreen extends StatefulWidget{
  final isTrusted;
  const successScreen({Key? key, required this.isTrusted}) : super(key: key);

  @override
  State<successScreen> createState() => _successScreenState();
}

class _successScreenState extends State<successScreen> {

  @override
  void initState() {
    super.initState();
    saveFamiliarDevice();
  }

  void saveFamiliarDevice(){
    if (!widget.isTrusted){
      showSaveDeviceDialog(context);
    }
  }

  void showSaveDeviceDialog(
      BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Save Device?"),
        content: Text("Do you want to save this device as a familiar device?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Không lưu
            child: Text("No"),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseService().saveDevice();
              Navigator.pop(context);
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: blackColor,
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Text('Congratulation',
                    style: GoogleFonts.inter(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 30,),
                Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 80,),
                Text('Order successfully',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
                        },
                        child: Text(
                          'HOME',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
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