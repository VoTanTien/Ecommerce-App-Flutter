import 'dart:convert';

import 'package:http/http.dart' as http;
class OTPService {
  static const String baseUrl = "https://otp-backend-dvlt.onrender.com";
  // static const String baseUrl = 'https://dev-01779620.okta.com';
  // static const String apiToken = '00CsKsObbTQv0fteBCWx4PfF0rwC-WOrMJMVtV0Tpb';

  static Future<bool> sendOtp(String phoneNumber) async {
    print('OTP send to $phoneNumber');
    final url = Uri.parse('$baseUrl/send-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phoneNumber": phoneNumber}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      } else {
        print("Failed to send OTP: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
    }
  }

  static Future<bool> verifyOtp(String phoneNumber, String otp) async {
    print('otp: $otp');
    final url = Uri.parse('$baseUrl/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phoneNumber": phoneNumber, "otp": otp}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      } else {
        print("Failed to verify OTP: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      return false;
    }
  }
}




// Future<Map<String, dynamic>> loginUser(String username, String password) async {
  //   final url = '$baseUrl/api/v1/authn';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         "username": username,
  //         "password": password,
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //
  //       // Lấy thông tin userId và stateToken
  //       final userId = responseBody['_embedded']['user']['id'];
  //       final stateToken = responseBody['stateToken'];
  //       print("User ID: $userId");
  //       print("State Token: $stateToken");
  //       return {"userId": userId, "stateToken": stateToken};
  //     } else {
  //       print("Failed to login: ${response.body}");
  //       return {};
  //     }
  //   } catch (e) {
  //     print("Error logging in: $e");
  //     return {};
  //   }
  // }

  // Future<Map<String, String>> sendOTP(String userId) async {
  //   final url = '$baseUrl/api/v1/users/$userId/factors';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'SSWS $apiToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         "factorType": "sms",
  //         "provider": "OKTA",
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       final factorId = responseBody['id'];
  //       print("Factor ID: $factorId");
  //       print("OTP sent successfully");
  //       return {"factorId": factorId};
  //     } else {
  //       print("Failed to send OTP: ${response.body}");
  //       return {};
  //     }
  //   } catch (e) {
  //     print("Error sending OTP: $e");
  //     return {};
  //   }
  // }

  // Future<void> verifyOTP(String otp, String userId, String factorId) async {
  //   final url = '$baseUrl/api/v1/users/$userId/factors/$factorId/verify';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'SSWS $apiToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         "passCode": otp,
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("OTP verified successfully");
  //     } else {
  //       print("Failed to verify OTP: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error verifying OTP: $e");
  //   }
  // }
  //
  // Future<Map<String, String>> sendOTP(String phoneNumber) async {
  //   final url = '$baseUrl/api/v1/authn';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'SSWS $apiToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         "username": "20522013@gm.uit.edu.vn",
  //         "password": "Tienpro1234@",
  //         "options": {
  //           "multiOptionalFactorEnroll": false,
  //           "warnBeforePasswordExpired": false
  //         },
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       final stateToken = responseBody['stateToken'];
  //       final factors = responseBody['factors'] as List;
  //
  //       // Tìm yếu tố SMS trong danh sách factors
  //       final smsFactor = factors.firstWhere(
  //             (factor) => factor['factorType'] == 'sms',
  //         orElse: () => null,
  //       );
  //
  //       if (smsFactor != null) {
  //         final factorId = smsFactor['id'];
  //         print("State Token: $stateToken");
  //         print("Factor ID: $factorId");
  //         print("OTP sent successfully");
  //         return {"stateToken": stateToken, "factorId": factorId};
  //       } else {
  //         print("No SMS factor available");
  //         return {};
  //       }
  //     } else {
  //       print("Failed to send OTP: ${response.body}");
  //       return {};
  //     }
  //   }catch (e) {
  //     print("Error sending OTP: $e");
  //     return {};
  //   }
  // }
  //
  // /// Verifies the OTP sent to the user with the provided stateToken.
  // Future<void> verifyOTP(String otp, String stateToken, String factorId) async {
  //   final url = '$baseUrl/api/v1/authn/factors/$factorId/verify';
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'SSWS $apiToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         "passCode": otp,
  //         "stateToken": stateToken,
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("OTP verified successfully");
  //     } else {
  //       print("Failed to verify OTP: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error verifying OTP: $e");
  //   }
  // }
// }