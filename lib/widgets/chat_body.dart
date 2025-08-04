import 'dart:async';
import 'package:easy_chat/factory.dart';
import 'package:easy_pagination/helpers/controller.dart';
import 'package:easy_pagination/helpers/data_and_pagination_data.dart';
import 'package:easy_pagination/helpers/errors.dart';
import 'package:easy_pagination/pagination_with_reverse_and_status_stream.dart';
import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import 'message_widget.dart';

class ChatBody<Response> extends StatefulWidget {
  final SocketHelper socketType;
  final FutureOr Function(BuildContext context, ChatMessages message) onReceiveMessage;
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
    required this.socketType,
    required this.onReceiveMessage,
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

  Future<void> _init() async {
    await widget.socketType.connect();
    widget.socketType.onReceiveMessage().listen(
            (event) => widget.onReceiveMessage(context, event)
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    widget.socketType.disconnect();
    super.dispose();
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