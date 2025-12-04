import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_chat/models/chat_message.dart';
import 'package:easy_chat/widgets/message_widget.dart';

void main() {
  group('MessageWidget Tests', () {
    late ChatMessages myMessage;
    late ChatMessages otherMessage;

    setUp(() {
      myMessage = ChatMessages(
        message: Message(id: 1, type: 'text', body: 'My message'),
        sender: Sender(
          id: 1,
          name: 'Me',
          image: 'me.png',
          isFromMe: true,
        ),
      );

      otherMessage = ChatMessages(
        message: Message(id: 2, type: 'text', body: 'Other message'),
        sender: Sender(
          id: 2,
          name: 'John',
          image: 'john.png',
          isFromMe: false,
        ),
      );
    });

    testWidgets('MessageWidget should render right message for isFromMe=true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageWidget(
              message: myMessage,
              rightMessageBuilder: (msg) => Container(
                key: const Key('right_message'),
                child: Text(msg.message.body),
              ),
              leftMessageBuilder: (msg) => Container(
                key: const Key('left_message'),
                child: Text(msg.message.body),
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('right_message')), findsOneWidget);
      expect(find.byKey(const Key('left_message')), findsNothing);
      expect(find.text('My message'), findsOneWidget);
    });

    testWidgets('MessageWidget should render left message for isFromMe=false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageWidget(
              message: otherMessage,
              rightMessageBuilder: (msg) => Container(
                key: const Key('right_message'),
                child: Text(msg.message.body),
              ),
              leftMessageBuilder: (msg) => Container(
                key: const Key('left_message'),
                child: Text(msg.message.body),
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('left_message')), findsOneWidget);
      expect(find.byKey(const Key('right_message')), findsNothing);
      expect(find.text('Other message'), findsOneWidget);
    });

    testWidgets('MessageWidget should use custom builders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageWidget(
              message: myMessage,
              rightMessageBuilder: (msg) => Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  msg.message.body,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              leftMessageBuilder: (msg) => Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(msg.message.body),
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, Colors.blue);
      expect(decoration.borderRadius, BorderRadius.circular(12));
      expect(find.text('My message'), findsOneWidget);
    });

    testWidgets('MessageWidget should handle different message types',
        (WidgetTester tester) async {
      final imageMessage = ChatMessages(
        message: Message(id: 3, type: 'image', body: 'image.png'),
        sender: Sender(
          id: 1,
          name: 'Me',
          image: 'me.png',
          isFromMe: true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageWidget(
              message: imageMessage,
              rightMessageBuilder: (msg) {
                if (msg.message.body.contains('png')) {
                  return const Icon(Icons.image, key: Key('image_icon'));
                }
                return Text(msg.message.body);
              },
              leftMessageBuilder: (msg) => Text(msg.message.body),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('image_icon')), findsOneWidget);
    });

    testWidgets('MessageWidget should display message state indicators',
        (WidgetTester tester) async {
      final sentMessage = ChatMessages(
        message: Message(id: 1, type: 'text', body: 'Sent message'),
        sender: Sender(
          id: 1,
          name: 'Me',
          image: 'me.png',
          isFromMe: true,
        ),
        messageState: MessageState.sent,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageWidget(
              message: sentMessage,
              rightMessageBuilder: (msg) => Row(
                children: [
                  Text(msg.message.body),
                  if (msg.messageState == MessageState.sent)
                    const Icon(Icons.check, key: Key('sent_icon')),
                  if (msg.messageState == MessageState.delivered)
                    const Icon(Icons.done_all, key: Key('delivered_icon')),
                ],
              ),
              leftMessageBuilder: (msg) => Text(msg.message.body),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('sent_icon')), findsOneWidget);
      expect(find.byKey(const Key('delivered_icon')), findsNothing);
    });
  });
}
