import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/controllers/chat_cubit/cubit/chat_cubit.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';
import 'package:scholar_chat/widgets/chat_bubble_forward.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool failedToSend = false;
  bool isSending = false;

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments as String?;
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
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatLoading) {
            isSending = true;
          } else if (state is ChatSuccess) {
            isSending = false;
          } else if (state is ChatFailure) {
            isSending = false;
            failedToSend = true;
          }
        },
        builder: (context, state) {
          var messagesList =
              BlocProvider.of<ChatCubit>(context).messageList;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller:
                      scrollController, // Attach ScrollController
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBubble(
                          message: messagesList[index],
                          failedToSend: failedToSend,
                          isSending: isSending,
                        )
                        : ChatBubbleForward(
                          message: messagesList[index],
                          failedToSend: failedToSend,
                          isSending: isSending,
                        );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: messageController,
                  onSubmitted: (data) {
                    BlocProvider.of<ChatCubit>(context).sendMessage(
                      message: messageController.text,
                      email: email!,
                    );
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
                        BlocProvider.of<ChatCubit>(
                          context,
                        ).sendMessage(
                          message: messageController.text,
                          email: email!,
                        );
                        if (messageController.text.isNotEmpty) {
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
          );
        },
      ),
    );
  }
}
