import 'package:easy_chat/easy_chat.dart';
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
      ChatMessages(
        message: Message(id: 0, type: 'type', body: 'body'),
        sender: Sender(id: 0, name: 'name', image: 'image', isFromMe: true),
        messageState: MessageState.sent,
        time: '',
      ),
      ChatMessages(
        message: Message(id: 0, type: 'type', body: 'body'),
        sender: Sender(id: 0, name: 'name', image: 'image', isFromMe: true),
        messageState: MessageState.sent,
        time: '',
      ),
    ]);
    return msgs;
  }

  Widget _buildMessage(ChatMessages chatMessage) {
    if(chatMessage.message.body.contains('png')){
      return Image.network(chatMessage.message.body);
    }else if(chatMessage.message.body.contains('pdf')){
      // return pgf file
      return SizedBox.shrink();
    }else if(chatMessage.message.body.contains('mp4')){
      // return video
      return SizedBox.shrink();
    }else if(chatMessage.message.body.contains('mp3')){
      // return audio
      return SizedBox.shrink();
    }else{
      return Text(chatMessage.message.body);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyChat(
          controller: _chatController,
          asyncCall: (context, page) async => await testFun(page),
          mapper: (response) => PagifyData(
              data: response,
              paginationData: PaginationData(
                  perPage: 10, totalPages: 3
              )
          ),
          messageAlignment: (fromMe) => MainAxisAlignment.end,
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
