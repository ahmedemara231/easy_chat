import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pagify/helpers/data_and_pagination_data.dart';
import 'package:pagify/helpers/errors.dart';
import 'package:pagify/pagify.dart';
import 'factory.dart';
import 'widgets/chat_body.dart';
import 'models/chat_message.dart';

class EasyChat<Response> extends StatelessWidget {
  final SocketHelper socketType;
  final FutureOr Function(BuildContext context, ChatMessages message) onReceiveMessage;
  final PagifyController<ChatMessages> controller;
  final Future<Response> Function(BuildContext context, int page) asyncCall;
  final PagifyData<ChatMessages> Function(Response response) mapper;
  final PagifyErrorMapper errorMapper;
  final Widget? chatBackground;
  final Widget? loadingBuilder;
  final Widget Function(PagifyException e)? errorBuilder;
  final Widget Function(ChatMessages message) rightMessageBuilder;
  final Widget Function(ChatMessages message) leftMessageBuilder;
  final void Function(BuildContext context, ChatMessages message)? onMessageTap;
  final void Function(BuildContext context, ChatMessages message)? onMessageLongPress;
  final void Function(BuildContext context, ChatMessages message)? onMessageDoublePress;
  final double? cacheExtent;
  final double? itemExtent;

  const EasyChat({super.key,
    required this.socketType,
    required this.onReceiveMessage,
    required this.controller,
    required this.asyncCall,
    required this.mapper,
    required this.errorMapper,
    required this.rightMessageBuilder,
    required this.leftMessageBuilder,
    this.chatBackground,
    this.errorBuilder,
    this.loadingBuilder,
    this.onMessageTap,
    this.onMessageLongPress,
    this.onMessageDoublePress,
    this.cacheExtent,
    this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if(chatBackground != null)
          chatBackground!,
        ChatBody<Response>(
          cacheExtent: cacheExtent,
          itemExtent: itemExtent,
          socketType: socketType,
          onReceiveMessage: onReceiveMessage,
          errorMapper: errorMapper,
          mapper: mapper,
          asyncCall: asyncCall,
          controller: controller,
          rightMessageBuilder: rightMessageBuilder,
          leftMessageBuilder: leftMessageBuilder,
          onMessageTap: onMessageTap,
          errorBuilder: errorBuilder,
          loadingBuilder: loadingBuilder,
          onMessageDoublePress: onMessageDoublePress,
          onMessageLongPress: onMessageLongPress,
        ),
      ],
    );
  }
}