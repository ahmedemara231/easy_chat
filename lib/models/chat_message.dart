import 'package:objectbox/objectbox.dart';

@Entity()
class ChatMessages{
  String? message;
  bool? isFromMe;
  int? id;
  String? image;
  String? time;
  String? type;

  ChatMessages({
    this.message,
    this.isFromMe,
    this.image,
    this.type,
    this.time,
    this.id = 0,
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