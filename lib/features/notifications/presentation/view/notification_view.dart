import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';
import 'package:tutorme/features/notifications/presentation/view_model/notification_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<NotificationEntity> notifications;
  AccelerometerEvent? _accelerometerEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  static const double shakeThreshold = 15.0; // Adjust shake sensitivity
  bool hasShaken = false; // To prevent multiple triggers

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(FetchNotificationsEvent());
    notifications = []; // Initialize empty list
    // ✅ Listen for accelerometer events
    _streamSubscriptions.add(
      accelerometerEventStream().listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerEvent = event;
          });

          // Calculate the total acceleration
          double acceleration =
              sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

          // If acceleration exceeds threshold, trigger mark as read
          if (acceleration > shakeThreshold && !hasShaken) {
            hasShaken = true;
            _markAllAsRead();
            Future.delayed(const Duration(seconds: 1), () => hasShaken = false);
          }
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support the Accelerometer Sensor."),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ✅ Removes back button
        title: const Text("Notifications"),
      ),
      body: Column(
        children: [
          // ✅ "Mark All as Read" - Smaller & Subtle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  context
                      .read<NotificationBloc>()
                      .add(MarkNotificationsAsReadEvent());
                  _markAllAsRead();
                },
                icon: const Icon(Icons.done_all, size: 18, color: Colors.blue),
                label: const Text(
                  "Mark All as Read",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                ),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                ),
              ),
            ),
          ),

          // ✅ Notifications List
          Expanded(
            child: BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is NotificationsMarkedAsRead) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("All notifications marked as read!")),
                  );
                } else if (state is NotificationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.message,
                            style: const TextStyle(color: Colors.white))),
                  );
                } else if (state is NotificationLoaded) {
                  setState(() {
                    notifications = state
                        .notifications; // ✅ Update UI when new notifications arrive
                  });
                }
              },
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotificationLoaded) {
                    notifications = state.notifications;
                    return _buildNotificationList(notifications);
                  } else if (state is NotificationError) {
                    return Center(
                        child: Text(state.message,
                            style: const TextStyle(color: Colors.red)));
                  }
                  return const Center(child: Text("No notifications found."));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// **✅ Improved Notification UI with Modern Card Design**
  Widget _buildNotificationList(List<NotificationEntity> notifications) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: notifications.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        final isUnread = !notification.isRead;

        return Card(
          elevation: 3, // Adds shadow effect
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          color: isUnread
              ? Colors.blue[50]
              : theme.cardColor, // Highlight unread notifications
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: CircleAvatar(
              backgroundColor: isUnread ? theme.primaryColor : Colors.grey[400],
              child: Icon(
                isUnread
                    ? Icons.notifications_active
                    : Icons.notifications_none,
                color: theme.indicatorColor,
              ),
            ),
            title: Text(
              notification.message,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                color: isUnread ? Colors.black : Colors.grey[700],
              ),
            ),
            subtitle: Text(
              _formatDate(notification.createdAt),
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
        );
      },
    );
  }

  /// **Helper Method to Format Date**
  String _formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  /// **Marks all notifications as read in the UI**
  // void _markAllAsRead() {
  //   setState(() {
  //     notifications =
  //         notifications.map((n) => n.copyWith(isRead: true)).toList();
  //   });
  // }

  void _markAllAsRead() {
    context.read<NotificationBloc>().add(MarkNotificationsAsReadEvent());
  }
}
