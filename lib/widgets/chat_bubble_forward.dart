import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message_model.dart';

class ChatBubbleForward extends StatelessWidget {
  const ChatBubbleForward({
    super.key,
    required this.message,
    this.failedToSend = false,
    this.isSending = false,
  });

  final MessageModel message;
  final bool failedToSend;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IntrinsicWidth(
            child: Container(
              alignment: Alignment.centerRight,
              height: 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                border:
                    failedToSend
                        ? Border.all(color: Colors.red, width: 1.0)
                        : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      message.messageContent,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  if (isSending) ...[
                    SizedBox(width: 8),
                    SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (failedToSend)
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Text(
                "Failed To Send",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
