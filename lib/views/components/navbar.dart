import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class bottomNavigationBar extends StatefulWidget {
  int currentPageIndex;
  bottomNavigationBar({super.key, required this.currentPageIndex});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: labelBehavior,
      selectedIndex: widget.currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          widget.currentPageIndex = index;
          switch (index) {
            case 0:
              GoRouter.of(context).go('/chat');
              break;
            case 1:
              GoRouter.of(context).go('/profile');
              break;
          }
        });
      },
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
