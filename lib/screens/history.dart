import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/history_product.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/screens/product_detail.dart';

import '../objects/order_item_data.dart';
import '../services/database_service.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isClickDown = true;
  bool isClickNewest = true;
  bool isClickPrice = false;
  List<OrderItemData> _orderItems = [];
  List<OrderItemData> _filteredOrderItems = [];

  @override
  void initState() {
    super.initState();
    _loadOderItems();
  }

  Future<void> _loadOderItems() async {
    final orderItems = await DatabaseService().getOrderItems();
    setState(() {
      _orderItems = List.from(orderItems);
      _filteredOrderItems = List.from(_orderItems.reversed);
    });
  }

  void _sortOrder() {
    if (isClickNewest)
      {
        _filteredOrderItems = List.from(_orderItems.reversed);
      } else if (isClickPrice)
        {
          _filteredOrderItems.sort((a, b) => (isClickDown
              ? (b.orderProduct.price * b.orderProduct.quantity).compareTo(a.orderProduct.price * a.orderProduct.quantity)  // Descending
              : (a.orderProduct.price * a.orderProduct.quantity).compareTo(b.orderProduct.price * b.orderProduct.quantity)  // Ascending
          ));
        }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          title: Text('History Of Purchases',
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
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          backgroundColor: isClickNewest ? redColor : blackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isClickPrice = false;
                            isClickNewest = true;
                            _sortOrder();
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
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                        width: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          backgroundColor: isClickPrice ? redColor : blackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isClickDown = !isClickDown;
                            isClickPrice = true;
                            isClickNewest = false;
                            _sortOrder();
                          });
                        },
                        child: Text(
                          'Price',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(
                        isClickDown
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 0,
                  runSpacing: 10,
                  children: _filteredOrderItems.map((e) {
                    return HistoryItem(
                        product: e.product,
                        price: e.orderProduct.price,
                        option: e.orderProduct.option,
                        quantity: e.orderProduct.quantity,
                    );
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
