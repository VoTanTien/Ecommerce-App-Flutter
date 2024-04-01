import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:input_quantity/input_quantity.dart';



class CartItem extends StatefulWidget {
  final subimage;
  final title;
  final price;
  final option;
  final quantity;
  const CartItem({Key? key, required this.subimage, required this.price, required this.option, required this.title, required this.quantity }) : super(key: key) ;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool isChecked = false;
  var _subimage;
  var _title;
  var _price;
  var _option;
  var _quantity;
  @override
  void initState() {
    _subimage = widget.subimage;
    _title = widget.title;
    _price = widget.price;
    _option = widget.option;
    _quantity = widget.quantity;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                  value: isChecked,
                  side: BorderSide(color: greyColor, width: 2),
                  activeColor: Colors.red,
                  onChanged: (val) {
                    setState(() {
                      isChecked = val!;
                    });
                  }),
            ),
            Container(
              width: 330,
              child: Card(
                color: greyColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 12, 2),
                  child: Row(
                    children: [
                      Image(
                        image: _subimage,
                        width: 110,
                        height: 110,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _title,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Color: $_option',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '\$ $_price',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 4,
          top: 60,
          child: InputQty(
            qtyFormProps: QtyFormProps(enableTyping: false),
            decoration: QtyDecorationProps(
                iconColor: Colors.white,
                fillColor: redColor,
                btnColor: Colors.white,
                isBordered: false,
                width: 5
            ),
            maxVal: 100,
            initVal: _quantity,
            minVal: 0,
            steps: 1,
            onQtyChanged: (val) {
            },
          ),
        ),
      ],
    );
  }
}
