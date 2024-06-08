import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:t_t_project/common_widget/card_product.dart';
import 'package:t_t_project/common_widget/review_item.dart';
import 'package:t_t_project/common_widget/sub_product_button.dart';
import 'package:t_t_project/common_widget/technical_parameter.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/screens/list_reviews.dart';
import 'package:t_t_project/screens/order.dart';

var image = AssetImage(lt4);
var subimage = AssetImage(lt4s);
var title = 'Laptop ASUS Zenbook 14 OLED UX3402VA KM085W';
var option = 'White';
var description = 'Logitech G733 LIGHTSPEED Wireless White line of computer headsets is designed with gamers in mind. These are wireless headphones packed with the stereophonic sound, sound filters, and advanced lighting features you need to look, speak, and play in style like never before.';
var price = 1000;
var discountPrice = 999;
bool isLiked = false;
double initRating = 4.0;
int countReview = 20;
int quantity = 1;
class productDetailScreen extends StatefulWidget{
  @override
  State<productDetailScreen> createState() => _productDetailScreenState();
}

class _productDetailScreenState extends State<productDetailScreen> {

  _displayBottomSheet(int role){
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CardProductItem(
                        subimage: AssetImage(lt1s),
                        title: 'Laptop ASUS Vivobook 15 X1502ZA BQ127W',
                        price: discountPrice == null ? price : discountPrice,
                        option: 'White',
                      ),
                      Divider(color: greyColor, thickness: 1, height: 10,),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,),
                          ),
                          InputQty(
                            qtyFormProps: QtyFormProps(enableTyping: false),
                            decoration: QtyDecorationProps(
                              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                iconColor: Colors.white,
                                fillColor: Colors.white,
                                btnColor: Colors.black,
                                isBordered: true,
                                border: OutlineInputBorder(borderSide: BorderSide(color: redColor, width: 2)),
                                width: 15
                            ),
                            maxVal: 100,
                            initVal: 1,
                            minVal: 1,
                            steps: 1,
                            onQtyChanged: (val) {
                              quantity = val;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),

                      role == 1
                          ?
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            backgroundColor: redColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => orderScreen()));
                          },
                          child: Text(
                            'Buy Now',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                          :
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            backgroundColor: redColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {

                          },
                          child: Text(
                            'Add to Cart',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
          });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blackColor,
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Container(
              color: blackColor,
              width: size.width,
              height: size.height * 0.81,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: image,
                      height: size.height * 0.31,
                      width: size.width * 0.85,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: greyColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.inter(
                                fontSize: 22,
                              fontWeight: FontWeight.w700,
                                color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10,),
                          RatingBar(
                            itemSize: 25,
                            minRating: 1,
                            maxRating: 5,
                            initialRating: initRating,
                            allowHalfRating: true,
                            onRatingUpdate: (i) {},
                            ratingWidget: RatingWidget(
                              full: Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              half: Icon(
                                Icons.star_border_outlined,
                                color: Colors.amber,
                              ),
                              empty: Icon(
                                Icons.star_border_outlined,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              discountPrice == null ?
                              Text(
                                '\$$price',
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                                  :
                              Row(
                                children: [
                                  Text(
                                    '\$$discountPrice  ',
                                    style: GoogleFonts.inter(
                                        fontSize: 22,
                                        color: redColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '\$$price',
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        isLiked = !isLiked;
                                      });
                                    },
                                    child: !isLiked
                                        ? Icon(Icons.favorite_border_outlined, color: Colors.white, size: 27,)
                                        : Icon(Icons.favorite, color: redColor, size: 27,),
                                  ),
                                  SizedBox(width: 10,),
                                  Icon(Icons.share, color: Colors.white, size: 27,),
                                ],
                              ),
                            ],
                          ),
                          Divider(color: Colors.white, thickness: 1, height: 20,),
                          Text(
                            'Technical parameters',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            width: double.infinity,
                            child:Wrap(
                              spacing: 0,
                              runSpacing: 5,
                              children: List.generate(4, (index) => Parameters(
                                subtitle: '1TB M.2 NVMe PCIe 4.0 Performance SSD (1 slot)',
                                title: 'Storage_drive',
                              ),
                              ),
                            ),
                          ),
                          Divider(color: Colors.white, thickness: 1, height: 20,),
                          Text(
                            'Describe',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            child: Text(
                              description,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white, thickness: 1, height: 20,),
                          Reviews(),
                          Divider(color: Colors.white, thickness: 1, height: 20,),
                          SimilarProduct(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height * 0.19,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: redColor, width: 2),
                          ),
                          onPressed: () {
                            _displayBottomSheet(0);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add_shopping_cart_outlined, color: redColor,),
                              Text(
                                'Add to Cart',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: redColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            backgroundColor: redColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            _displayBottomSheet(1);
                          },
                          child: Text(
                            'Buy Now',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
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

class Reviews extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Reviews',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,),
        ),
        Row(
          children: [
            Text(
              '$initRating ',
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,),
            ),
            RatingBar(
              itemSize: 16,
              minRating: 1,
              maxRating: 5,
              initialRating: initRating,
              allowHalfRating: true,
              onRatingUpdate: (i) {},
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                half: Icon(
                  Icons.star_border_outlined,
                  color: Colors.amber,
                ),
                empty: Icon(
                  Icons.star_border_outlined,
                  color: Colors.amber,
                ),
              ),
            ),
            Text(
              '  ($countReview Reviews)',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,),
            ),
          ],
        ),
        Wrap(
          spacing: 0,
          runSpacing: 5,
          children: List.generate(2, (index) => ReviewItem(
            user: 'VoTanTien',
            initRating: initRating,
            title: 'Nice product and very good quality',
            image: null,
          ),
          ),
        ),
        ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          title: Text(
            'Show more >>',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => reviewScreen()));
          },
        )
      ],
    );
  }

}

class SimilarProduct extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Similar products',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,),
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          children: List.generate(4, (index) => SubProductButton(
            subimage: AssetImage(lt1s),
            title: 'Laptop ASUS Vivobook 15 X1502ZA BQ127W',
            rating: 4,
            price: 1000,
            discountPrice: 999,
          ),
          ),
        ),
      ],
    );
  }

}
