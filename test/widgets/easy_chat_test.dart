// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:easy_chat/easy_chat.dart';
// import 'package:easy_chat/models/chat_message.dart';
// import 'package:pagify/helpers/data_and_pagination_data.dart';
// import 'package:pagify/helpers/errors.dart';
// import 'package:pagify/pagify.dart';
//
// void main() {
//   group('EasyChat Widget Tests', () {
//     late PagifyController<ChatMessages> controller;
//     late List<ChatMessages> mockMessages;
//
//     setUp(() {
//       controller = PagifyController<ChatMessages>();
//       mockMessages = [
//         ChatMessages(
//           message: Message(id: 1, type: 'text', body: 'Hello'),
//           sender: Sender(
//             id: 1,
//             name: 'John',
//             image: 'john.png',
//             isFromMe: false,
//           ),
//           time: '10:00 AM',
//           messageState: MessageState.read,
//         ),
//         ChatMessages(
//           message: Message(id: 2, type: 'text', body: 'Hi there!'),
//           sender: Sender(
//             id: 2,
//             name: 'Me',
//             image: 'me.png',
//             isFromMe: true,
//           ),
//           time: '10:01 AM',
//           messageState: MessageState.sent,
//         ),
//       ];
//     });
//
//     Future<List<ChatMessages>> mockAsyncCall(
//         BuildContext context, int page) async {
//       await Future.delayed(const Duration(milliseconds: 100));
//       return mockMessages;
//     }
//
//     PagifyData<ChatMessages> mockMapper(List<ChatMessages> response) {
//       return PagifyData(
//         data: response,
//         paginationData: PaginationData(perPage: 10, totalPages: 1),
//       );
//     }
//
//     Widget buildRightMessage(ChatMessages message) {
//       return Container(
//         key: const Key('right_message'),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           message.message.body,
//           style: const TextStyle(color: Colors.white),
//         ),
//       );
//     }
//
//     Widget buildLeftMessage(ChatMessages message) {
//       return Container(
//         key: const Key('left_message'),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(message.message.body),
//       );
//     }
//
//     testWidgets('EasyChat should render successfully',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: mockAsyncCall,
//               mapper: mockMapper,
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//             ),
//           ),
//         ),
//       );
//
//       expect(find.byType(EasyChat<List<ChatMessages>>), findsOneWidget);
//     });
//
//     testWidgets('EasyChat should display loading state initially',
//         (WidgetTester tester) async {
//       bool loadingCalled = false;
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: mockAsyncCall,
//               mapper: mockMapper,
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//               onLoading: () {
//                 loadingCalled = true;
//               },
//               loadingBuilder: const CircularProgressIndicator(
//                 key: Key('loading_indicator'),
//               ),
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       expect(find.byKey(const Key('loading_indicator')), findsOneWidget);
//     });
//
//     testWidgets('EasyChat should display messages after loading',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: mockAsyncCall,
//               mapper: mockMapper,
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       await tester.pump(const Duration(milliseconds: 200));
//
//       expect(find.text('Hello'), findsOneWidget);
//       expect(find.text('Hi there!'), findsOneWidget);
//     });
//
//     testWidgets('EasyChat should call onSuccess callback',
//         (WidgetTester tester) async {
//       bool successCalled = false;
//       List<ChatMessages>? receivedMessages;
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: mockAsyncCall,
//               mapper: mockMapper,
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//               onSuccess: (context, messages) {
//                 successCalled = true;
//                 receivedMessages = messages;
//               },
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       await tester.pump(const Duration(milliseconds: 200));
//
//       expect(successCalled, true);
//       expect(receivedMessages?.length, 2);
//     });
//
//     testWidgets('EasyChat should handle error state',
//         (WidgetTester tester) async {
//       Future<List<ChatMessages>> errorAsyncCall(
//           BuildContext context, int page) async {
//         await Future.delayed(const Duration(milliseconds: 100));
//         throw Exception('Network error');
//       }
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: errorAsyncCall,
//               mapper: mockMapper,
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//               errorBuilder: (error) => const Text(
//                 'Error loading messages',
//                 key: Key('error_text'),
//               ),
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       await tester.pump(const Duration(milliseconds: 200));
//
//       expect(find.byKey(const Key('error_text')), findsOneWidget);
//     });
//
//     testWidgets('EasyChat should display empty view when no messages',
//         (WidgetTester tester) async {
//       Future<List<ChatMessages>> emptyAsyncCall(
//           BuildContext context, int page) async {
//         return [];
//       }
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: emptyAsyncCall,
//               mapper: (response) => PagifyData(
//                 data: response,
//                 paginationData: PaginationData(perPage: 10, totalPages: 0),
//               ),
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//               emptyView: const Text(
//                 'No messages yet',
//                 key: Key('empty_view'),
//               ),
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       await tester.pump(const Duration(milliseconds: 200));
//
//       expect(find.byKey(const Key('empty_view')), findsOneWidget);
//     });
//
//     testWidgets('EasyChat should use right builder for my messages',
//         (WidgetTester tester) async {
//       final myMessagesList = [
//         ChatMessages(
//           message: Message(id: 1, type: 'text', body: 'My message'),
//           sender: Sender(
//             id: 1,
//             name: 'Me',
//             image: 'me.png',
//             isFromMe: true,
//           ),
//         ),
//       ];
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: (context, page) async => myMessagesList,
//               mapper: (response) => PagifyData(
//                 data: response,
//                 paginationData: PaginationData(perPage: 10, totalPages: 1),
//               ),
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       await tester.pump(const Duration(milliseconds: 200));
//
//       final container = tester.widget<Container>(
//         find.descendant(
//           of: find.byType(Container),
//           matching: find.byWidgetPredicate(
//             (widget) =>
//                 widget is Container &&
//                 widget.decoration is BoxDecoration &&
//                 (widget.decoration as BoxDecoration).color == Colors.blue,
//           ),
//         ),
//       );
//
//       expect((container.decoration as BoxDecoration).color, Colors.blue);
//     });
//
//     testWidgets('EasyChat should use left builder for other messages',
//         (WidgetTester tester) async {
//       final otherMessagesList = [
//         ChatMessages(
//           message: Message(id: 1, type: 'text', body: 'Other message'),
//           sender: Sender(
//             id: 2,
//             name: 'John',
//             image: 'john.png',
//             isFromMe: false,
//           ),
//         ),
//       ];
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: (context, page) async => otherMessagesList,
//               mapper: (response) => PagifyData(
//                 data: response,
//                 paginationData: PaginationData(perPage: 10, totalPages: 1),
//               ),
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       await tester.pump(const Duration(milliseconds: 200));
//
//       final container = tester.widget<Container>(
//         find.descendant(
//           of: find.byType(Container),
//           matching: find.byWidgetPredicate(
//             (widget) =>
//                 widget is Container &&
//                 widget.decoration is BoxDecoration &&
//                 (widget.decoration as BoxDecoration).color == Colors.grey[300],
//           ),
//         ),
//       );
//
//       expect((container.decoration as BoxDecoration).color, Colors.grey[300]);
//     });
//
//     testWidgets('EasyChat should handle custom cache extent',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: mockAsyncCall,
//               mapper: mockMapper,
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//               cacheExtent: 500.0,
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       expect(find.byType(EasyChat<List<ChatMessages>>), findsOneWidget);
//     });
//
//     testWidgets('EasyChat should handle no connection text',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: EasyChat<List<ChatMessages>>(
//               controller: controller,
//               asyncCall: mockAsyncCall,
//               mapper: mockMapper,
//               errorMapper: PagifyErrorMapper(),
//               rightMessageBuilder: buildRightMessage,
//               leftMessageBuilder: buildLeftMessage,
//               noConnectionText: 'No internet connection',
//             ),
//           ),
//         ),
//       );
//
//       await tester.pump();
//       expect(find.byType(EasyChat<List<ChatMessages>>), findsOneWidget);
//     });
//   });
// }
