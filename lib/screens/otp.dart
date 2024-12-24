import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/screens/success.dart';
import 'package:t_t_project/services/otp_service.dart';

import '../services/database_service.dart';

class OtpScreen extends StatefulWidget {
  final phone;
  final isTrusted;
  const OtpScreen({Key? key, required this.phone, required this.isTrusted}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  FocusNode? _focusNode;
  int _countdown = 180;
  Timer? _timer;
  bool incorrect = false;
  bool verify = false;
  // late final response;

  // String username = "20522013@gm.uit.edu.vn";
  // String password = "Tienpro1234@";

  // late Map<String, dynamic> result;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode!.requestFocus();
    });
    // login();
    sendOTP();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  sendOTP() async {
    bool success = await OTPService.sendOtp(widget.phone);
    if(success){
      print("Success to send OTP");
    } else{
      print('Failed to send OTP (Screen)');
    }
  }

  // Future<void> login() async {
  //   // result = await otpService.loginUser(username, password);
  // }

  // Future<void> sendOTP() async {
  //   // final result = await otpService.loginUser(username, password);
  //   final response = await otpService.sendOTP(widget.phone);
  //   if (response.isNotEmpty) {
  //     final factorId = response['factorId']!;
  //     print(", Factor ID: $factorId");
  //
  //     // Sau đó, chuyển đến bước nhập OTP từ người dùng
  //   } else {
  //     print("Failed to send OTP");
  //   }
  // }

  Future<void> resendOTP() async {
    // stateToken = OTPService().sendOTP(widget.phone);
    bool success = await OTPService.sendOtp(widget.phone);
    if(success){
      print("Success to resend OTP");
    } else{
      print('Failed to resend OTP');
    }
    setState(() {
      _countdown = 180;
      startTimer();
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: Text('Enter OTP',
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Please enter the OTP code',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    height: 73,
                    child: TextFormField(
                      controller: otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      focusNode: index == 0 ? _focusNode : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: redColor)),
                      ),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _countdown == 0 ? resendOTP : null,
                child: Text(
                  _countdown > 0
                      ? 'Resend OTP after ${_countdown ~/ 60}:${(_countdown % 60).toString().padLeft(2, '0')} minutes' // Display minutes and seconds
                      : 'Resend OTP',
                  style: TextStyle(
                      color: _countdown == 0 ? redColor : Colors.white,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                incorrect ?
                    'OTP you entered is incorrect! Please enter again'
                    :
                    '',
                style: TextStyle(
                    color: redColor,
                    fontSize: 16),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Color(0xFFD22E07),
                    backgroundColor: Color.fromARGB(255, 210, 46, 7),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    String otp = otpControllers
                        .map((controller) => controller.text)
                        .join();

                    if(_countdown > 0 ){
                      bool isCorrect = await OTPService.verifyOtp(widget.phone, otp);
                      if(isCorrect){
                        print('Correct OTP');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => successScreen(isTrusted: widget.isTrusted,)),
                        );
                      } else {
                        setState(() {
                          incorrect = true;
                        });
                        for (var controller in otpControllers) {
                          controller.clear();
                        }
                        _focusNode!.requestFocus();
                      }
                      otp = '';
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: blackColor, content: Text('Your OTP has expired! Click resend OTP', style: TextStyle(color: redColor),)),
                      );
                    }

                    // final userId = result['userId']!;
                    // final factorId = result['factorId']!;
                    // OTPService().verifyOTP(otp, userId, factorId);
                    // print('OTP: $otp');
                  },
                  child: Text(
                    'Confirm',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
