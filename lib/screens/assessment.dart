import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/assessment_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/objects/assessment_item_data.dart';
import 'package:t_t_project/screens/product_detail.dart';

import '../services/database_service.dart';

class assessmentScreen extends StatefulWidget{
  @override
  State<assessmentScreen> createState() => _assessmentScreenState();
}

class _assessmentScreenState extends State<assessmentScreen> {
  bool isClickAll = true;
  bool isClickNewest = false;
  List<AssessmentItemData> _assessmentItems = [];

  @override
  void initState() {
    super.initState();
    _loadAssessmentItems();
  }

  Future<void> _loadAssessmentItems() async {
    final assessmentItems = await DatabaseService().getAssessmentItems();
    setState(() {
      _assessmentItems = assessmentItems;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Assessment',
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
          color: blackColor,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          backgroundColor: isClickAll ? redColor : blackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isClickAll = true;
                            isClickNewest = false;
                          });
                        },
                        child: Text(
                          'All',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                        width: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          backgroundColor: isClickNewest ? redColor : blackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isClickAll = false;
                            isClickNewest = true;
                          });
                        },
                        child: Text(
                          'Newest',

                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 0,
                  runSpacing: 10,
                  children: _assessmentItems.map((e) {
                    return AssessmentItem(assessment: e,);
                  }).toList()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}