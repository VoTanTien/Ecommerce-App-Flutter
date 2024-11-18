import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:input_quantity/input_quantity.dart';

import '../objects/cart_item_data.dart';

class CartItem extends StatefulWidget {
  final CartItemData cartItemData;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<bool> onCartItemChecked; // Callback to parent
  const CartItem({
    Key? key,
    required this.cartItemData,
    required this.onQuantityChanged,
    required this.onCartItemChecked,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                  value: widget.cartItemData.cartProduct.isChecked,
                  side: BorderSide(color: greyColor, width: 2),
                  activeColor: Colors.red,
                  onChanged: (val) {
                    setState(() {
                      widget.cartItemData.cartProduct.isChecked = val!;  // Access through cartItemData
                      widget.onCartItemChecked(val);
                    });
                  }),
            ),
            Container(
              width: size.width * 0.78,
              child: Card(
                color: greyColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 12, 2),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: widget.cartItemData.product.image,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              // Widget to show while loading
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              // Widget to show if an error occurs
                              width: 80,
                              height: 85,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.cartItemData.product.title,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Option: ${widget.cartItemData.cartProduct.option}',
                              style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$ ${widget.cartItemData.product.discountPrice ?? widget.cartItemData.product.price}',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
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
          top: 48,
          child: InputQty(
            qtyFormProps: QtyFormProps(enableTyping: false),
            decoration: QtyDecorationProps(
                iconColor: Colors.white,
                fillColor: redColor,
                btnColor: Colors.white,
                isBordered: false,
                width: 5),
            maxVal: 100,
            initVal: widget.cartItemData.cartProduct.quantity,
            minVal: 1,
            steps: 1,
            onQtyChanged: (value) {
              widget.cartItemData.cartProduct.quantity = value.toInt();
              widget.onQuantityChanged(value.toInt());
            },
          ),
        ),
      ],
    );
  }
}
