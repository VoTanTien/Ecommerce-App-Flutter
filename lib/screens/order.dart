import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/order_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/objects/address.dart';
import 'package:t_t_project/objects/address_manager.dart';
import 'package:t_t_project/screens/choose_address.dart';
import 'package:t_t_project/screens/order.dart';
import 'package:t_t_project/screens/success.dart';

import '../objects/cart_item_data.dart';
import '../services/database_service.dart';

class orderScreen extends StatefulWidget {
  final List<CartItemData> cartItems; // Receive cartItems

  const orderScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<orderScreen> createState() => _orderScreenState();
}

class _orderScreenState extends State<orderScreen> {
  int shipFee = 10;
  int productPrice = 0;
  int total = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotal(); // Calculate total on initialization.
  }

  void _calculateTotal() {
    // Calculate productPrice from cartItems received
    setState(() {
      //Important: Wrap in setState to rebuild the widget.
      productPrice = widget.cartItems.fold(
          0,
          (sum, item) =>
              sum +
              (item.product.discountPrice ?? item.product.price) *
                  item.cartProduct.quantity);
      total = productPrice + shipFee; // Calculate total price
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          title: Text('Payments',
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
        body: Column(
          children: [
            Container(
              height: 700,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  children: [
                    //display address
                    AddressField(),
                    Divider(
                      color: Colors.white,
                      height: 20,
                      thickness: 1,
                    ),
                    // Display oder items
                    Wrap(
                      spacing: 0,
                      runSpacing: 10,
                      children: widget.cartItems.map((cartItemData) {
                        // Use widget.cartItems
                        return OrderItem(
                          // Assuming you have an OrderItem widget
                          cartItemData: cartItemData,
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // display Payment Method
                    PaymentMethod(),
                    SizedBox(
                      height: 10,
                    ),
                    // display payment detail
                    PaymentDetail(
                        productPrice: productPrice,
                        total: total,
                        shipFee: shipFee),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 68,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total Price:',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: greyColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\$ $total',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: redColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              backgroundColor: redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async{
                              try {
                                await DatabaseService().createOrdersFromCart(widget.cartItems);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => successScreen()),
                                );
                              } catch (e) {
                                // Handle the error, e.g., show a SnackBar or dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error creating order: $e')),
                                );
                              }
                            },
                            child: Text(
                              'Buy now',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethod extends StatefulWidget {
  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool checkCodmethod = true;

  bool checkCreditmethod = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: greyColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            title: Text('Payment method',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                )),
            leading: Icon(
              Icons.monetization_on_outlined,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  side: BorderSide(color: Colors.white, width: 2),
                  activeColor: redColor,
                  value: checkCodmethod,
                  onChanged: (bool? value) {
                    setState(() {
                      checkCreditmethod = false;
                      checkCodmethod = value!;
                    });
                  }),
              Icon(
                Icons.local_shipping_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Cash on delivery',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  side: BorderSide(color: Colors.white, width: 2),
                  activeColor: redColor,
                  value: checkCreditmethod,
                  onChanged: (bool? value) {
                    setState(() {
                      checkCodmethod = false;
                      checkCreditmethod = value!;
                    });
                  }),
              Icon(
                Icons.credit_card,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Pay by credit card',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

//---------------
class AddressField extends StatefulWidget {
  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  AddressManager addressManager = AddressManager();

  late Address a;

  Address getDefault() {
    for (var e in addressManager.addresses) {
      if (e.isDefault == true) {
        return e;
      }
    }
    return addressManager.addresses[0];
  }

  @override
  void initState() {
    super.initState();
    a = getDefault();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Delivery address',
          style: GoogleFonts.inter(
            fontSize: 22,
            color: Colors.white,
          )),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Text(
                  a.name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                  width: 15,
                ),
                Text(
                  a.phone,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Text(
            a.address,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
      leading: Icon(
        Icons.location_on_outlined,
        color: Colors.white,
        size: 35,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddressScreen()));
      },
    );
  }
}

//---------------
class PaymentDetail extends StatelessWidget {
  final int productPrice;
  final int total;
  final shipFee;

  const PaymentDetail(
      {Key? key,
      required this.productPrice,
      required this.total,
      required this.shipFee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: greyColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            title: Text('Payment detail',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                )),
            leading: Icon(
              Icons.receipt_long_outlined,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping fee',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                    Text('\$$shipFee',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Product price',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                    Text('\$$productPrice',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                    Text('\$ $total',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: redColor,
                        )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
