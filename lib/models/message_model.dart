import 'package:scholar_chat/constants.dart';

class MessageModel {
  final String messageContent;
  final String id;
  MessageModel({required this.messageContent, required this.id});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      messageContent: jsonData[kMessage] ?? '',
      id: jsonData[kId] ?? '',
    );
  }
}
