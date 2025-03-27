import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.index,
  });
  final Message message;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 50,

          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(
            message.messageContent,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
