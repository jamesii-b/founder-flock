import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:founder_flock/services/websocket.dart';
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
      _messages.add([message]);
      print("Received websocket message: $message");
      _messageStreamController.add([message]);
    });
  }

  Future<void> getMessages(String friendID) async {
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
        _messageStreamController.add(_messages); // Add messages to stream
      } else {
        throw "Can't fetch messages";
      }
    } catch (error) {
      print('Error fetching messages: $error');
    }
  }

  void sendMessage(String friendID, String message) async {
    // Always add messages as lists to maintain consistency
    webSocketManager.sendMessage({
      'senderID': uID,
      'receiverID': friendID,
      'message': message,
    });
    _messageStreamController.add([
      {
        'senderID': uID,
        'receiverID': friendID,
        'message': message,
      }
    ]);
    // Send the message via websocket
  }

  void disposeWebSocketManager() {
    webSocketManager.dispose();
  }

  List<dynamic> get messages => _messages;
}
