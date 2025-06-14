import 'package:easy_pagination/pagination_with_reverse_and_status_stream.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/chat_message.dart';
import '../models/socket_data.dart';
import 'message_widget.dart';

class ChatBody<Response> extends StatefulWidget {
  final SocketData socketData;
  final EasyPaginationController<ChatMessages> controller;
  final Future<Response> Function(int currentPage) asyncCall;
  final DataListAndPaginationData<ChatMessages> Function(Response response) mapper;
  final ErrorMapper errorMapper;
  final Widget? loadingBuilder;
  final Widget Function(String)? errorBuilder;
  final Widget Function(ChatMessages message) rightMessageBuilder;
  final Widget Function(ChatMessages message) leftMessageBuilder;
  final void Function(BuildContext context, ChatMessages message)? onMessageTap;
  final void Function(BuildContext context, ChatMessages message)? onMessageLongPress;
  final void Function(BuildContext context, ChatMessages message)? onMessageDoublePress;

  const ChatBody({super.key,
    required this.socketData,
    required this.controller,
    required this.asyncCall,
    required this.mapper,
    required this.errorMapper,
    required this.rightMessageBuilder,
    required this.leftMessageBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.onMessageTap,
    this.onMessageLongPress,
    this.onMessageDoublePress
  });

  @override
  State<ChatBody<Response>> createState() => _ChatBodyState<Response>();
}

class _ChatBodyState<Response> extends State<ChatBody<Response>> {

  late final WebSocketChannel _channel;
  void _init(){
    final wsUrl = Uri.parse(widget.socketData.connectionUrl);
    _channel = WebSocketChannel.connect(wsUrl);
  }

  void _handleSocket(BuildContext context){
    _channel.stream.listen(
          (event) => widget.socketData.onReceiveMessage(
              context,
              widget.controller,
              widget.socketData.jsonToChatMessage(event)
          )
    );
  }

  @override
  void initState() {
    _init();
    _handleSocket(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyPagination<Response, ChatMessages>.listView(
      isReverse: true,
      shrinkWrap: true,
      loadingBuilder: widget.loadingBuilder,
      controller: widget.controller,
      asyncCall: widget.asyncCall,
      mapper: widget.mapper,
      errorMapper: widget.errorMapper,
      errorBuilder: widget.errorBuilder,
      itemBuilder: (data, index, element) => Align(
        alignment: element.isFromMe?
        Alignment.topRight : Alignment.topLeft,
        child: InkWell(
          onTap: widget.onMessageTap != null? () =>
          widget.onMessageTap!(context, element) : null,
          onLongPress: widget.onMessageLongPress != null? () => widget.onMessageLongPress!(context, element) : null,
          onDoubleTap: widget.onMessageDoublePress != null? () => widget.onMessageDoublePress!(context, element) : null,
          child: MessageWidget(
            message: element,
            leftMessageBuilder: widget.leftMessageBuilder,
            rightMessageBuilder: widget.rightMessageBuilder,
          ),
        ),
      ),
    );
  }
}