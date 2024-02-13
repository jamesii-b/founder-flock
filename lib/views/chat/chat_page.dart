// import 'package:flutter/material.dart';
// import 'package:founder_flock/models/chat_model.dart';
// import 'package:founder_flock/viewmodels/chat_data.dart';
// import 'package:provider/provider.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<ChatViewModel>(
//         builder: (context, chatData, child) {
//           return ListView.builder(
//             itemCount: chatData.chatData.length,
//             itemBuilder: (context, index) {
//               var chatDatum = chatData.chatData[index];
//               return GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SingleChat(
//                       sender: chatDatum.sender,
//                     ),
//                   ),
//                 ),
//                 child: ListTile(
//                   title: Text(chatDatum.sender),
//                   subtitle: Text(
//                       chatDatum.message[chatDatum.message.length - 1].message),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class SingleChat extends StatefulWidget {
//   final String sender;

//   const SingleChat({Key? key, required this.sender}) : super(key: key);

//   @override
//   State<SingleChat> createState() => _SingleChatState();
// }

// class _SingleChatState extends State<SingleChat> {
//   final _messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with ${widget.sender}'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Consumer<ChatViewModel>(
//                 builder: (context, chatData, child) {
//                   List<ChatDatumModel> userChats =
//                       chatData.getChat(widget.sender);
//                   return Column(
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: userChats.length,
//                         itemBuilder: (context, index) {
//                           var chatDatum = userChats[index];
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(chatDatum.sender),
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: chatDatum.message.length,
//                                 itemBuilder: (context, idx) {
//                                   var message = chatDatum.message[idx];
//                                   return ListTile(
//                                     title: Text(message.message),
//                                     subtitle: Text(message.time),
//                                     // Set alignment based on userReceiver flag
//                                     trailing: message.userReceiver
//                                         ? null // Align to the left for received messages
//                                         : const SizedBox(
//                                             width:
//                                                 0), // Align to the right for sent messages
//                                     leading: message.userReceiver
//                                         ? const SizedBox(
//                                             width:
//                                                 0) // Align to the right for received messages
//                                         : null, // Align to the left for sent messages
//                                   );
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type a message",
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Send message logic here
//                   },
//                   icon: Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
