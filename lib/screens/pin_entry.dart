import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sha3/sha3.dart';
import 'package:t_t_project/screens/success.dart';

import '../constants/colors.dart';
import '../services/database_service.dart';
import 'otp.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _attemptsLeft = 5;
  String phone = '+84379743117';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyPIN(String pin) async {
    final databaseService = DatabaseService();
    final userData = await databaseService.getUserData();
    final storedSalt = userData['salt'];
    final storedHashedPIN = userData['hashedPIN'];
    bool isFamiliar = true;

    // Hash the entered PIN with the stored salt
    print('Entered PIN: $pin');
    final enteredHashedPIN = hashPIN(pin, storedSalt!);

    if (enteredHashedPIN == storedHashedPIN) {
      isFamiliar ? Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => successScreen()),
      ) : Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(phone: phone,)),
      );
    } else {
      setState(() {
        _attemptsLeft--;
        if (_attemptsLeft == 0) {
          _lockUser();
        }
      });
      _pinController.clear();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Invalid PIN. Try Again!')),
      // );
    }
  }

  void _lockUser() {
    print('User locked due to too many failed attempts');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('PIN Locked 30 minutes'),
        content: Text('You have entered the wrong PIN too many times.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  String hashPIN(String PIN, String salt) {
    final k = SHA3(256, SHA3_PADDING, 256);
    k.update(utf8.encode(PIN + salt));
    return k.digest().map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: Text('Enter PIN',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your PIN to payment',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                      color: _pinController.text.length > index
                          ? redColor
                          : Colors.transparent,
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _pinController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                cursorColor: Colors.transparent,
                style: TextStyle(color: Colors.transparent, fontSize: 1),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                onChanged: (value) {
                  setState(() {});
                  if (value.length == 6) {
                    _verifyPIN(value);
                  }
                },
              ),
              _attemptsLeft < 5
                  ? Text(
                      'PIN code is incorrect. You have $_attemptsLeft entries left',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: redColor,
                          fontWeight: FontWeight.w500),
                    )
                  : SizedBox(
                      height: 10,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
