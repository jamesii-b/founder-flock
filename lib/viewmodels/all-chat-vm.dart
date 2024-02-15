import 'dart:async';
import 'dart:convert';

import 'package:FounderFlock/services/websocket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllChatsViewModel extends ChangeNotifier {
  late List<dynamic> _messages = [];
  final String uID;
  final String serverURL;
  final StreamController<List<dynamic>> _messageStreamController =
      StreamController<List<dynamic>>.broadcast();
  Stream<List<dynamic>> get messageStream => _messageStreamController.stream;

  late WebSocketManager webSocketManager;

  AllChatsViewModel({
    required this.uID,
    required this.serverURL,
  }) {
    webSocketManager = WebSocketManager(
      serverURL: serverURL,
      uID: uID,
    );
    webSocketManager.connect();
    webSocketManager.listenForMessages((message) {
      _messages.add(message);
      print("Received websocket message: $message");
      _messageStreamController.add(_messages);
    });
  }

  Future<void> getInitialMessages(String friendID) async {
    try {
      var response = await http.post(
        Uri.parse("$serverURL/api/chats/specific/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'userID': uID,
          'friendID': friendID,
        }),
      );
      if (response.statusCode == 200) {
        _messages = json.decode(response.body);
        print("api Messages: $_messages");
        _messageStreamController.add(_messages); // Add messages to stream
      } else {
        throw "Can't fetch messages";
      }
    } catch (error) {
      print('Error fetching messages: $error');
    }
  }

  void sendMessage(String friendID, String message) async {
    // Always add messages to maintain consistency
    webSocketManager.sendMessage({
      'senderID': uID,
      'receiverID': friendID,
      'message': message,
    });
    _messages.add({
      'senderID': uID,
      'receiverID': friendID,
      'message': message,
    });
    _messageStreamController.add(_messages);
  }

  void disposeWebSocketManager() {
    webSocketManager.dispose();
  }

  List<dynamic> get messages => _messages;
}
