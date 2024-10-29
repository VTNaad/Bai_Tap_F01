import 'dart:async'; // Để sử dụng Timer
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import trang đăng nhập

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<IntroduceScreen> {
  @override
  void initState() {
    super.initState();
    // Sau 10 giây tự động chuyển đến trang LoginPage
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thành viên nhóm 1:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Thông tin thành viên nhóm
            Text("Võ Thế Dân - 21110149"),
            Text("Nguyễn Thành Nghiệp - 21110255"),
            Text("Hồ Văn Huỳnh Hợp  - 21110185"),
          ],
        ),
      ),
    );
  }
}