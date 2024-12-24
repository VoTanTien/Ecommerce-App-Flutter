import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t_t_project/screens/choose_address.dart';
import 'package:t_t_project/screens/home.dart';
import 'package:t_t_project/screens/liked.dart';
import 'package:t_t_project/screens/loginscreens/login.dart';
import 'package:t_t_project/screens/loginscreens/start.dart';
import 'package:t_t_project/screens/new_address.dart';
import 'package:t_t_project/screens/order.dart';
import 'package:t_t_project/screens/otp.dart';
import 'package:t_t_project/screens/pin_entry.dart';
import 'package:t_t_project/screens/product_detail.dart';
import 'package:t_t_project/screens/success.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:t_t_project/services/auth_service.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: SafeArea(
        child: StreamBuilder(
            stream: AuthService().authChanges,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.hasData){
                return homeScreen();
                // return PinEntryScreen();
                // return OtpScreen(phone: '+84379743117',);
              }
              return loginScreen();
            },
          ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// class MyApp extends StatelessWidget {
//   final AuthService _authService = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SafeArea(
//         child: _authService.handleAuthState(context),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
