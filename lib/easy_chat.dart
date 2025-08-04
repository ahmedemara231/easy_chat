import 'dart:async';
import 'package:easy_pagination/helpers/controller.dart';
import 'package:easy_pagination/helpers/data_and_pagination_data.dart';
import 'package:easy_pagination/helpers/errors.dart';
import 'package:flutter/material.dart';
import 'factory.dart';
import 'widgets/chat_body.dart';
import 'models/chat_message.dart';

class EasyChat<Response> extends StatelessWidget {
  final SocketHelper socketType;
  final FutureOr Function(BuildContext context, ChatMessages message) onReceiveMessage;
  final PreferredSizeWidget appBar;
  final Widget bottomBar;
  final EasyPaginationController<ChatMessages> controller;
  final Future<Response> Function(int currentPage) asyncCall;
  final DataListAndPaginationData<ChatMessages> Function(Response response) mapper;
  final ErrorMapper errorMapper;
  final Widget? chatBackground;
  final Widget? loadingBuilder;
  final Widget Function(String error)? errorBuilder;
  final Widget Function(ChatMessages message) rightMessageBuilder;
  final Widget Function(ChatMessages message) leftMessageBuilder;
  final void Function(BuildContext context, ChatMessages message)? onMessageTap;
  final void Function(BuildContext context, ChatMessages message)? onMessageLongPress;
  final void Function(BuildContext context, ChatMessages message)? onMessageDoublePress;

  const EasyChat({super.key,
    required this.socketType,
    required this.onReceiveMessage,
    required this.appBar,
    required this.bottomBar,
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
    this.onMessageDoublePress
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        spacing: 20,
        children: [
          appBar,
          Expanded(
            child: Stack(
              children: [
                if(chatBackground != null)
                  chatBackground!,
                ChatBody<Response>(
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
            ),
          ),
          bottomBar
        ],
      ),
    );
  }
}