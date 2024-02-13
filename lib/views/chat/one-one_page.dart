import 'package:flutter/material.dart';
import 'package:founder_flock/main.dart';
import 'package:founder_flock/models/friend_model.dart';
import 'package:founder_flock/provider/login_instance.dart';
import 'package:founder_flock/viewmodels/all-chat-vm.dart';
import 'package:provider/provider.dart';

class OneToOneChatPage extends StatefulWidget {
  final Friend friend;

  const OneToOneChatPage({Key? key, required this.friend}) : super(key: key);

  @override
  State<OneToOneChatPage> createState() => _OneToOneChatPageState();
}

class _OneToOneChatPageState extends State<OneToOneChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late AllChatsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AllChatsViewModel(
      uID: Provider.of<LoginProvider>(context, listen: false).uID,
      serverURL: serverURL,
    );
    _viewModel.getMessages(widget.friend.id);
  }

  @override
  void dispose() {
    _viewModel.disposeWebSocketManager();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.friend.email}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<dynamic>>(
              stream: _viewModel.messageStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<dynamic> messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      return ChatBubble(
                        message: message['message'],
                        isSent: message['senderID'] == _viewModel.uID,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No messages available'),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _viewModel.sendMessage(
                      widget.friend.id,
                      _messageController.text,
                    );
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSent;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isSent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSent ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSent ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
