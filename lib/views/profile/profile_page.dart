import 'package:flutter/material.dart';
import 'package:founder_flock/views/components/navbar.dart';

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
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
