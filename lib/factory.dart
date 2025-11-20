import 'dart:async';

import 'package:easy_chat/models/chat_message.dart';

abstract interface class SocketHelper{
  final String url;
  final int roomId;
  ChatMessages Function(Map<String, dynamic> jsonMessage) jsonToChatMessage;
  FutureOr<void> Function(ChatMessages message) onReceiveMessage;

  SocketHelper({
    required this.roomId,
    required this.url,
    required this.jsonToChatMessage,
    required this.onReceiveMessage
  });

  FutureOr<void> connect({dynamic Function(dynamic)? handler});
  FutureOr<void> disconnect({dynamic Function(dynamic)? handler});
}


class ClientIOImpl extends SocketHelper{
  ClientIOImpl({
    required super.roomId,
    required super.url,
    required super.jsonToChatMessage,
    required super.onReceiveMessage
  });

  @override
  FutureOr<void> connect({dynamic Function(dynamic)? handler}) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect({dynamic Function(dynamic)? handler}) {
    // TODO: implement disconnect
    throw UnimplementedError();
  }
}
