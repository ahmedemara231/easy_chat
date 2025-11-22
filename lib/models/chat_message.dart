class ChatMessages{
  final String message;
  final bool isFromMe;
  final int? id;
  final String? image;
  final String? time;
  final String? type;

  ChatMessages({
    required this.message,
    required this.isFromMe,
    this.image,
    this.type,
    this.time,
    this.id,
  });

  factory ChatMessages.fromJson(Map<String, dynamic> json) => ChatMessages(
    image: json['avatar'],
    message: json['body'],
    time: json['created_at'],
    type: json['type'],
    isFromMe: (json['sender_id'] as int) == 0? false : true,
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'body': message,
    'type': type,
  };
}