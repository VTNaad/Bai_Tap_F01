import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  final apiurl = dotenv.env['API_URL'];
  
  Future<void> handleLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both username and password")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$apiurl/user/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await storage.write(key: "accessToken", value: data["accessToken"]);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful")),
        );
        Navigator.pushReplacementNamed(context, "/manager");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Login failed")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng nhập - Manager")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            ElevatedButton(onPressed: handleLogin, child: const Text("Login")),
            ElevatedButton(onPressed: () { Navigator.pushReplacementNamed(context, "/register"); }, child: const Text("Register")),
            ElevatedButton(onPressed: () { Navigator.pushReplacementNamed(context, "/forget-password"); }, child: const Text("Forget Password")),
          ],
        ),
      ),
    );
  }
}
