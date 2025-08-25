import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/features/chats/data/model/chat_model.dart';
import 'package:what_s_up_app/features/chats/data/model/sender_model.dart';
import 'package:what_s_up_app/features/chats/presentation/cubit/chat_state.dart';
class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  static ChatsCubit get(BuildContext context) =>
      BlocProvider.of<ChatsCubit>(context);

  int selectedFilterIndex = 0;

  void changeSelectedChatFilter(int index) {
    selectedFilterIndex = index;
    emit(ChatsFilterState(selectedFilterIndex));
  }
  int  unreadChatsNum = 0;
  int get unreadChatsCount {
    unreadChatsNum = chatDataList.where((chat) => chat.numberOfUnreadMessages > 0).length;
    return unreadChatsNum;
  }

  List<ChatModel> get filteredChats {
    switch (selectedFilterIndex) {
      case 0:
        return chatDataList;
      case 1:
        return chatDataList
            .where((chat) => chat.numberOfUnreadMessages > 0)
            .toList();
      case 2:
        return [];
      case 3:
        return [];
      default:
        return chatDataList;
    }
  }

  final List<ChatModel> chatDataList = [
    ChatModel(
      id: '1',
      sender: Sender(
        name: 'Sarah Johnson',
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Hey! How are you doing today?',
      timestamp: DateTime(2025, 8, 19, 2, 30), // Today - shows "9:30 PM"
      status: MessageStatusEnum.seen,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '2',
      sender: Sender(
        name: 'Mike Chen',
        image:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Can you send me the project files?',
      timestamp: DateTime(2025, 8, 19, 1, 30), // Today - shows "9:30 PM"
      status: MessageStatusEnum.delivered,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '3',
      sender: Sender(
        name: 'Emma Wilson',
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Thanks for your help yesterday! 😊',
      timestamp: DateTime(2025, 8, 18, 20, 15), // Today - shows "8:15 PM"
      status: MessageStatusEnum.seen,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '4',
      sender: Sender(
        name: 'Alex Rodriguez',
        image:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Are we still meeting at 3 PM?',
      timestamp: DateTime(2025, 8, 18, 15, 45), // Today - shows "3:45 PM"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 2,
    ),
    ChatModel(
      id: '5',
      sender: Sender(
        name: 'Lisa Park',
        image:
            'https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Great job on the presentation!',
      timestamp: DateTime(2025, 8, 18, 14, 22), // Today - shows "2:22 PM"
      status: MessageStatusEnum.seen,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '6',
      sender: Sender(
        name: 'David Kim',
        image:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Let me know when you arrive',
      timestamp: DateTime(2025, 8, 18, 11, 11), // Today - shows "11:11 AM"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 100,
    ),
    ChatModel(
      id: '7',
      sender: Sender(
        name: 'Jessica Taylor',
        image:
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'The weather is amazing today! ☀️',
      timestamp: DateTime(2025, 8, 18, 9, 33), // Today - shows "9:33 AM"
      status: MessageStatusEnum.delivered,
      numberOfUnreadMessages: 5,
    ),
    ChatModel(
      id: '8',
      sender: Sender(
        name: 'Ryan Murphy',
        image:
            'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Can we reschedule our call?',
      timestamp: DateTime(2025, 8, 17, 23, 11), // Yesterday - shows "8/17/2025"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 1,
    ),
    ChatModel(
      id: '9',
      sender: Sender(
        name: 'Amanda Foster',
        image:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Happy birthday! 🎉🎂',
      timestamp: DateTime(2025, 8, 17, 18, 45), // Yesterday - shows "8/17/2025"
      status: MessageStatusEnum.seen,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '10',
      sender: Sender(
        name: 'Chris Anderson',
        image:
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Did you see the news about the company?',
      timestamp: DateTime(2025, 8, 17, 14, 20), // Yesterday - shows "8/17/2025"
      status: MessageStatusEnum.delivered,
      numberOfUnreadMessages: 7,
    ),
    ChatModel(
      id: '11',
      sender: Sender(
        name: 'Maya Patel',
        image:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Coffee tomorrow morning?',
      timestamp: DateTime(
        2025,
        8,
        16,
        22,
        30,
      ), // 2 days ago - shows "8/16/2025"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 2,
    ),
    ChatModel(
      id: '12',
      sender: Sender(
        name: 'Tom Wilson',
        image:
            'https://images.unsplash.com/photo-1507591064344-4c6ce005b128?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Thanks for the recommendation!',
      timestamp: DateTime(
        2025,
        8,
        16,
        16,
        15,
      ), // 2 days ago - shows "8/16/2025"
      status: MessageStatusEnum.seen,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '13',
      sender: Sender(
        name: 'Sophie Brown',
        image:
            'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'The meeting went really well!',
      timestamp: DateTime(
        2025,
        8,
        15,
        19,
        45,
      ), // 3 days ago - shows "8/15/2025"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 12,
    ),
    ChatModel(
      id: '14',
      sender: Sender(
        name: 'Jake Martinez',
        image:
            'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Can you help me with this issue?',
      timestamp: DateTime(
        2025,
        8,
        15,
        13,
        11,
      ), // 3 days ago - shows "8/15/2025"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 4,
    ),
    ChatModel(
      id: '15',
      sender: Sender(
        name: 'Rachel Green',
        image:
            'https://images.unsplash.com/photo-1464863979621-258859e62245?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'See you at the party tonight! 🎊',
      timestamp: DateTime(
        2025,
        8,
        14,
        20,
        30,
      ), // 4 days ago - shows "8/14/2025"
      status: MessageStatusEnum.delivered,
      numberOfUnreadMessages: 1,
    ),
    ChatModel(
      id: '16',
      sender: Sender(
        name: 'Mark Thompson',
        image:
            'https://images.unsplash.com/photo-1463453091185-61582044d556?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'The project deadline is next week',
      timestamp: DateTime(
        2025,
        8,
        13,
        11,
        11,
      ), // 5 days ago - shows "8/13/2025"
      status: MessageStatusEnum.seen,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '17',
      sender: Sender(
        name: 'Olivia Davis',
        image:
            'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Love the new design! 💖',
      timestamp: DateTime(
        2025,
        8,
        12,
        17,
        22,
      ), // 6 days ago - shows "8/12/2025"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 8,
    ),
    ChatModel(
      id: '18',
      sender: Sender(
        name: 'James Lee',
        image:
            'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: "Let's grab lunch this weekend",
      timestamp: DateTime(
        2025,
        8,
        11,
        12,
        45,
      ), // 7 days ago - shows "8/11/2025"
      status: MessageStatusEnum.sent,
      numberOfUnreadMessages: 0,
    ),
    ChatModel(
      id: '19',
      sender: Sender(
        name: 'Natalie White',
        image:
            'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'The vacation photos look amazing!',
      timestamp: DateTime(
        2025,
        8,
        10,
        23,
        11,
      ), // 8 days ago - shows "8/10/2025"
      status: MessageStatusEnum.recived,
      numberOfUnreadMessages: 3,
    ),
    ChatModel(
      id: '20',
      sender: Sender(
        name: 'Kevin Garcia',
        image:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=400&h=400&fit=crop&crop=face',
      ),
      lastMessage: 'Thanks for all your help with the move! 📦',
      timestamp: DateTime(2025, 8, 9, 16, 33), // 9 days ago - shows "8/9/2025"
      status: MessageStatusEnum.seen,
      numberOfUnreadMessages: 0,
    ),
  ];
}