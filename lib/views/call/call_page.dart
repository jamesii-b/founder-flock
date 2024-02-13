import 'dart:io';
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  bool _isOffline = false;
  bool _isRecording = false;
  late IOWebSocketChannel _channel;

  Future<void> checkPermission(Permission permission) async {
    final status = await permission.request();
    if (!status.isGranted) {
      // Handle permission denied
    }
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isOffline = true;
      });
    }
  }

  void startCall() {
    setState(() {
      _isRecording = true;
    });
    // Navigate to the call screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CallScreen()),
    );
  }

  void stopCall() {
    setState(() {
      _isRecording = false;
    });
  }

  void sendRecording(File recording) {
    // Send recording to WebSocket server
    if (recording.existsSync()) {
      _channel.sink.addStream(recording.openRead());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Page'),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              checkPermission(Permission.camera);
              checkPermission(Permission.microphone);
              checkPermission(Permission.phone);
              checkConnectivity();
              if (_isOffline) {
                showOfflineDialog(context);
              } else {
                // Start recording when online
                startCall();
              }
            },
            icon: const Icon(
              Icons.call,
              color: Colors.green,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  Future<void> showOfflineDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet Connection'),
        content: Text('Please check your internet connection and try again.'),
        actions: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

// CallScreen widget to display the call interface

class CallScreen extends StatelessWidget {
  
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}