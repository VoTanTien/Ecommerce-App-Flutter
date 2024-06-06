import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/order_product.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/screens/choose_address.dart';
import 'package:t_t_project/screens/success.dart';

var shipfee = 10;
var price = 2000;
var total = 2010;
class orderScreen extends StatefulWidget{
  @override
  State<orderScreen> createState() => _orderScreenState();
}
class _orderScreenState extends State<orderScreen> {
  bool checkCodmethod = false;
  bool checkCreditmethod = false;

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
                      Address(),
                      Divider(
                        color: Colors.white,
                        height: 20,
                        thickness: 1,
                      ),
                      ProductItem(),
                      SizedBox(
                        height: 10,
                      ),
                      // Payment Method
                      Card(
                        color: greyColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Payment method',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.white,)
                              ),
                              leading: Icon(Icons.monetization_on_outlined, color: Colors.white,),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Checkbox(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                    side: BorderSide(color: Colors.white, width: 2),
                                    activeColor: redColor,
                                    value: checkCodmethod,
                                    onChanged:(bool? value){
                                  setState(() {
                                    checkCreditmethod = false;
                                    checkCodmethod = value!;
                                  });
                                }
                                ),
                                Icon(Icons.local_shipping_outlined, color: Colors.white,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Cash on delivery',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.white,)
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Checkbox(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                    side: BorderSide(color: Colors.white, width: 2),
                                    activeColor: redColor,
                                    value: checkCreditmethod,
                                    onChanged:(bool? value){
                                  setState(() {
                                    checkCodmethod = false;
                                    checkCreditmethod = value!;
                                  });
                                }
                                ),
                                Icon(Icons.credit_card, color: Colors.white,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Pay by credit card',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.white,)
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PaymentDetail(),
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
                                  '\$$total',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: redColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(width: 10,),
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
                                Navigator.push(context, MaterialPageRoute(builder: (cntext) => successScreen()));
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
class Address extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Delivery address',
          style: GoogleFonts.inter(
            fontSize: 22,
            color: Colors.white,)
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Text('Vo Tan Tien',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,),
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                  width: 15,
                ),
                Text('0379743117',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,),
                ),
              ],
            ),
          ),
          Text('Street A, District 7, Ho Chi Minh City',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white,),
          ),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
      leading: Icon(Icons.location_on_outlined, color: Colors.white, size: 35,),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (cntext) => AddressScreen()));
      },
    );
  }
}
class ProductItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      runSpacing: 10,
      children: List.generate(
        3, (index) => OrderItem(
          subimage: AssetImage(lt4s),
          price: 1000,
          option: 'White',
          title: 'Laptop ASUS Zenbook 14 OLED UX3402VA KM085W',
          quantity: 1),
      ),
    );
  }
}
class PaymentDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Card(
      color: greyColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            title: Text('Payment detail',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,)
            ),
            leading: Icon(Icons.receipt_long_outlined, color: Colors.white,),
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
                          color: Colors.white,)
                    ),
                    Text('\$$shipfee',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,)
                    ),
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
                          color: Colors.white,)
                    ),
                    Text('\$$price',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,)
                    ),
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
                          color: Colors.white,)
                    ),
                    Text('\$$total',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: redColor,)
                    ),
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