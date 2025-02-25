import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';

class SocketService {
  late IO.Socket _socket;
  final String userId;
  // final String 
  /// **Constructor - Pass User ID**
  SocketService({required this.userId}) {
    _initializeSocket();
  }

  /// **Initialize & Connect to WebSocket**
  void _initializeSocket() {
    _socket = IO.io(
      ApiEndpoints.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({'userId': userId}) // ✅ Register user automatically
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint("✅ Connected to WebSocket");
      _registerUser();
    });

    _socket.onDisconnect((_) {
      debugPrint("❌ Disconnected from WebSocket");
    });
  }

  /// **Register User for Real-Time Updates**
  void _registerUser() {
    if (userId.isNotEmpty) {
      _socket.emit("register", userId);
      debugPrint("✅ User Registered in WebSocket: $userId");
    }
  }

  /// **Listen for Notifications**
  void listenForNotifications(Function(dynamic) callback) {
    _socket.on("new-notification", callback);
  }

  /// **Join Room (for chat/sessions)**
  void joinRoom(String roomId) {
    _socket.emit("join-room", roomId);
    debugPrint("✅ Joined Room: $roomId");
  }

  /// **Send Message/Event to Room**
  void sendMessage(String roomId, dynamic data) {
    _socket.emit("send-message", {"roomId": roomId, "message": data});
    debugPrint("📤 Sent Message to Room: $roomId");
  }

  /// **Disconnect Socket**
  void disconnect() {
    _socket.disconnect();
  }

  /// **Get Socket Instance (for access in other services)**
  IO.Socket get socket => _socket;
}
