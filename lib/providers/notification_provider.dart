import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/notifications.dart';

// Sample notifications
final List<AppNotification> sampleNotifications = [
  AppNotification(
    id: '1',
    title: 'Workout Reminder',
    message: 'Don\'t forget your scheduled workout today!',
    type: NotificationType.workoutReminder,
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    isRead: false,
  ),
  AppNotification(
    id: '2',
    title: 'Achievement Unlocked',
    message: 'You completed 10 workouts! Keep it up!',
    type: NotificationType.achievementUnlocked,
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    isRead: true,
  ),
  AppNotification(
    id: '3',
    title: 'New Follower',
    message: 'John Doe started following you!',
    type: NotificationType.socialActivity,
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    isRead: false,
  ),
];

class NotificationNotifier extends StateNotifier<List<AppNotification>> {
  NotificationNotifier() : super(sampleNotifications);

  void addNotification(AppNotification notification) {
    state = [notification, ...state];
  }

  void markAsRead(String id) {
    state = state.map((notification) {
      if (notification.id == id) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
  }

  void markAllAsRead() {
    state = state.map((notification) => notification.copyWith(isRead: true)).toList();
  }

  List<AppNotification> getUnreadNotifications() {
    return state.where((notification) => !notification.isRead).toList();
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<AppNotification>>((ref) {
  return NotificationNotifier();
});