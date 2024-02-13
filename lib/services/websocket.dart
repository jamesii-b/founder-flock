import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketManager {
  late IO.Socket socket;

  WebSocketManager({
    required String serverURL,
    required String uID,
  }) {
    // Initialize the socket
    socket = IO.io(
      serverURL,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'query': {'uID': uID},
      },
    );
  }

  // Connect to the server
  void connect() {
    socket.connect();
  }

  // Disconnect from the server
  void disconnect() {
    socket.disconnect();
  }

  // Send a message
  void sendMessage(Map<String, dynamic> message) {
    socket.emit('new-message', message);
  }

  // Listen for incoming messages
  void listenForMessages(Function(dynamic) onMessageReceived) {
    socket.on('new-message', onMessageReceived);
  }

  // Dispose the socket when no longer needed
  void dispose() {
    socket.dispose();
  }

  void setOnConnect(Null Function(dynamic _) param0) {}

  void setOnDisconnect(Null Function(dynamic _) param0) {}
}
