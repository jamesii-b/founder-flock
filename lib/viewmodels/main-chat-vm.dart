import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:founder_flock/main.dart';
import 'package:founder_flock/models/friend_model.dart';
import 'package:founder_flock/services/websocket.dart';
import 'package:http/http.dart' as http;

class ChatViewModel extends ChangeNotifier {
  final WebSocketManager webSocketManager;
  final String uID;
  late List<Friend> _friends = [];
  late List<dynamic> _messages = [];
  bool _isFriendsDataFetched = false;
  ChatViewModel({
    required this.webSocketManager,
    required this.uID,
  }) {
    connectToSocket();
  }

  Future<void> connectToSocket() async {
    print('Connecting to Socket.IO server...');
    // Connect to the server
    webSocketManager.connect();

    // Handle connection events
    webSocketManager.setOnConnect((_) {
      print('Connected to Socket.IO server!');
      // Once connected, you can emit events, listen for events, etc.
      getFriends(); // Call getFriends once connected
    });

    webSocketManager.setOnDisconnect((_) {
      print('Disconnected from Socket.IO server');
    });
  }

  get isFriendsDataFetched => _isFriendsDataFetched;

  Future<void> getFriends() async {
    print('Fetching friends...');
    if (_isFriendsDataFetched) {
      return;
    } else {
      try {
        print('Fetching friends...');
        var response = await http.get(Uri.parse("$serverURL/api/friends/$uID"));
        if (response.statusCode == 200) {
          final List<dynamic> friendsData =
              json.decode(response.body)[0]['friends'];
          _friends = friendsData.map((friend) {
            return Friend(
              email: friend['email'] ?? '',
              id: friend['_id'] ?? '',
              profilePic: friend['profile_pic'] ?? '',
            );
          }).toList();
          _isFriendsDataFetched = true;
          notifyListeners();
        } else {
          throw Exception('Failed to fetch friends');
        }
      } catch (error) {
        print('Error fetching friends: $error');
      }
    }
  }

  

  List<Friend> get friends => _friends;
  List<dynamic> get messages => _messages;
}
