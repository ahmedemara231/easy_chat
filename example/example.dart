import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/factory.dart';
import 'package:easy_chat/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:pagify/helpers/data_and_pagination_data.dart';
import 'package:pagify/helpers/errors.dart';
import 'package:pagify/pagify.dart';

void main() {
  runApp(EasyChatExample());
}

class EasyChatExample extends StatelessWidget {
  const EasyChatExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Example(),
    );
  }
}

class Example extends StatelessWidget {
  Example({super.key});

  final PagifyController<ChatMessages> _chatController = PagifyController();
  Future<List<ChatMessages>> testFun(int currentPage)async {
    List<ChatMessages> msgs = [];
    await Future.delayed(const Duration(seconds: 2));
    msgs.addAll([
      ChatMessages(image: 'image', message: 'message1', time: 'time1', type: 'text', isFromMe: true),
      ChatMessages(image: 'image', message: 'message2', time: 'time1', type: 'text', isFromMe: true),
      ChatMessages(image: 'image', message: 'message3', time: 'time1', type: 'text', isFromMe: false),
      ChatMessages(image: 'image', message: 'message4', time: 'time1', type: 'text', isFromMe: false),
      ChatMessages(image: 'image', message: 'message5', time: 'time1', type: 'text', isFromMe: true),
      ChatMessages(image: 'image', message: 'message6', time: 'time1', type: 'text', isFromMe: false),
    ]);
    return msgs;
  }

  Widget _buildMessage(ChatMessages chatMessage) {
    if(chatMessage.message.contains('png')){
      return Image.network(chatMessage.message);
    }else if(chatMessage.message.contains('pdf')){
      // return pgf file
      return SizedBox.shrink();
    }else if(chatMessage.message.contains('mp4')){
      // return video
      return SizedBox.shrink();
    }else if(chatMessage.message.contains('mp3')){
      // return audio
      return SizedBox.shrink();
    }else{
      return Text(chatMessage.message);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyChat(
        socketType: ClientIOImpl(
          url: 'server url',
          extraHeaders: {},
          extraParams: {},
          events: EasyChatEvents(
            otherEvents: [],
            messageEvents: MessageEvents(
                  receiveMsgEvent: 'receiveMsgEvent',
                  sendMsgEvent: 'sendMsgEvent'
              ), chatEvents: ChatEvents(enterChatEvent: 'enterChatEvent', exitChatEvent: 'exitChatEvent'),
          ),
          jsonToChatMessage: (jsonMessage) => ChatMessages(
              image: jsonMessage['senderImage'],
              message: jsonMessage['message'],
              time: jsonMessage['time'],
              isFromMe: jsonMessage['isFromMe'], type: jsonMessage['type']
          ),
          onReceiveMessage: (msg){},
          onReceiveAnyEvent: (e, d){}, roomId: 0
        ),
          controller: _chatController,
          asyncCall: (context, page) async => await testFun(page),
          mapper: (response) => PagifyData(
              data: response,
              paginationData: PaginationData(
                  perPage: 10, totalPages: 3
              )
          ),
          errorMapper: PagifyErrorMapper(errorWhenDio: (e) => e.response?.data['error']),
          rightMessageBuilder: _buildMessage,
          leftMessageBuilder: _buildMessage,
      ),
      bottomNavigationBar: TextField(
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: (){
            // send any chat message,

            // move to max bottom like any chat
            _chatController.moveToMaxBottom();
          }, icon: Icon(Icons.send)),
        ),
      ),
    );
  }
}
