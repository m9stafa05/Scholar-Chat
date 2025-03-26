import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  final List<String> messages = [
    "Hello!",
    "How are you?",
    "This is a longer message to test the dynamic width of the chat bubble.",
    "Short msg",
    "Flutter is awesome!",
    "Hello!",
    "How are you?",
    "This is a longer message to test the dynamic width of the chat bubble.",
    "Short msg",
    "Flutter is awesome!",
    "Hello!",
    "How are you?",
    "This is a longer message to test the dynamic width of the chat bubble.",
    "Short msg",
    "Flutter is awesome!",
    "Hello!",
    "How are you?",
    "This is a longer message to test the dynamic width of the chat bubble.",
    "Short msg",
    "Flutter is awesome!",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(kLogo), height: 50),
            Text(
              '  Chat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
          ],
        ),
        elevation: 50,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: messages[index],
                  index: index,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
                suffixIcon: IconButton(
                  color: kPrimaryColor,
                  hoverColor: Colors.blue,
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
