import 'package:flutter/material.dart';
import 'package:founder_flock/viewmodels/chat_vm.dart';
import 'package:provider/provider.dart'; // Import Provider package

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController recipientController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<ChatViewModel>(
              builder: (context, chatViewModel, _) {
                return ListView.builder(
                  itemCount: chatViewModel.messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(chatViewModel.messages[index]),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: recipientController,
                  decoration: const InputDecoration(
                    hintText: 'Recipient User ID',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter message',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Access ChatViewModel instance using Provider and send message
                    Provider.of<ChatViewModel>(context, listen: false)
                        .sendMessage(recipientController.text);
                    messageController.clear();
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
