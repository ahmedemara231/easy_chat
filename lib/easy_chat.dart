import 'package:easy_pagination/pagination_with_reverse_and_status_stream.dart';
import 'package:flutter/material.dart';
import 'widgets/chat_body.dart';
import 'models/chat_message.dart';

class EasyChat<Response> extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget bottomBar;
  final EasyPaginationController<ChatMessages> controller;
  final Future<Response> Function(int currentPage) asyncCall;
  final DataListAndPaginationData<ChatMessages> Function(Response response) mapper;
  final ErrorMapper errorMapper;
  final Widget? loadingBuilder;
  final Widget Function(String)? errorBuilder;
  final Widget Function(ChatMessages message) rightMessageBuilder;
  final Widget Function(ChatMessages message) leftMessageBuilder;
  final Function(ChatMessages message)? onMessageTap;
  final void Function()? onMessageLongPress;
  final void Function()? onMessageDoublePress;

  const EasyChat({super.key,
    required this.appBar,
    required this.bottomBar,
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
    return SafeArea(
      child: Column(
        spacing: 20,
        children: [
          appBar,
          Expanded(
            child: ChatBody<Response>(
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
          ),
          bottomBar
        ],
      ),
    );
  }
}