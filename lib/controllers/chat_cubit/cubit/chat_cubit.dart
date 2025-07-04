import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance
      .collection(kCollectionMessages);

  void sendMessage({required String message, required String email}) {
    emit(ChatLoading());
    try {
      messages.add({
        kMessage: message,
        kCreatedTime: DateTime.now(),
        kId: email,
      });
    } catch (e) {
      emit(ChatFailure());
    }
  }

  void getMessages() {
    messages
        .orderBy(kCreatedTime, descending: true)
        .snapshots()
        .listen((event) {
          List<MessageModel> messageList = [];
          for (var doc in event.docs) {
            messageList.add(MessageModel.fromJson(doc));
          }
          emit(ChatSuccess(messageList));
        });
  }
}
