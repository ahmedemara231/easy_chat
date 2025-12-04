import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pagify/helpers/data_and_pagination_data.dart';
import 'package:pagify/helpers/errors.dart';
import 'package:pagify/pagify.dart';
import 'widgets/chat_body.dart';
import 'models/chat_message.dart';

class EasyChat<Response> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChatBody<Response>(
      noConnectionText: noConnectionText,
      emptyView: emptyView,
      onLoading: onLoading,
      onError: onError,
      onSuccess: onSuccess,
      onConnectivityChanged: onConnectivityChanged,
      cacheExtent: cacheExtent,
      itemExtent: itemExtent,
      errorMapper: errorMapper,
      mapper: mapper,
      asyncCall: asyncCall,
      controller: controller,
      rightMessageBuilder: rightMessageBuilder,
      leftMessageBuilder: leftMessageBuilder,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
    );
  }
}