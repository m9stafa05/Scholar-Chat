import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/widgets/chat_bubble_forward.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance
      .collection(kCollectionMessages);

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController =
      ScrollController(); // Added ScrollController

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments as String?;
    return StreamBuilder<QuerySnapshot>(
      stream:
          messages
              .orderBy(kCreatedTime, descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              MessageModel.fromJson(snapshot.data!.docs[i]),
            );
          }
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
                    reverse: true,
                    controller:
                        scrollController, // Attach ScrollController
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(message: messagesList[index])
                          : ChatBubbleForward(
                            message: messagesList[index],
                          );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedTime: DateTime.now(),
                        kId: email,
                      });
                      messageController.clear();
                      scrollController.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      ); // Scroll to the bottom
                    },
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
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            messages.add({
                              kMessage: messageController.text,
                              kCreatedTime: DateTime.now(),
                              kId: email,
                            });
                            messageController.clear();
                            scrollController.animateTo(
                              0,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            ); // Scroll to the bottomroll to the bottom
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}
