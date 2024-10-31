import 'package:flutter/material.dart';

class ManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.pink[100],
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white, size: 40),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.all(20),
              children: [
                _buildGridItem(Icons.person, 'User'),
                _buildGridItem(Icons.book, 'Product'),
                _buildGridItem(Icons.person_outline, 'Author'),
                _buildGridItem(Icons.library_books, 'Publisher'),
                _buildGridItem(Icons.shopping_cart, 'Order'),
                _buildGridItem(Icons.category, 'Category'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label) {
    return Center(
      child: SizedBox(
        width: 100, // Đặt chiều rộng nhỏ hơn cho vòng tròn
        height: 100, // Đặt chiều cao nhỏ hơn cho vòng tròn
        child: Container(
          decoration: BoxDecoration(
            color: Colors.pink[50],
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.black),
              SizedBox(height: 15),
              Text(label, style: TextStyle(fontSize: 16)),
            ],
          ),
        )
      )
    );
  }
}
