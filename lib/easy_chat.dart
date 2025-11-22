import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pagify/helpers/data_and_pagination_data.dart';
import 'package:pagify/helpers/errors.dart';
import 'package:pagify/pagify.dart';
import 'factory.dart';
import 'widgets/chat_body.dart';
import 'models/chat_message.dart';

class EasyChat<Response> extends StatefulWidget {
  final SocketHelper socketType;
  final PagifyController<ChatMessages> controller;
  final Future<Response> Function(BuildContext context, int currentPage) asyncCall;
  final PagifyData<ChatMessages> Function(Response response) mapper;
  final PagifyErrorMapper errorMapper;
  final Widget? loadingBuilder;
  final Widget Function(PagifyException e)? errorBuilder;
  final Widget Function(ChatMessages message) rightMessageBuilder;
  final Widget Function(ChatMessages message) leftMessageBuilder;
  final double? cacheExtent;
  final double? itemExtent;
  final String? noConnectionText;
  final Widget? emptyView;
  final FutureOr<void> Function()? onLoading;
  final FutureOr<void> Function(BuildContext, int, PagifyException)? onError;
  final FutureOr<void> Function(BuildContext, List<ChatMessages>)? onSuccess;
  final FutureOr<void> Function(bool isConnect)? onConnectivityChanged;


  const EasyChat({super.key,
    required this.socketType,
    required this.controller,
    required this.asyncCall,
    required this.mapper,
    required this.errorMapper,
    required this.rightMessageBuilder,
    required this.leftMessageBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.cacheExtent,
    this.itemExtent,
    this.onLoading,
    this.onError,
    this.onSuccess,
    this.onConnectivityChanged,
    this.noConnectionText,
    this.emptyView,
  });

  @override
  State<EasyChat<Response>> createState() => _EasyChatState<Response>();
}

class _EasyChatState<Response> extends State<EasyChat<Response>> {

  void _init() async {
    widget.socketType
      ..initSocket()
      ..initConfig()
      ..connect();
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
    return ChatBody<Response>(
      noConnectionText: widget.noConnectionText,
      emptyView: widget.emptyView,
      onLoading: widget.onLoading,
      onError: widget.onError,
      onSuccess: widget.onSuccess,
      onConnectivityChanged: widget.onConnectivityChanged,
      cacheExtent: widget.cacheExtent,
      itemExtent: widget.itemExtent,
      errorMapper: widget.errorMapper,
      mapper: widget.mapper,
      asyncCall: widget.asyncCall,
      controller: widget.controller,
      rightMessageBuilder: widget.rightMessageBuilder,
      leftMessageBuilder: widget.leftMessageBuilder,
      errorBuilder: widget.errorBuilder,
      loadingBuilder: widget.loadingBuilder,
    );
  }
}