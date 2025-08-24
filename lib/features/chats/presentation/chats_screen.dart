import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:what_s_up_app/core/extensions/ext.dart';
import 'package:what_s_up_app/core/theme/light_colors.dart';
import 'package:what_s_up_app/core/theme/styles.dart';
import 'package:what_s_up_app/features/chats/presentation/widgts/archived_section.dart';
import 'package:what_s_up_app/features/chats/presentation/widgts/search_bar.dart';


class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int selectedTabIndex = 0;

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Sarah Johnson',
      'message': 'Hey! How are you doing today?',
      'time': 'Tuesday',
      'avatar': 'assets/sarah.jpg',
      'hasCheck': true,
      'unreadCount': 0,
      'isOnline': false,
    },
    {
      'name': 'Mike Chen',
      'message': 'Can you send me the project files?',
      'time': 'Tuesday',
      'avatar': 'assets/mike.jpg',
      'hasCheck': true,
      'unreadCount': 0,
      'isOnline': false,
    },
    {
      'name': 'Emma Wilson',
      'message': 'Thanks for your help yesterday! 😊',
      'time': 'Monday',
      'avatar': 'assets/emma.jpg',
      'hasCheck': true,
      'unreadCount': 0,
      'isOnline': false,
      'hasVoiceNote': true,
    },
    {
      'name': 'Alex Rodriguez',
      'message': 'Are we still meeting at 3 PM?',
      'time': 'Monday',
      'avatar': 'assets/alex.jpg',
      'hasCheck': false,
      'unreadCount': 2,
      'isOnline': true,
    },
    {
      'name': 'Lisa Park',
      'message': 'Great job on the presentation!',
      'time': 'Monday',
      'avatar': 'assets/lisa.jpg',
      'hasCheck': true,
      'unreadCount': 0,
      'isOnline': false,
    },
    {
      'name': 'David Kim',
      'message': 'Let me know when you arrive',
      'time': 'Monday',
      'avatar': 'assets/david.jpg',
      'hasCheck': false,
      'unreadCount': 99,
      'isOnline': true,
    },
    {
      'name': 'Jessica Taylor',
      'message': 'The weather is amazing today! ☀️',
      'time': 'Monday',
      'avatar': 'assets/jessica.jpg',
      'hasCheck': true,
      'unreadCount': 0,
      'isOnline': true,
    },
    {
      'name': 'Ryan Murphy',
      'message': 'Thanks for the update',
      'time': 'Sunday',
      'avatar': 'assets/ryan.jpg',
      'hasCheck': true,
      'unreadCount': 0,
      'isOnline': false,
    },
  ];

 TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text(
          'WhatsApp',
          style: font24w700.copyWith(color: AppLightColors.primary),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.black54),
          ),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_rounded, color: Colors.black54)),
         
        ],
       
      ),
      body: Column(
        children: [
         SearchBarChat(controller:searchController , onClear: () {  }, onChanged: (String value) {  },),
          // Filter Tabs
          Container(
            margin:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                _buildFilterTab('All', 0, isSelected: true),
                10.wSpace,
                _buildFilterTab('Unread', 1, badgeCount: 11),
                10.wSpace,
                _buildFilterTab('Favourite', 2),
                10.wSpace,
                _buildFilterTab('Groups', 3),
              ],
            ),
          ),
          // Archived Section
         ArchivedSection(),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
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
  }

  Widget _buildFilterTab(String text, int index, {bool isSelected = false, int? badgeCount}) {
    return Container(
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
          if (badgeCount != null) ...[
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
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar with online indicator
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey[300],
                child: Text(
                  chat['name'].toString().split(' ').map((e) => e[0]).join(''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              if (chat['isOnline'] == true)
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
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
                      chat['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      chat['time'],
                      style: TextStyle(
                        color: chat['unreadCount'] > 0 ? Colors.green : Colors.grey,
                        fontSize: 12,
                        fontWeight: chat['unreadCount'] > 0 ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 2),
                
                Row(
                  children: [
                    if (chat['hasCheck'] == true)
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color: Colors.blue[400],
                      ),
                    if (chat['hasCheck'] == true) const SizedBox(width: 4),
                    
                    if (chat['hasVoiceNote'] == true) ...[
                      const Icon(
                        Icons.play_arrow,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                    ],
                    
                    Expanded(
                      child: Text(
                        chat['message'],
                        style: TextStyle(
                          color: chat['unreadCount'] > 0 ? Colors.black87 : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: chat['unreadCount'] > 0 ? FontWeight.w500 : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    if (chat['unreadCount'] > 0) ...[
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
                            chat['unreadCount'] > 99 ? '99+' : chat['unreadCount'].toString(),
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
}