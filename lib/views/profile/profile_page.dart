import 'package:FounderFlock/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FounderFlock/provider/login_instance.dart'; // Import the UserProvider class

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context); // Retrieve UserProvider instance
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      bottomNavigationBar: bottomNavigationBar(currentPageIndex: 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Email: ${userProvider.email}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'User ID: ${userProvider.uID}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add button functionality here
            },
            child: Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
