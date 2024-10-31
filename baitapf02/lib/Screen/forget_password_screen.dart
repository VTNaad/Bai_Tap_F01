import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = '';
  bool isLoading = false;
  final apiurl = dotenv.env['API_URL'];

  void handleForgotPassword() async {
    if (email.isEmpty) {
      _showAlert("Error", "Please enter your email");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('$apiurl/user/forgotpassword?email=${Uri.encodeComponent(email)}'),
        headers: {
          "Content-Type": "application/json",
        },
      );

      final data = json.decode(response.body);
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        _showAlert("Success", "Password reset link sent to your email", () {
          Navigator.pushNamed(context, '/reset-password'); // Navigate to ResetPassword screen
        });
      } else {
        _showAlert("Error", data['message'] ?? "Failed to send reset link");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _showAlert("Error", error.toString() ?? "Something went wrong");
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
        title: Text('Forgot Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Biểu tượng mũi tên quay lại
          onPressed: () => Navigator.pushNamed(context, '/'), // Quay về trang đăng nhập
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(labelText: "Enter your email"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: handleForgotPassword,
                    child: Text('Send Reset Link'),
                  ),
          ],
        ),
      ),
    );
  }
}
