import 'package:FounderFlock/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      bottomNavigationBar: bottomNavigationBar(currentPageIndex: 1),
      body: Column(
        children: const [
          Text('Profile Page'),
          
        ],
      ),
    );
  }
}
