import 'dart:io';
import 'package:FounderFlock/provider/login_instance.dart';
import 'package:FounderFlock/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late String serverURL;

void main() {
  if (Platform.isAndroid) {
    serverURL = 'http://10.0.2.2:3000';
  } else {
    serverURL = 'http://localhost:3000';
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}
