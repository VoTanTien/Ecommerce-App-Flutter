import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:t_t_project/common_widget/card_product.dart';
import 'package:t_t_project/common_widget/review_item.dart';
import 'package:t_t_project/common_widget/sub_product_button.dart';
import 'package:t_t_project/common_widget/technical_parameter.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/objects/parameters.dart';
import 'package:t_t_project/screens/cart.dart';
import 'package:t_t_project/screens/list_reviews.dart';
import 'package:t_t_project/screens/order.dart';

import '../objects/cart_item_data.dart';
import '../objects/cart_product.dart';
import '../objects/product.dart';
import '../objects/comment.dart';
import '../services/database_service.dart';

// bool isLiked = false;


class productDetailScreen extends StatefulWidget {
  final Product product;

  const productDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<productDetailScreen> createState() => _productDetailScreenState();
}

class _productDetailScreenState extends State<productDetailScreen> {
  List<Parameter> listpara = [];
  List<CommentData> _comments = [];
  double _averageRating = 0.0;
  num quantity = 1;

  @override
  void initState() {
    super.initState();
    listpara
        .add(Parameter('CPU', 'Intel Core i7-12700H 2.3GHz up to 4.7GHz 24MB'));
    listpara
        .add(Parameter('Graphic_card', 'NVIDIA GeForce RTX 3050Ti 4GB GDDR6'));
    listpara.add(Parameter('RAM', '16GB Onboard LPDDR5'));
    listpara.add(
        Parameter('Storage', '1TB M.2 NVMe PCIe 4.0 Performance SSD (1 slot)'));
    listpara.add(Parameter(
        'Screen', '16 inch 4K (3840 x 2400) OLED 16:10 aspect ratio'));
    listpara.add(Parameter('Battery', '6 Cells 96WHrs'));
    listpara.add(Parameter(
        'Communication', '1x Thunderbolt 4 supports display / power delivery'));
    listpara.add(Parameter('Color', 'Cool Silver Aluminum'));
    _loadComments();
  }

  Future<void> _loadComments() async {
    final comments =
        await DatabaseService().getCommentsForProduct(widget.product.id);
    setState(() {
      _comments = comments;
      _calculateAverageRating();
    });
  }
  void _calculateAverageRating() { // No longer needs to be in initState.
    if (_comments.isNotEmpty) { // Use _comments, not widget.comments
      double sum = 0;
      for (var comment in _comments) {
        sum += comment.rate.toDouble(); // Cast to double
      }
      _averageRating = sum / _comments.length;
    }
  }

  _displayBottomSheet(int role) {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
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
                    subimage: widget.product.image,
                    title: widget.product.title,
                    price: widget.product.discountPrice ?? widget.product.price,
                    option: widget.product.option,
                  ),
                  Divider(
                    color: greyColor,
                    thickness: 1,
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      InputQty(
                        qtyFormProps: QtyFormProps(enableTyping: false),
                        decoration: QtyDecorationProps(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            iconColor: Colors.white,
                            fillColor: Colors.white,
                            btnColor: Colors.black,
                            isBordered: true,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: redColor, width: 2)),
                            width: 12),
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
                  SizedBox(
                    height: 20,
                  ),
                  role == 1
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              backgroundColor: redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              const option1 = 'Keychain';
                              final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
                              final CartProduct cartProduct = CartProduct(uid: uid, productId: widget.product.id, quantity: quantity.toInt(), option: option1);
                              final List<CartItemData> buyItems =[];
                              buyItems.add(CartItemData(cartProduct: cartProduct, product: widget.product));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => orderScreen(cartItems: buyItems,)));
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
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              backgroundColor: redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              const option = 'No Keychain';
                              int intQuantity = quantity.toInt();
                              await DatabaseService().addToCart(widget.product.id, intQuantity, option, context);
                              Navigator.pop(context);
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
        });
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
          title: Text('Product Detail',
              style: GoogleFonts.inter(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
                        placeholder: (context, url) => CircularProgressIndicator(), // Widget to show while loading
                        errorWidget: (context, url, error) => Icon(Icons.error), // Widget to show if an error occurs
                        width: size.width * 0.8,
                        height: size.height * 0.45,
                        fit: BoxFit.cover,
                      )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: greyColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.title,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RatingBar(
                            itemSize: 25,
                            minRating: 1,
                            maxRating: 5,
                            initialRating: _averageRating,
                            allowHalfRating: true,
                            ignoreGestures: true,
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
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.product.discountPrice == null
                                  ? Text(
                                      '\$${widget.product.price}',
                                      style: GoogleFonts.inter(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          '\$${widget.product.discountPrice}  ',
                                          style: GoogleFonts.inter(
                                              fontSize: 22,
                                              color: redColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '\$${widget.product.price}',
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                              // Row(
                              //   children: [
                              //     InkWell(
                              //       onTap: (){
                              //         setState(() {
                              //           isLiked = !isLiked;
                              //         });
                              //       },
                              //       child: !isLiked
                              //           ? Icon(Icons.favorite_border_outlined, color: Colors.white, size: 27,)
                              //           : Icon(Icons.favorite, color: redColor, size: 27,),
                              //     ),
                              //     SizedBox(width: 10,),
                              //     Icon(Icons.share, color: Colors.white, size: 27,),
                              //   ],
                              // ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            height: 20,
                          ),
                          Text(
                            'Technical parameters',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            width: double.infinity,
                            child: Wrap(
                                spacing: 0,
                                runSpacing: 5,
                                children: listpara
                                    .map(
                                      (e) => Parameters(
                                        title: e.title,
                                        subtitle: e.detail,
                                      ),
                                    )
                                    .toList()),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            height: 20,
                          ),
                          Text(
                            'Describe',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: Text(
                              widget.product.describe,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            height: 20,
                          ),
                          Reviews(
                            comments: _comments,
                            averageRating: _averageRating,
                          ),
                          // Divider(color: Colors.white, thickness: 1, height: 20,),
                          // SimilarProduct(),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
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
                              Icon(
                                Icons.add_shopping_cart_outlined,
                                color: redColor,
                              ),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
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

class Reviews extends StatelessWidget {
  final List<CommentData> comments;
  final double averageRating;
  const Reviews({Key? key, required this.comments, required this.averageRating}) : super(key: key);

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
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Text(
              '${averageRating.toStringAsFixed(1)} / 5.0 ',
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            RatingBar(
              itemSize: 16,
              minRating: 1,
              maxRating: 5,
              initialRating: averageRating,
              allowHalfRating: true,
              ignoreGestures: true,
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
              '  (${comments.length} Reviews)',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Wrap(
            spacing: 0,
            runSpacing: 5,
            children: comments // Use comments list here
                .take(2)
                .map(
                  (e) => ReviewItem(
                    user: e.userName, // Access the correct userName field
                    initRating: e.rate,
                    title: e.title,
                    image: e.image,
                  ),
                )
                .toList()),
        ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          title: Text(
            'Show more >>',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => reviewScreen(
                  comments: comments,
                  averageRating: averageRating,
                  countReview: comments.length,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

// class SimilarProduct extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Similar products',
//           style: GoogleFonts.inter(
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Wrap(
//             spacing: 15,
//             runSpacing: 10,
//             children: productManager.products
//                 .map(
//                   (e) => SubProductButton(
//                     subimage: e.image,
//                     title: e.title,
//                     rating: 5,
//                     price: e.price,
//                     discountPrice: e.discountPrice,
//                   ),
//                 )
//                 .toList()),
//       ],
//     );
//   }
// }
