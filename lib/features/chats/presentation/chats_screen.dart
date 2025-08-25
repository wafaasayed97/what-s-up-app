import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:what_s_up_app/core/extensions/ext.dart';
import 'package:what_s_up_app/features/chats/data/model/chat_model.dart';
import 'package:what_s_up_app/features/chats/presentation/cubit/chat_cubit.dart';
import 'package:what_s_up_app/features/chats/presentation/cubit/chat_state.dart';
import 'package:what_s_up_app/features/chats/presentation/widgts/archived_section.dart';
import 'package:what_s_up_app/features/chats/presentation/widgts/search_bar.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        final cubit = ChatsCubit.get(context);
        
        return Scaffold(
        
          body: Column(
            children: [
              SearchBarChat(
                controller: searchController,
                onClear: () {},
                onChanged: (String value) {},
              ),
              // Filter Tabs
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  children: [
                    _buildFilterTab('All', 0, cubit, isSelected: cubit.selectedFilterIndex == 0),
                    10.wSpace,
                    _buildFilterTab('Unread', 1, cubit, 
                        isSelected: cubit.selectedFilterIndex == 1, 
                        badgeCount: cubit.unreadChatsCount),
                    10.wSpace,
                    _buildFilterTab('Favourite', 2, cubit, isSelected: cubit.selectedFilterIndex == 2),
                    10.wSpace,
                    _buildFilterTab('Groups', 3, cubit, isSelected: cubit.selectedFilterIndex == 3),
                  ],
                ),
              ),
              // Archived Section
              ArchivedSection(),
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat = cubit.filteredChats[index];
                    return _buildChatTile(chat);
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              currentIndex: 3, // Chats tab selected
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.update),
                  label: 'Updates',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: 'Calls',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Communities',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterTab(String text, int index, ChatsCubit cubit, 
      {bool isSelected = false, int? badgeCount}) {
    return GestureDetector(
      onTap: () => cubit.changeSelectedChatFilter(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.black87,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            if (badgeCount != null && badgeCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChatTile(ChatModel chat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar with online indicator
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: chat.sender.image != null 
                    ? NetworkImage(chat.sender.image!) 
                    : null,
                backgroundColor: Colors.grey[300],
                child: chat.sender.image == null
                    ? Text(
                        _getInitials(chat.sender.name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    : null,
              ),
              // You can add online indicator logic here if needed
              // if (chat.isOnline)
              //   Positioned(
              //     right: 2,
              //     bottom: 2,
              //     child: Container(
              //       width: 14,
              //       height: 14,
              //       decoration: BoxDecoration(
              //         color: Colors.green,
              //         shape: BoxShape.circle,
              //         border: Border.all(color: Colors.white, width: 2),
              //       ),
              //     ),
              //   ),
            ],
          ),
          
          const SizedBox(width: 12),
          
          // Chat content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chat.sender.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _formatTime(chat.timestamp),
                      style: TextStyle(
                        color: chat.numberOfUnreadMessages > 0 ? Colors.green : Colors.grey,
                        fontSize: 12,
                        fontWeight: chat.numberOfUnreadMessages > 0 ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 2),
                
                Row(
                  children: [
                    // Message status icons
                    if (chat.status == MessageStatusEnum.sent)
                      const Icon(
                        Icons.done,
                        size: 16,
                        color: Colors.grey,
                      ),
                    if (chat.status == MessageStatusEnum.delivered)
                      const Icon(
                        Icons.done_all,
                        size: 16,
                        color: Colors.grey,
                      ),
                    if (chat.status == MessageStatusEnum.seen)
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color: Colors.blue[400],
                      ),
                    if (chat.status != MessageStatusEnum.recived) 
                      const SizedBox(width: 4),
                    
                    Expanded(
                      child: Text(
                        chat.lastMessage,
                        style: TextStyle(
                          color: chat.numberOfUnreadMessages > 0 ? Colors.black87 : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: chat.numberOfUnreadMessages > 0 ? FontWeight.w500 : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    if (chat.numberOfUnreadMessages > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                        child: Center(
                          child: Text(
                            chat.numberOfUnreadMessages > 99 ? '99+' : chat.numberOfUnreadMessages.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    return name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join('').toUpperCase();
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (messageDate == today) {
      // Today - show time
      final hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
      final period = timestamp.hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour == 0 ? 12 : hour;
      return '$displayHour:${timestamp.minute.toString().padLeft(2, '0')} $period';
    } else {
      // Other days - show date
      return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
    }
  }
}