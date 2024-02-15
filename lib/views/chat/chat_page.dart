// View
import 'package:FounderFlock/main.dart';
import 'package:FounderFlock/provider/login_instance.dart';
import 'package:FounderFlock/services/websocket.dart';
import 'package:FounderFlock/viewmodels/main-chat-vm.dart';
import 'package:FounderFlock/views/chat/individual_chat_page.dart';
import 'package:FounderFlock/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatViewModel(
        webSocketManager: WebSocketManager(
          serverURL: serverURL,
          uID: Provider.of<LoginProvider>(context, listen: false).uID,
        ),
        uID: Provider.of<LoginProvider>(context, listen: false).uID,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts:'),
        ),
        bottomNavigationBar: bottomNavigationBar(currentPageIndex: 0),
        body: Consumer<ChatViewModel>(
          builder: (context, viewModel, child) {
            if (!(viewModel.isFriendsDataFetched)) {
              viewModel.getFriends();
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (viewModel.friends.isEmpty) {
              return const Center(
                child: Text('No friends found.'),
              );
            } else {
              return ListView.builder(
                itemCount: viewModel.friends.length,
                itemBuilder: (context, index) {
                  final friend = viewModel.friends[index];
                  return ListTile(
                    title: Text(friend.email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OneToOneChatPage(
                                  friend: friend,
                                )),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
