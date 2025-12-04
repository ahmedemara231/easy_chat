# Easy Chat

A Flutter package that simplifies building chat interfaces with built-in reverse pagination, customizable message widgets, and connectivity handling.

## Features

- **Reverse Pagination**: Automatically handles loading older messages as users scroll up
- **Customizable Message Widgets**: Define separate builders for left and right message bubbles
- **Built-in Message States**: Support for pending, sent, delivered, and read message states
- **Connectivity Handling**: Monitors network connectivity and provides callbacks
- **Flexible Data Mapping**: Easy integration with any backend API response format
- **Error Handling**: Custom error builders and mappers for different error scenarios
- **Empty State Support**: Custom widgets for empty chat views
- **Performance Optimized**: Includes cache extent and item extent configuration options

## Installation

Add `easy_chat` to your `pubspec.yaml`:

```yaml
dependencies:
  easy_chat: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Requirements

- Flutter SDK: >=1.17.0
- Dart SDK: ^3.6.0

## Usage

### Basic Example

```dart
import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:pagify/helpers/data_and_pagination_data.dart';
import 'package:pagify/helpers/errors.dart';
import 'package:pagify/pagify.dart';

class ChatScreen extends StatelessWidget {
  final PagifyController<ChatMessages> _chatController = PagifyController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyChat(
        controller: _chatController,
        asyncCall: (context, page) async {
          // Fetch messages from your API
          return await fetchMessages(page);
        },
        mapper: (response) => PagifyData(
          data: response.messages,
          paginationData: PaginationData(
            perPage: response.perPage,
            totalPages: response.totalPages,
          ),
        ),
        errorMapper: PagifyErrorMapper(
          errorWhenDio: (e) => e.response?.data['error'],
        ),
        rightMessageBuilder: (message) => _buildMyMessage(message),
        leftMessageBuilder: (message) => _buildOtherMessage(message),
      ),
      bottomNavigationBar: _buildMessageInput(),
    );
  }

  Widget _buildMyMessage(ChatMessages message) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message.message.body,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildOtherMessage(ChatMessages message) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(message.message.body),
    );
  }

  Widget _buildMessageInput() {
    return TextField(
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            // Send message logic here
            // Then scroll to bottom
            _chatController.moveToMaxBottom();
          },
          icon: Icon(Icons.send),
        ),
      ),
    );
  }
}
```

### Advanced Example with Different Message Types

```dart
Widget _buildMessage(ChatMessages chatMessage) {
  if (chatMessage.message.body.contains('png') ||
      chatMessage.message.body.contains('jpg')) {
    return Image.network(chatMessage.message.body);
  } else if (chatMessage.message.body.contains('pdf')) {
    return PdfViewer(url: chatMessage.message.body);
  } else if (chatMessage.message.body.contains('mp4')) {
    return VideoPlayer(url: chatMessage.message.body);
  } else if (chatMessage.message.body.contains('mp3')) {
    return AudioPlayer(url: chatMessage.message.body);
  } else {
    return Text(chatMessage.message.body);
  }
}

EasyChat(
  controller: _chatController,
  asyncCall: fetchMessages,
  mapper: mapResponse,
  errorMapper: errorMapper,
  rightMessageBuilder: _buildMessage,
  leftMessageBuilder: _buildMessage,
  // Optional callbacks
  onLoading: () => print('Loading messages...'),
  onError: (context, page, error) => print('Error: $error'),
  onSuccess: (context, messages) => print('Loaded ${messages.length} messages'),
  onConnectivityChanged: (isConnected) => print('Connected: $isConnected'),
  // Optional custom widgets
  loadingBuilder: CircularProgressIndicator(),
  errorBuilder: (error) => Text('Error: ${error.message}'),
  emptyView: Text('No messages yet'),
  noConnectionText: 'No internet connection',
)
```

## Message Structure

The package uses a predefined message structure:

```dart
class ChatMessages {
  final Message message;
  final Sender sender;
  String? time;
  MessageState? messageState;
}

class Message {
  final int id;
  final String body;
  final String type;
}

class Sender {
  final int id;
  final String name;
  final String image;
  final bool isFromMe;  // Determines left vs right message placement
}

enum MessageState {
  pending,   // Message is being sent
  sent,      // Message sent to server
  delivered, // Message delivered to recipient
  read       // Message read by recipient
}
```

## Controller Methods

The `PagifyController` provides several useful methods:

```dart
// Scroll to the bottom of the chat (newest message)
_chatController.moveToMaxBottom();

// Refresh the chat
_chatController.refresh();

// Load more messages
_chatController.loadMore();
```

## Parameters

### Required Parameters

- `controller`: PagifyController instance to control the chat
- `asyncCall`: Function to fetch messages from your API
- `mapper`: Function to map API response to PagifyData format
- `errorMapper`: Maps errors from your API to display messages
- `rightMessageBuilder`: Widget builder for messages from current user
- `leftMessageBuilder`: Widget builder for messages from other users

### Optional Parameters

- `loadingBuilder`: Custom loading widget
- `errorBuilder`: Custom error widget builder
- `emptyView`: Widget to show when chat is empty
- `cacheExtent`: ListView cache extent for performance
- `itemExtent`: Fixed item extent if all messages have same height
- `noConnectionText`: Text to show when offline
- `onLoading`: Callback when loading messages
- `onError`: Callback when error occurs
- `onSuccess`: Callback when messages load successfully
- `onConnectivityChanged`: Callback when connectivity status changes

## Dependencies

This package depends on:
- [pagify](https://pub.dev/packages/pagify) - For pagination handling
- [connectivity_plus](https://pub.dev/packages/connectivity_plus) - For network connectivity monitoring

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Issues

If you encounter any issues, please file them on the [GitHub issue tracker](https://github.com/ahmedemara231/easy_chat/issues).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Ahmed Emara

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.
