import 'package:easy_pagination/pagination_with_reverse_and_status_stream.dart';
import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import 'message_widget.dart';

class ChatBody<Response> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return EasyPagination<Response, ChatMessages>.listView(
      isReverse: true,
      shrinkWrap: true,
      loadingBuilder: loadingBuilder,
      controller: controller,
      asyncCall: asyncCall,
      mapper: mapper,
      errorMapper: errorMapper,
      errorBuilder: errorBuilder,
      itemBuilder: (data, index, element) => Align(
        alignment: element.isFromMe?
        Alignment.topRight : Alignment.topLeft,
        child: InkWell(
          onTap: onMessageTap != null? () =>
          onMessageTap!(context, element) : null,
          onLongPress: onMessageLongPress != null? () => onMessageLongPress!(context, element) : null,
          onDoubleTap: onMessageDoublePress != null? () => onMessageDoublePress!(context, element) : null,
          child: MessageWidget(
            message: element,
            leftMessageBuilder: leftMessageBuilder,
            rightMessageBuilder: rightMessageBuilder,
          ),
        ),
      ),
    );
  }
}