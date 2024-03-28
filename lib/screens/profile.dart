import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/screens/edit_profile.dart';
import 'package:t_t_project/screens/loginscreens/login.dart';

class profileScreen extends StatefulWidget {
  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text('My Profile',
              style: GoogleFonts.inter(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatar),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Vo Tan Tien',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(height: 15,),
                      ListTile(
                        title: Text('Edit profile',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                        leading: Icon(Icons.edit_note_rounded, color: Colors.white,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => editProfileScreen()));
                        },
                      ),
                      ListTile(
                        title: Text('History of purchases',
                            style: GoogleFonts.inter(
                            fontSize: 18,
                            color: Colors.white,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                        leading: Icon(Icons.history, color: Colors.white,),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('Liked',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                        leading: Icon(Icons.favorite_border_outlined, color: Colors.white,),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('My assessment',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                        leading: Icon(Icons.star_border_outlined, color: Colors.white,),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('Change password',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                        leading: Icon(Icons.change_circle_outlined, color: Colors.white,),
                        onTap: (){},
                      ),

                      ListTile(
                        title: Text('Information',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                        leading: Icon(Icons.info_outline_rounded, color: Colors.white,),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('Help',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                        leading: Icon(Icons.help_outline, color: Colors.white,),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('Log out',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: redColor,)
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: redColor,),
                        leading: Icon(Icons.logout_outlined, color: redColor,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> loginScreen()));
                        },
                      ),
                    ],
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
