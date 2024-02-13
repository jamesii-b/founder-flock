import 'package:flutter/material.dart';
import 'package:founder_flock/main.dart';
import 'package:founder_flock/provider/login_instance.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    // Replace with your actual Socket.IO server URL

    // Connect to the server
    socket = IO.io(serverURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'uID': Provider.of<LoginProvider>(context, listen: false).uID}
    });

    // Handle connection events
    socket.onConnect((_) {
      print('Connected to Socket.IO server!');
      // Once connected, you can emit events, listen for events, etc.
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
    });

    // Connect to the server
    socket.connect();
  }

  @override
  void dispose() {
    socket.dispose(); // Dispose socket when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Chat Page'),
      ),
    );
  }
}
