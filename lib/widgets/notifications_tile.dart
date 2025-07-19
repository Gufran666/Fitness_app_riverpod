import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/notifications.dart';
import 'package:fitness_app_riverpod/providers/notification_provider.dart';
import 'package:intl/intl.dart';

class NotificationTile extends ConsumerWidget {
  final AppNotification notification;
  final VoidCallback onMarkAsRead;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: notification.isRead ? null : Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Icon(
        _getIconForType(notification.type),
        color: _getColorForType(notification.type),
      ),
      title: Text(notification.title),
      subtitle: Text(notification.message),
      trailing: Text(
        DateFormat('HH:mm').format(notification.timestamp),
        style: TextStyle(
          color: notification.isRead ? Colors.grey : Theme.of(context).primaryColor,
        ),
      ),
      onTap: onMarkAsRead,
    );
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.workoutReminder:
        return Icons.alarm;
      case NotificationType.achievementUnlocked:
        return Icons.celebration;
      case NotificationType.socialActivity:
        return Icons.social_distance_rounded;
      case NotificationType.recommendation:
        return Icons.recommend;
    }
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.workoutReminder:
        return Colors.orange;
      case NotificationType.achievementUnlocked:
        return Colors.green;
      case NotificationType.socialActivity:
        return Colors.blue;
      case NotificationType.recommendation:
        return Colors.purple;
    }
  }
}