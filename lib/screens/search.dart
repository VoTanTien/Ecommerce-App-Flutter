import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/filter_button.dart';
import 'package:t_t_project/common_widget/sub_product_button.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';

import '../objects/product.dart';
import '../services/database_service.dart';

class searchScreen extends StatefulWidget {
  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  bool isClickRelated = true;
  bool isClickNewest = false;
  bool isClickBest = false;
  bool isClickPrice = false;
  bool isClickDown = true; // price from high to low
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Product> _products = []; // Store the fetched products
  List<Product> _filteredProducts = []; // Store filtered and sorted products
  List<Product> _originalProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products when the screen initializes
    _textController.addListener(_filterProducts); // Listen for text changes
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await DatabaseService().getProducts();
      setState(() {
        _products = products; //point to not copy
        _originalProducts = List.from(products);  // make a copy of the original list
        _filteredProducts = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void _filterProducts() {
    final query = _textController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _filteredProducts = _products;
        _sortProducts();
      });
      return;
    }
    setState(() {
      _filteredProducts = _products.where((product) {
        final productTitle = product.title.toLowerCase();
        // Check if the query is a substring of the product title
        return productTitle.contains(query);
      }).toList();
      _sortProducts();

    });
  }

  void _sortProducts() {
    if (isClickRelated) {
      _filteredProducts.sort((a, b) => (b.discountPrice ?? b.price).compareTo(a.discountPrice ?? a.price)); // descending
    } else if (isClickNewest) {
      final filteredIds = _filteredProducts.map((p) => p.id).toSet(); // Get IDs of filtered products
      _filteredProducts = _originalProducts.where((p) => filteredIds.contains(p.id)).toList(); // Filter from original list
      _filteredProducts = List.from(_filteredProducts.reversed); // Reverse the filtered original list
    } else if (isClickPrice) {
      _filteredProducts.sort((a, b) => (isClickDown
          ? (b.discountPrice ?? b.price).compareTo(a.discountPrice ?? a.price)  // Descending
          : (a.discountPrice ?? a.price).compareTo(b.discountPrice ?? b.price)   // Ascending
      ));
    }
  }

  // filter show
  // _displayBottomSheet()  {
  //   RangeValues values = const RangeValues(0, 10000);
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       useSafeArea: true,
  //       context: context,
  //       builder: (context) {
  //         final sized = MediaQuery.of(context).size;
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Container(
  //               width: double.infinity,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 shape: BoxShape.rectangle,
  //                 borderRadius: BorderRadius.circular(40),
  //               ),
  //               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.center,
  //
  //                     child: Text(
  //                       'Search Filter',
  //                       style: GoogleFonts.inter(
  //                           fontSize: 20,
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.w700),
  //                     ),
  //                   ),
  //                   Divider(
  //                     color: blackColor,
  //                     thickness: 2,
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     'Brand',
  //                     style: GoogleFonts.inter(
  //                         fontSize: 16,
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   Wrap(
  //                     spacing: 10,
  //                     runSpacing: 10,
  //                     children: brands.map((e) =>  FilterButton(content: e)).toList()
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(
  //                     'Product',
  //                     style: GoogleFonts.inter(
  //                         fontSize: 16,
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   Wrap(
  //                     spacing: 15,
  //                     runSpacing: 10,
  //                     children: productType.map((e) =>
  //                         FilterButton(content: e)
  //                     ).toList(),
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   // Text(
  //                   //   'State',
  //                   //   style: GoogleFonts.inter(
  //                   //       fontSize: 16,
  //                   //       color: Colors.black,
  //                   //       fontWeight: FontWeight.w600),
  //                   // ),
  //                   // Wrap(
  //                   //   spacing: 10,
  //                   //   runSpacing: 10,
  //                   //   children: List.generate(
  //                   //     3,
  //                   //     (index) => FilterButton(content: 'New'),
  //                   //   ),
  //                   // ),
  //                   // SizedBox(
  //                   //   height: 5,
  //                   // ),
  //                   Text(
  //                     'Price',
  //                     style: GoogleFonts.inter(
  //                         fontSize: 16,
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   SizedBox(
  //                     width: double.infinity,
  //                     child: Row(
  //                       children: [
  //                         Text(
  //                           '\$ 0',
  //                           style: GoogleFonts.inter(
  //                               fontSize: 16,
  //                               color: Colors.grey,
  //                               fontWeight: FontWeight.w500),
  //                         ),
  //                         SizedBox(
  //                           width: sized.width * 0.3,
  //                         ),
  //                         Align(
  //                           alignment: Alignment.center,
  //                           child: Text(
  //                             'to',
  //                             style: GoogleFonts.inter(
  //                                 fontSize: 16,
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: sized.width * 0.3,
  //                         ),
  //                         Align(
  //                           alignment: Alignment.centerRight,
  //                           child: Text(
  //                             '\$ 10000',
  //                             style: GoogleFonts.inter(
  //                                 fontSize: 16,
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //
  //                   RangeSlider(
  //                     values: values,
  //                     divisions: 10,
  //                     min: 0,
  //                     max: 10000,
  //                     labels: RangeLabels(
  //                       values.start.round().toString(),
  //                       values.end.round().toString(),
  //                     ),
  //                     activeColor: redColor,
  //                     inactiveColor: Colors.grey,
  //                     onChanged: (newValues) {
  //                       setState(() {
  //                         values = newValues;
  //                       });
  //                     },
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   Row(
  //                     children: [
  //                       SizedBox(width: 20),
  //                       ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           padding:
  //                           EdgeInsets.symmetric(vertical: 10, horizontal: 50),
  //                           backgroundColor: Colors.white,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12),
  //                             side: BorderSide(color: redColor, width: 2),
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: Text(
  //                           'Reset',
  //                           style: GoogleFonts.inter(
  //                               fontSize: 16,
  //                               color: redColor,
  //                               fontWeight: FontWeight.w600),
  //                         ),
  //                       ),
  //                       SizedBox(width: 40),
  //                       ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           padding:
  //                           EdgeInsets.symmetric(vertical: 10, horizontal: 50),
  //                           backgroundColor: redColor,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12),
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           setState(() {
  //                             Navigator.pop(context);
  //                           });
  //
  //                         },
  //                         child: Text(
  //                           'Apply',
  //                           style: GoogleFonts.inter(
  //                               fontSize: 16,
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.w600),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 20,)
  //                 ],
  //               ),
  //             );
  //           }
  //         );
  //       });
  // }

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
                    width: size.width * 0.87,
                    child: CupertinoSearchTextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      style: TextStyle(color: Colors.white),
                      backgroundColor: Color(0xFF44484B),
                      borderRadius: BorderRadius.circular(30),
                      itemColor: Colors.white,
                      itemSize: 25,
                      onChanged: (value) {
                        _filterProducts();
                      },
                    ),
                  ),
                  // IconButton(
                  //     onPressed: () {
                  //       _displayBottomSheet();
                  //     },
                  //     icon: Icon(
                  //       Icons.filter_alt_outlined,
                  //       color: Colors.white,
                  //       size: 30,
                  //     ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
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
                          isClickPrice = false;
                          isClickNewest = false;
                          // isClickBest = false;
                          isClickRelated = true;
                          _sortProducts();
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
                          isClickPrice = false;
                          isClickRelated = false;
                          // isClickBest = false;
                          isClickNewest = true;
                          _sortProducts();
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
                    // VerticalDivider(
                    //   color: Colors.white,
                    //   thickness: 3,
                    //   width: 15,
                    // ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    //     backgroundColor: isClickBest ? redColor : blackColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //       isClickRelated = false;
                    //       isClickBest = true;
                    //       isClickNewest = false;
                    //     });
                    //   },
                    //   child: Text(
                    //     'Best Selling',
                    //     style: GoogleFonts.inter(
                    //         fontSize: 12,
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 3,
                      width: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        backgroundColor: isClickPrice ? redColor : blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isClickPrice = true;
                          isClickRelated = false;
                          // isClickBest = false;
                          isClickNewest = false;
                          isClickDown = !isClickDown;
                          _sortProducts();
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
              Wrap(
                spacing: 15,
                runSpacing: 20,
                children: _filteredProducts.map((product) =>
                SubProductButton(
                  subimage: product.image,
                  title: product.title,
                  rating: product.rate,
                  price: product.price,
                  discountPrice: product.discountPrice,
                  product: product,
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
