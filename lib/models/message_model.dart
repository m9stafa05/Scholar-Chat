import 'package:scholar_chat/constants.dart';

class Message {
  final String messageContent;
  final String id;
  Message({required this.messageContent, required this.id});

  factory Message.fromJson(jsonData) {
    return Message(
      messageContent: jsonData[kMessage] ?? '',
      id: jsonData[kId] ?? '',
    );
  }
}
