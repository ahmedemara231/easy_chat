class ChatMessages{
  final String senderImage;
  final String message;
  final String time;
  final bool  isFromMe;

  ChatMessages({
    required this.senderImage,
    required this.message,
    required this.time,
    required this.isFromMe
  });
}