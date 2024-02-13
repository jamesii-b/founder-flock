import 'dart:io';
import 'package:flutter/material.dart';
import 'package:founder_flock/provider/login_instance.dart';
import 'package:founder_flock/router/app_router.dart';
import 'package:founder_flock/viewmodels/chat_vm.dart';
import 'package:provider/provider.dart';

late String webServerURL;
late String webSocketURL;

void main() {
  if (Platform.isAndroid) {
    webServerURL = 'http://10.0.2.2:3000/api';
    webSocketURL = 'ws://10.0.2.2:3000';
  } else if (Platform.isWindows) {
    webServerURL = 'http://localhost:3000/api';
    webSocketURL = 'ws://localhost:3000';
  } else {
    webServerURL = 'http://localhost:3000/api';
    webSocketURL = 'ws://localhost:3000';
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatViewModel>(
          create: (context) => ChatViewModel(),
          child: MyApp(),
        ),
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
