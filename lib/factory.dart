import 'dart:async';
import 'dart:developer';
import 'package:easy_chat/models/chat_message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageEvents {
  final String receiveMsgEvent;
  final String sendMsgEvent;

  MessageEvents({
    required this.receiveMsgEvent,
    required this.sendMsgEvent,
  });
}

class EasyChatEvents{
  MessageEvents messageEvents;
  final List<String> otherEvents;

  EasyChatEvents({
    required this.messageEvents,
    required this.otherEvents
  });
}

abstract interface class SocketHelper{
  final String url;
  final int roomId;
  final dynamic Function(dynamic)? onConnect;
  final dynamic Function(dynamic)? onDisconnect;
  final ChatMessages Function(Map<String, dynamic> jsonMessage) jsonToChatMessage;
  final FutureOr<void> Function(ChatMessages message) onReceiveMessage;
  final FutureOr<void> Function(String event, dynamic data)? onReceiveAnyEvent;
  final EasyChatEvents events;

  SocketHelper({
    required this.roomId,
    required this.url,
    required this.jsonToChatMessage,
    required this.onReceiveMessage,
    required this.events,
    this.onReceiveAnyEvent,
    this.onConnect,
    this.onDisconnect,
  });

  FutureOr<void> connect();
  FutureOr<void> disconnect();

  FutureOr<void> sendMessage(Map<String, dynamic> data);
  FutureOr<void> emitEvent({required String event, Map<String, dynamic>? data});
}

class ClientIOImpl extends SocketHelper{
  final Map<String, dynamic>? extraParams;
  final Map<String, dynamic>? extraHeaders;

  ClientIOImpl({
    this.extraParams,
    this.extraHeaders,
    super.onConnect,
    super.onDisconnect,
    required super.roomId,
    required super.url,
    required super.jsonToChatMessage,
    required super.onReceiveMessage,
    required super.events,
    super.onReceiveAnyEvent,
  });

  late final IO.Socket socket;
  void _init(){
    socket = IO.io(url, IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setExtraHeaders(extraHeaders ?? {})
        .setQuery(extraParams ?? {})
        .build()
    )..connect();
  }

  @override
  FutureOr<void> connect() {
    _init();

    socket.onConnect((d) => onConnect?.call(d));
    socket.onDisconnect((d) => onDisconnect?.call(d));

    socket.onConnectError((err) => log('❌ Socket connect error: $err'));
    socket.onError((err) => log('❌ Socket error: $err'));

    onReceiveEvent();
  }

  void onReceiveEvent(){
    socket.on(
        events.messageEvents.receiveMsgEvent,
            (data) => onReceiveMessage.call(jsonToChatMessage.call(data))
    );

    socket.onAny(
            (event, data) => onReceiveAnyEvent?.call(event, data)
    );
  }


  @override
  FutureOr<void> disconnect() {
    socket.disconnect();
    socket.dispose();
  }

  @override
  FutureOr<void> sendMessage(Map<String, dynamic> data) {
    socket.emit(events.messageEvents.sendMsgEvent, [data]);
  }

  @override
  FutureOr<void> emitEvent({required String event, Map<String, dynamic>? data}) {
    socket.emit(event, [data]);
  }
}
