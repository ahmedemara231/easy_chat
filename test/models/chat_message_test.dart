// import 'package:flutter_test/flutter_test.dart';
// import 'package:easy_chat/models/chat_message.dart';
//
// void main() {
//   group('Message Model Tests', () {
//     test('Message should be created with all required fields', () {
//       final message = Message(
//         id: 1,
//         type: 'text',
//         body: 'Hello World',
//       );
//
//       expect(message.id, 1);
//       expect(message.type, 'text');
//       expect(message.body, 'Hello World');
//     });
//
//     test('Message should handle different types', () {
//       final textMessage = Message(id: 1, type: 'text', body: 'Text');
//       final imageMessage = Message(id: 2, type: 'image', body: 'image.png');
//       final videoMessage = Message(id: 3, type: 'video', body: 'video.mp4');
//
//       expect(textMessage.type, 'text');
//       expect(imageMessage.type, 'image');
//       expect(videoMessage.type, 'video');
//     });
//
//     test('Message should handle empty body', () {
//       final message = Message(id: 1, type: 'text', body: '');
//       expect(message.body, '');
//     });
//   });
//
//   group('Sender Model Tests', () {
//     test('Sender should be created with all required fields', () {
//       final sender = Sender(
//         id: 1,
//         name: 'John Doe',
//         image: 'avatar.png',
//         isFromMe: true,
//       );
//
//       expect(sender.id, 1);
//       expect(sender.name, 'John Doe');
//       expect(sender.image, 'avatar.png');
//       expect(sender.isFromMe, true);
//     });
//
//     test('Sender isFromMe should determine message alignment', () {
//       final mySender = Sender(
//         id: 1,
//         name: 'Me',
//         image: 'me.png',
//         isFromMe: true,
//       );
//
//       final otherSender = Sender(
//         id: 2,
//         name: 'Other',
//         image: 'other.png',
//         isFromMe: false,
//       );
//
//       expect(mySender.isFromMe, true);
//       expect(otherSender.isFromMe, false);
//     });
//   });
//
//   group('ChatMessages Model Tests', () {
//     test('ChatMessages should be created with required fields', () {
//       final message = Message(id: 1, type: 'text', body: 'Hello');
//       final sender = Sender(
//         id: 1,
//         name: 'John',
//         image: 'avatar.png',
//         isFromMe: true,
//       );
//
//       final chatMessage = ChatMessages(
//         message: message,
//         sender: sender,
//       );
//
//       expect(chatMessage.message, message);
//       expect(chatMessage.sender, sender);
//       expect(chatMessage.time, null);
//       expect(chatMessage.messageState, null);
//     });
//
//     test('ChatMessages should handle optional time field', () {
//       final message = Message(id: 1, type: 'text', body: 'Hello');
//       final sender = Sender(
//         id: 1,
//         name: 'John',
//         image: 'avatar.png',
//         isFromMe: true,
//       );
//
//       final chatMessage = ChatMessages(
//         message: message,
//         sender: sender,
//         time: '10:30 AM',
//       );
//
//       expect(chatMessage.time, '10:30 AM');
//     });
//
//     test('ChatMessages should handle optional messageState field', () {
//       final message = Message(id: 1, type: 'text', body: 'Hello');
//       final sender = Sender(
//         id: 1,
//         name: 'John',
//         image: 'avatar.png',
//         isFromMe: true,
//       );
//
//       final chatMessage = ChatMessages(
//         message: message,
//         sender: sender,
//         messageState: MessageState.sent,
//       );
//
//       expect(chatMessage.messageState, MessageState.sent);
//     });
//
//     test('ChatMessages messageState can be updated', () {
//       final message = Message(id: 1, type: 'text', body: 'Hello');
//       final sender = Sender(
//         id: 1,
//         name: 'John',
//         image: 'avatar.png',
//         isFromMe: true,
//       );
//
//       final chatMessage = ChatMessages(
//         message: message,
//         sender: sender,
//         messageState: MessageState.pending,
//       );
//
//       expect(chatMessage.messageState, MessageState.pending);
//
//       chatMessage.messageState = MessageState.sent;
//       expect(chatMessage.messageState, MessageState.sent);
//
//       chatMessage.messageState = MessageState.delivered;
//       expect(chatMessage.messageState, MessageState.delivered);
//
//       chatMessage.messageState = MessageState.read;
//       expect(chatMessage.messageState, MessageState.read);
//     });
//   });
//
//   group('MessageState Enum Tests', () {
//     test('MessageState should have all expected values', () {
//       expect(MessageState.values.length, 4);
//       expect(MessageState.values.contains(MessageState.pending), true);
//       expect(MessageState.values.contains(MessageState.sent), true);
//       expect(MessageState.values.contains(MessageState.delivered), true);
//       expect(MessageState.values.contains(MessageState.read), true);
//     });
//
//     test('MessageState should be comparable', () {
//       expect(MessageState.pending, MessageState.pending);
//       expect(MessageState.sent, isNot(MessageState.pending));
//       expect(MessageState.delivered, isNot(MessageState.sent));
//       expect(MessageState.read, isNot(MessageState.delivered));
//     });
//   });
// }
