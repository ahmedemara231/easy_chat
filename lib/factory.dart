import 'dart:async';

import 'package:easy_chat/models/chat_message.dart';

abstract interface class SocketHelper{
  final String url;
  ChatMessages Function(Map<String, dynamic> jsonMessage) jsonToChatMessage;
  SocketHelper({required this.url, required this.jsonToChatMessage});

  FutureOr<void> connect();
  FutureOr<void> disconnect();
  Stream<ChatMessages> onReceiveMessage(); // should make json parsing here to chat message
}

class PusherImpl extends SocketHelper{
  PusherImpl({required super.url, required super.jsonToChatMessage});
  @override
  FutureOr<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Stream<ChatMessages> onReceiveMessage() {
    // TODO: implement onReceiveMessage
    throw UnimplementedError();
  }

}

class SignalRImpl extends SocketHelper{
  SignalRImpl({required super.url, required super.jsonToChatMessage});

  @override
  FutureOr<void> connect() {
    // TODO: implement connect
    // throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect() {
    // TODO: implement disconnect
    // throw UnimplementedError();
  }

  @override
  Stream<ChatMessages> onReceiveMessage() {
    return Stream.periodic(Duration(seconds: 1), (count) => ChatMessages(senderImage: 'senderImage', message: 'any msg', time: 'time', isFromMe: count.isEven? true : false));
  }
}

class ClientIOImpl extends SocketHelper{
  ClientIOImpl({required super.url, required super.jsonToChatMessage});

  @override
  FutureOr<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Stream<ChatMessages> onReceiveMessage() {
    // TODO: implement onReceiveMessage
    throw UnimplementedError();
  }

}
