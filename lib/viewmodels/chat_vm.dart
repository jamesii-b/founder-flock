import 'dart:async';
import 'package:flutter/material.dart';
import 'package:founder_flock/main.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatViewModel extends ChangeNotifier {
  IO.Socket socket;
  final _messageController = StreamController<String>.broadcast();
  List<String> messages = [];

  Stream<String> get messageStream => _messageController.stream;

  ChatViewModel()
      : socket = IO.io(webSocketURL, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        }) {
    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.on('new-message', (data) {
      messages.add(data['content']);
      _messageController.add(data['content']);
    });

    socket.connect();
  }

  void sendMessage(String message) {
    socket.emit('new-message', {'content': message});
  }
}
