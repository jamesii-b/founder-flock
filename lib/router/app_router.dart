import 'package:flutter/material.dart';
import 'package:founder_flock/provider/login_instance.dart';
import 'package:founder_flock/views/chat/chat_page.dart';
import 'package:founder_flock/views/login/login_page.dart';
import 'package:founder_flock/views/profile/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final GoRouter router = GoRouter(
      errorPageBuilder: (context, state) {
        return const MaterialPage(
            child: Scaffold(body: Center(child: Text('Page not found'))));
      },
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            final loginProvider = Provider.of<LoginProvider>(context,
                listen: false); // Access the LoginProvider instance
            if (loginProvider.isLogin) {
              return MaterialPage(child: ChatPage());
            } else {
              return MaterialPage(child: LoginPage());
            }
          },
        ),
        GoRoute(
          name: 'login',
          path: '/login',
          pageBuilder: (context, state) =>
              const MaterialPage(child: LoginPage()),
        ),
        GoRoute(
          name: 'chat',
          path: '/chat',
          pageBuilder: (context, state) => MaterialPage(child: ChatPage()),
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          pageBuilder: (context, state) => MaterialPage(child: ProfilePage()),
        ),
      ]);
}
