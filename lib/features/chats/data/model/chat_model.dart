
import 'package:what_s_up_app/features/chats/data/model/sender_model.dart';

class ChatModel {
  final String id;
  final Sender sender;
  final String lastMessage;
  final DateTime timestamp;
  final MessageStatusEnum status;
  final int numberOfUnreadMessages;

  ChatModel({
    required this.id,
    required this.status,
    required this.sender,
    required this.lastMessage,
    required this.timestamp,
    required this.numberOfUnreadMessages,
  });
}
enum MessageStatusEnum { sent, delivered, seen, recived }