part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

// ignore: must_be_immutable
final class ChatSuccess extends ChatState {
  List<MessageModel> messageList;

  ChatSuccess(this.messageList);
}

final class ChatLoading extends ChatState {}

final class ChatFailure extends ChatState {}
