import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:t_t_project/common_widget/assessment_item.dart';
import 'package:t_t_project/objects/assessment_item_data.dart';

import '../objects/cart_item_data.dart';
import '../objects/cart_product.dart';
import '../objects/order_item_data.dart';
import '../objects/order_product.dart';
import '../objects/product.dart';
import '../objects/user.dart';
import '../objects/comment.dart';

class DatabaseService{
  final _databaseRef = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, String>> getUserData() async {
    try {
      final userId = _auth.currentUser!.uid;
      final snapshot = await _databaseRef.child('Users').child(userId).get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return {
          'name': data['name'] ?? '',
          'email': data['email'] ?? '',
          'phone': data['phone'] ?? '',
        };
      } else {
        throw Exception("User data not found");
      }
    } catch (e) {
      print("Error fetching user data: $e");
      rethrow;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await _databaseRef.child('Products').get();
      if (snapshot.exists) {
        final productList = <Product>[];
        for (final child in snapshot.children) {
          final productData = Map<String, dynamic>.from(child.value as Map);
          productList.add(Product.fromMap(productData, int.parse(child.key!)));
        }
        return productList;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  // Helper function to fetch user data by ID
  Future<UserData?> _getUserDataById(String userId) async {
    try {
      final snapshot = await _databaseRef.child('Users/$userId').get();
      if (snapshot.exists) {
        final userData = Map<String, dynamic>.from(snapshot.value as Map);
        return UserData(
          name: userData['name']?.toString(),
          email: userData['email']?.toString(),
          phone: userData['phone']?.toString(),
          uid: userId,
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data by ID: $e");
      return null;
    }
  }

  Future<List<CommentData>> getCommentsForProduct(int productId) async {
    try {
      final commentsRef = _databaseRef.child('Comments');
      final snapshot = await commentsRef
          .orderByChild('productid')
          .equalTo(productId)
          .get();

      if (snapshot.exists) {
        final commentList = <CommentData>[];
        final userFutures = <Future<UserData?>>[]; // Store futures for user data

        for (final child in snapshot.children) {
          final commentData = Map<String, dynamic>.from(child.value as Map);
          final userId = commentData['uid']; // Assuming you store userId in comments

          // Fetch user data for each comment concurrently
          userFutures.add(_getUserDataById(userId));

          // Create comment object with temporary userName (will be updated later)
          commentList.add(CommentData(
            userName: '', // Placeholder, will be updated
            productId: commentData['productid']?.toInt() ?? 0,
            rate: (commentData['rate'] as num?)?.toDouble() ?? 0.0,
            title: commentData['title'] ?? '',
            image: commentData['image']?.toString(),
          ));
        }

        // Wait for all user data futures to complete
        final users = await Future.wait(userFutures);
        //Update userName for each comment
        for (var i = 0; i < commentList.length; i++) {
          commentList[i].userName = users[i]?.name ?? 'Unknown User';
        }

        return commentList;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching comments: $e");
      return [];
    }
  }

  Future<List<CartProduct>> _getCartProductsForUser(String uid) async {
    try {
      final cartSnapshot = await _databaseRef
          .child('Carts')
          .orderByChild('uid')
          .equalTo(uid)
          .get();

      if (cartSnapshot.exists) {
        final cartProducts = <CartProduct>[];
        for (final child in cartSnapshot.children) {
          final cartProductData = Map<String, dynamic>.from(child.value as Map);
          cartProducts.add(CartProduct(
            uid: cartProductData['uid'] ?? '',
            productId: cartProductData['productid']?.toInt() ?? 0,
            quantity: cartProductData['quantity']?.toInt() ?? 0,
            option: cartProductData['option']?.toString(),
          ));
        }
        return cartProducts;
      } else {
        return []; // Return an empty list if no cart products found
      }
    } catch (e) {
      print("Error fetching cart products: $e");
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<CartItemData>> getCartItems() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return [];

      final cartProducts = await _getCartProductsForUser(uid);
      if (cartProducts.isEmpty) return [];

      final cartItemsData = <CartItemData>[];
      for (final cartProduct in cartProducts) {
        final productId = cartProduct.productId;
        final productSnapshot = await _databaseRef
            .child('Products/$productId')
            .get();

        if (productSnapshot.exists) {
          final productData = Map<String, dynamic>.from(productSnapshot.value as Map);
          final product = Product.fromMap(productData, productId);
          cartItemsData.add(CartItemData(cartProduct: cartProduct, product: product));
        }
      }

      return cartItemsData;
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  Future<void> createOrdersFromCart(List<CartItemData> cartItems) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final ordersRef = _databaseRef.child('Orders');
      final newOrderKeyBase = ordersRef.push().key;  // Generate a base key

      final now = DateTime.now();
      final date = DateFormat('yyyy-MM-dd').format(now);
      final time = DateFormat('HH:mm:ss').format(now);

      for (var i = 0; i < cartItems.length; i++) {
        final newOrderKey = '$newOrderKeyBase-$i';
        await ordersRef.child(newOrderKey).set({
          'uid': uid,
          'productid': cartItems[i].product.id,
          'quantity': cartItems[i].cartProduct.quantity,
          'option': cartItems[i].cartProduct.option,
          'price': cartItems[i].product.discountPrice ?? cartItems[i].product.price,
          'date': date,
          'time': time,
        });
      }

      // After creating orders, you might want to clear the cart:
      // await clearCart(uid);  // Implement this function if needed.

    } catch (e) {
      print("Error creating orders: $e");
      rethrow; // Re-throw the error so the calling function can handle it
    }
  }

  Future<void> addToCart(int productId, int quantity, String option, BuildContext context) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final cartRef = _databaseRef.child('Carts');
      final existingCartsSnapshot = await cartRef.orderByChild('uid').equalTo(uid).once();

      if (existingCartsSnapshot.snapshot.exists) {
        bool itemExists = false;
        for (final cartDataSnapshot in existingCartsSnapshot.snapshot.children) {
          final cartData = Map<String, dynamic>.from(cartDataSnapshot.value as Map);
          if (cartData['productid'] == productId && cartData['option'] == option) {
            itemExists = true;

            Fluttertoast.showToast(
              msg: 'Product is already in the cart!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16,
            );
            break; // No need to continue checking
          }
        }

        if (!itemExists) {
          // Add new cart item
          final newCartKey = cartRef.push().key; // Generate a new key
          await cartRef.child(newCartKey!).set({
            'uid': uid,
            'productid': productId,
            'option': option,
            'quantity': quantity,
          });

          Fluttertoast.showToast(
            msg: 'Add to cart Successfully!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
      } else {
        final newCartKey = cartRef.push().key;
        await cartRef.child(newCartKey!).set({
          'uid': uid,
          'productid': productId,
          'option': option,
          'quantity': quantity,
        });

        Fluttertoast.showToast(
          msg: 'Add to cart Successfully!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16,
        );
      }

    } catch (e) {
      print("Error adding to cart: $e");
      // Handle error appropriately (e.g., show an error message)

    }
  }

  Future<List<OrderItemData>> getOrderItems() async { // Takes uid as an argument
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return [];

      final orderProducts = await _getOrderProductsForUser(uid); // Use provided uid
      if (orderProducts.isEmpty) return [];

      final orderItemsData = <OrderItemData>[];
      for (final orderProduct in orderProducts) {
        final productId = orderProduct.productId;
        final productSnapshot = await _databaseRef
            .child('Products/$productId')
            .get();

        if (productSnapshot.exists) {
          final productData = Map<String, dynamic>.from(productSnapshot.value as Map);
          final product = Product.fromMap(productData, productId);
          orderItemsData.add(OrderItemData(orderProduct: orderProduct, product: product));
        }
      }

      return orderItemsData;
    } catch (e) {
      print('Error fetching order items: $e');
      return [];
    }
  }

  Future<List<OrderProduct>> _getOrderProductsForUser(String uid) async {
    try {
      final ordersSnapshot = await _databaseRef
          .child('Orders')
          .orderByChild('uid')
          .equalTo(uid)
          .get();

      if (ordersSnapshot.exists) {
        final orderProducts = <OrderProduct>[];
        for (final child in ordersSnapshot.children) {
          final orderProductData = Map<String, dynamic>.from(child.value as Map);
          orderProducts.add(OrderProduct(
            date: orderProductData['date'] ?? '',
            uid: orderProductData['uid'] ?? '',
            productId: orderProductData['productid']?.toInt() ?? 0,
            quantity: orderProductData['quantity']?.toInt() ?? 0,
            price: orderProductData['price']?.toInt() ?? 0,
            option: orderProductData['option']?.toString(),
          ));
        }
        return orderProducts;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching order products: $e");
      return [];
    }
  }

  Future<List<AssessmentItemData>> getAssessmentItems() async { // Takes uid as an argument
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return [];
      final userData = await _getUserDataById(uid);
      final userName = userData?.name;

      final comments = await _getCommentForUser(uid, userName!); // Use provided uid
      if (comments.isEmpty) return [];

      final assessmentItemsData = <AssessmentItemData>[];
      for (final comment in comments) {
        final productId = comment.productId;
        final productSnapshot = await _databaseRef
            .child('Products/$productId')
            .get();

        if (productSnapshot.exists) {
          final productData = Map<String, dynamic>.from(productSnapshot.value as Map);
          final product = Product.fromMap(productData, productId);
          assessmentItemsData.add(AssessmentItemData(comment: comment, product: product));
        }
      }

      return assessmentItemsData;
    } catch (e) {
      print('Error fetching assessment items: $e');
      return [];
    }
  }

  Future<List<CommentData>> _getCommentForUser(String uid, String userName) async {
    try {
      final commentsSnapshot = await _databaseRef
          .child('Comments')
          .orderByChild('uid')
          .equalTo(uid)
          .get();

      if (commentsSnapshot.exists) {
        final comments = <CommentData>[];
        for (final child in commentsSnapshot.children) {
          final commentData = Map<String, dynamic>.from(child.value as Map);
          comments.add(CommentData(
            userName: userName ?? '',
            productId: commentData['productid']?.toInt() ?? 0,
            rate: (commentData['rate'] as num?)?.toDouble() ?? 0.0,
            title: commentData['title'] ?? '',
            image: commentData['image']?.toString(),
          ));
        }
        return comments;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching comments: $e");
      return [];
    }
  }

}