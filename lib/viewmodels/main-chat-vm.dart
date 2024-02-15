import 'dart:convert';
import 'package:FounderFlock/main.dart';
import 'package:FounderFlock/models/friend_model.dart';
import 'package:FounderFlock/services/websocket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatViewModel extends ChangeNotifier {
  final WebSocketManager webSocketManager;
  final String uID;
  late List<Friend> _friends = [];
  bool _isFriendsDataFetched = false;
  ChatViewModel({
    required this.webSocketManager,
    required this.uID,
  }) {
    // connectToSocket();
    getFriends();
  }

  get isFriendsDataFetched => _isFriendsDataFetched;

  Future<void> getFriends() async {
    try {
      print('Fetching friends...');
      // var routerURL = "${serverURL}/api/friends/$uID";
      var routerURL = "${serverURL}/api/friends/all/$uID";
      if (routerURL == "${serverURL}/api/friends/$uID") {
        var response = await http.get(Uri.parse(routerURL));
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
      } else {
        var response = await http.get(Uri.parse(routerURL));
        if (response.statusCode == 200) {
          final List<dynamic> friendsData = json.decode(response.body);
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
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  List<Friend> get friends => _friends;
}
