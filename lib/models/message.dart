import 'package:scholar_chat/constants.dart';

class Message {
  final String messageContent;

  Message({required this.messageContent});

  factory Message.fromJson(jsonData) {
    return Message(messageContent: jsonData[kMessage]);
  }
}
