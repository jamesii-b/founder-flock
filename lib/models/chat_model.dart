class ChatModel {
  final String content;
  final String senderId;
  final String? receiverId;

  ChatModel({required this.content, required this.senderId, this.receiverId});
}
