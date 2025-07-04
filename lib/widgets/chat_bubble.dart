import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
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
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
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
            if (failedToSend)
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Failed To Send",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
