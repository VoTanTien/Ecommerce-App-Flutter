import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/filter_button.dart';
import 'package:t_t_project/common_widget/sub_product_button.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/objects/product_manager.dart';

class searchScreen extends StatefulWidget {
  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  final TextEditingController textSearch = TextEditingController();
  bool isClickRelated = true;
  bool isClickNewest = false;
  bool isClickBest = false;
  bool isClickDown = true;
  bool _showListItem = false;
  ProductManager productManager = ProductManager();

  List<String> brands = [];
  List<String> productType = [];
  @override
  void initState() {
    super.initState(); // Gọi super.initState() trước
    brands.add('Asus');
    brands.add('MSI');
    brands.add('Dell');
    brands.add('Apple');
    productType.add('Laptop');
    productType.add('Mouse');
    productType.add('Headphone');
    productType.add('Keyboard');
  }

  _displayBottomSheet()  {
    RangeValues values = const RangeValues(0, 10000);
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          final sized = MediaQuery.of(context).size;

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,

                      child: Text(
                        'Search Filter',
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Divider(
                      color: blackColor,
                      thickness: 2,
                      height: 10,
                    ),
                    Text(
                      'Brand',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: brands.map((e) =>  FilterButton(content: e)).toList()
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Product',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Wrap(
                      spacing: 15,
                      runSpacing: 10,
                      children: productType.map((e) =>
                          FilterButton(content: e)
                      ).toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   'State',
                    //   style: GoogleFonts.inter(
                    //       fontSize: 16,
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w600),
                    // ),
                    // Wrap(
                    //   spacing: 10,
                    //   runSpacing: 10,
                    //   children: List.generate(
                    //     3,
                    //     (index) => FilterButton(content: 'New'),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      'Price',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            '\$ 0',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: sized.width * 0.3,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'to',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: sized.width * 0.3,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '\$ 10000',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),

                    RangeSlider(
                      values: values,
                      divisions: 10,
                      min: 0,
                      max: 10000,
                      labels: RangeLabels(
                        values.start.round().toString(),
                        values.end.round().toString(),
                      ),
                      activeColor: redColor,
                      inactiveColor: Colors.grey,
                      onChanged: (newValues) {
                        setState(() {
                          values = newValues;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: redColor, width: 2),
                            ),
                          ),
                          onPressed: () {
                          },
                          child: Text(
                            'Reset',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                color: redColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                            backgroundColor: redColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _showListItem = true;
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Apply',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              );
            }
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 55,
                    width: size.width * 0.78,
                    child: CupertinoSearchTextField(
                      controller: textSearch,
                      style: TextStyle(color: Colors.white),
                      backgroundColor: Color(0xFF44484B),
                      borderRadius: BorderRadius.circular(30),
                      itemColor: Colors.white,
                      itemSize: 25,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _displayBottomSheet();
                      },
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        backgroundColor: isClickRelated ? redColor : blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isClickNewest = false;
                          isClickBest = false;
                          isClickRelated = true;
                        });
                      },
                      child: Text(
                        'Related',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 3,
                      width: 15,
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
                          isClickRelated = false;
                          isClickBest = false;
                          isClickNewest = true;
                        });
                      },
                      child: Text(
                        'Newest',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 3,
                      width: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        backgroundColor: isClickBest ? redColor : blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isClickRelated = false;
                          isClickBest = true;
                          isClickNewest = false;
                        });
                      },
                      child: Text(
                        'Best Selling',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 3,
                      width: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        backgroundColor: blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isClickDown = !isClickDown;
                        });
                      },
                      child: Text(
                        'Price',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Icon(
                      isClickDown
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      color: Colors.white,
                      size: 25,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //List Item
              if(_showListItem)
              Wrap(
                spacing: 15,
                runSpacing: 20,
                children: productManager.products.map((e) =>
                    SubProductButton(
                      subimage: e.image,
                      title: e.title,
                      rating: 4,
                      price: e.price,
                      discountPrice: e.discountPrice,
                    ),
                ).toList()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
