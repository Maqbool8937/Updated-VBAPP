import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark.value;
      final bgColor = Theme.of(context).scaffoldBackgroundColor;
      final cardColor = Theme.of(context).cardColor;
      final textColor = Theme.of(context).textTheme.bodyLarge!.color;

      // Sample messages data
      final messages = [
        {
          'id': '1',
          'title': 'New Case Assignment',
          'body': 'You have been assigned a new case in Downtown area.',
          'time': DateTime.now().subtract(const Duration(hours: 2)),
          'read': false,
          'type': 'assignment',
        },
        {
          'id': '2',
          'title': 'Case Update',
          'body': 'Case #12345 has been updated with new information.',
          'time': DateTime.now().subtract(const Duration(days: 1)),
          'read': false,
          'type': 'update',
        },
        {
          'id': '3',
          'title': 'System Notification',
          'body': 'Your report has been submitted successfully.',
          'time': DateTime.now().subtract(const Duration(days: 2)),
          'read': true,
          'type': 'system',
        },
        {
          'id': '4',
          'title': 'Reminder',
          'body': 'Don\'t forget to complete the case report for Case #12340.',
          'time': DateTime.now().subtract(const Duration(days: 3)),
          'read': true,
          'type': 'reminder',
        },
      ];

      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('Messages'),
          backgroundColor: isDark ? Colors.grey.shade900 : const Color(0xff140D44),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.mark_email_read),
              tooltip: 'Mark all as read',
              onPressed: () {
                Get.snackbar(
                  'Success',
                  'All messages marked as read',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
            ),
          ],
        ),
        body: messages.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No messages',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUnread = !(message['read'] as bool);
                  final messageTime = message['time'] as DateTime;

                  return Card(
                    color: cardColor,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getColorForType(
                          message['type'] as String,
                          isDark,
                        ),
                        child: Icon(
                          _getIconForType(message['type'] as String),
                          color: Colors.white,
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              message['title'] as String,
                              style: TextStyle(
                                fontWeight: isUnread
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: textColor,
                              ),
                            ),
                          ),
                          if (isUnread == true)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            message['body'] as String,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatTime(messageTime),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Get.snackbar(
                          message['title'] as String,
                          message['body'] as String,
                          backgroundColor: Colors.blue,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                        );
                      },
                    ),
                  );
                },
              ),
      );
    });
  }

  Color _getColorForType(String type, bool isDark) {
    switch (type) {
      case 'assignment':
        return Colors.blue;
      case 'update':
        return Colors.orange;
      case 'system':
        return Colors.green;
      case 'reminder':
        return Colors.purple;
      default:
        return isDark ? Colors.grey.shade700 : Colors.grey;
    }
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'assignment':
        return Icons.assignment;
      case 'update':
        return Icons.update;
      case 'system':
        return Icons.notifications;
      case 'reminder':
        return Icons.alarm;
      default:
        return Icons.message;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(time);
    }
  }
}
