import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.text,
    required this.index,
  });
  final String text;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          index % 2 == 0
              ? Alignment.centerLeft
              : Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 50,

          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: index % 2 == 0 ? Colors.blue : Colors.green,
            borderRadius:
                index % 2 == 0
                    ? BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )
                    : BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
