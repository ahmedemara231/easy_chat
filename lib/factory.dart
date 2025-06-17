import 'dart:async';

import 'package:easy_chat/models/chat_message.dart';

abstract interface class SocketHelper{
  final String url;
  SocketHelper(this.url);

  FutureOr<void> connect();
  FutureOr<void> disconnect();
  // ChatMessages jsonToChatMessage(Map<String, dynamic> jsonMessage) => ChatMessages.initial();
  Stream<ChatMessages> onReceiveMessage(); // should make json parsing here to chat message
}

// late final WebSocketChannel _channel;
// void _init(){
//   final wsUrl = Uri.parse(widget.socketData.connectionUrl);
//   _channel = WebSocketChannel.connect(wsUrl);
// }
//
// void _handleSocket(BuildContext context){
//   _channel.stream.listen(
//         (event) => widget.socketData.onReceiveMessage(
//             context,
//             widget.controller,
//             widget.socketData.jsonToChatMessage(event)
//         )
//   );
// }

class PusherImpl extends SocketHelper{
  PusherImpl(super.url);
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
  SignalRImpl(super.url);

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

class ClientIOImpl extends SocketHelper{
  ClientIOImpl(super.url);

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
