import 'package:FounderFlock/provider/login_instance.dart';
import 'package:FounderFlock/views/chat/chat_page.dart';
import 'package:FounderFlock/views/login/login_page.dart';
import 'package:FounderFlock/views/profile/profile_page.dart';
import 'package:FounderFlock/views/registration/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final GoRouter router = GoRouter(
      errorPageBuilder: (context, state) {
        return const MaterialPage(
            child: Scaffold(body: Center(child: Text('Page not found'))));
      },
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            final loginProvider = Provider.of<UserProvider>(context,
                listen: false); // Access the UserProvider instance
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
          name: 'signup',
          path: '/signup',
          pageBuilder: (context, state) =>
              const MaterialPage(child: RegistrationPage()),
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
