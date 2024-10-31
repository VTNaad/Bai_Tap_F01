import 'package:baitapf02/Screen/OTP_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String username = "";
  String password = "";
  String confirmPassword = "";
  String fullname = "";
  String email = "";
  String phone = "";
  String address = "";

  final apiurl = dotenv.env['API_URL'];

  void handleSendOTP() async {
    if (password != confirmPassword) {
      _showAlert("Error", "Passwords do not match");
      return;
    }
    
    try {
      final response = await http.post(
        Uri.parse('$apiurl/user/sendOTP?email=${Uri.encodeComponent(email)}&action=CreateAccount'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username, "phone": phone}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final otpCode = data['otp_code'];
        final action = data['action'];

        _showAlert("Success", "Send OTP to your email", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                  otpCode: otpCode,
                  action: action,
                  username: username,
                  password: password,
                  email: email,
                  fullname: fullname,
                  phone: phone,
                ),
              ),
            );
          });
      } else {
        _showAlert("Error", "Registration failed");
      }
    } catch (error) {
      _showAlert("Error", "Something went wrong");
    }
  }

  void _showAlert(String title, String message, [VoidCallback? onPressed]) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onPressed != null) onPressed();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Biểu tượng mũi tên quay lại
          onPressed: () => Navigator.pushNamed(context, '/'), // Quay về trang đăng nhập
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => username = value,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              onChanged: (value) => password = value,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextField(
              onChanged: (value) => confirmPassword = value,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            TextField(
              onChanged: (value) => fullname = value,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              onChanged: (value) => phone = value,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            TextField(
              onChanged: (value) => address = value,
              decoration: InputDecoration(labelText: "Address"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleSendOTP,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
