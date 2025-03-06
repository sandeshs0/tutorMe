// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';
// import 'package:tutorme/features/notifications/presentation/view_model/notification_bloc.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   late List<NotificationEntity> notifications;
//   AccelerometerEvent? _accelerometerEvent;
//   final _streamSubscriptions = <StreamSubscription<dynamic>>[];
//   static const double shakeThreshold = 15.0; // Adjust shake sensitivity
//   bool hasShaken = false; // To prevent multiple triggers

//   @override
//   void initState() {
//     super.initState();
//     context.read<NotificationBloc>().add(FetchNotificationsEvent());
//     notifications = []; // Initialize empty list
//     // ✅ Listen for accelerometer events
//     _streamSubscriptions.add(
//       accelerometerEventStream().listen(
//         (AccelerometerEvent event) {
//           setState(() {
//             _accelerometerEvent = event;
//           });

//           // Calculate the total acceleration
//           double acceleration =
//               sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

//           // If acceleration exceeds threshold, trigger mark as read
//           if (acceleration > shakeThreshold && !hasShaken) {
//             hasShaken = true;
//             _markAllAsRead();
//             Future.delayed(const Duration(seconds: 1), () => hasShaken = false);
//           }
//         },
//         onError: (e) {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return const AlertDialog(
//                   title: Text("Sensor Not Found"),
//                   content: Text(
//                       "It seems that your device doesn't support the Accelerometer Sensor."),
//                 );
//               });
//         },
//         cancelOnError: true,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // ✅ Removes back button
//         title: const Text("Notifications"),
//       ),
//       body: Column(
//         children: [
//           // ✅ "Mark All as Read" - Smaller & Subtle
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: TextButton.icon(
//                 onPressed: () {
//                   context
//                       .read<NotificationBloc>()
//                       .add(MarkNotificationsAsReadEvent());
//                   _markAllAsRead();
//                 },
//                 icon: const Icon(Icons.done_all, size: 18, color: Colors.blue),
//                 label: const Text(
//                   "Mark All as Read",
//                   style: TextStyle(
//                       color: Colors.blue, fontWeight: FontWeight.w500),
//                 ),
//                 style: TextButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 ),
//               ),
//             ),
//           ),

//           // ✅ Notifications List
//           Expanded(
//             child: BlocListener<NotificationBloc, NotificationState>(
//               listener: (context, state) {
//                 if (state is NotificationsMarkedAsRead) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text("All notifications marked as read!")),
//                   );
//                 } else if (state is NotificationError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text(state.message,
//                             style: const TextStyle(color: Colors.white))),
//                   );
//                 } else if (state is NotificationLoaded) {
//                   setState(() {
//                     notifications = state
//                         .notifications; // ✅ Update UI when new notifications arrive
//                   });
//                 }
//               },
//               child: BlocBuilder<NotificationBloc, NotificationState>(
//                 builder: (context, state) {
//                   if (state is NotificationLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is NotificationLoaded) {
//                     notifications = state.notifications;
//                     return _buildNotificationList(notifications);
//                   } else if (state is NotificationError) {
//                     return Center(
//                         child: Text(state.message,
//                             style: const TextStyle(color: Colors.red)));
//                   }
//                   return const Center(child: Text("No notifications found."));
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// **✅ Improved Notification UI with Modern Card Design**
//   Widget _buildNotificationList(List<NotificationEntity> notifications) {
//     final theme = Theme.of(context);
//     return ListView.builder(
//       itemCount: notifications.length,
//       padding: const EdgeInsets.all(10),
//       itemBuilder: (context, index) {
//         final notification = notifications[index];
//         final isUnread = !notification.isRead;

//         return Card(
//           elevation: 3, // Adds shadow effect
//           margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//           color: isUnread
//               ? Colors.blue[50]
//               : theme.cardColor, // Highlight unread notifications
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: ListTile(
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             leading: CircleAvatar(
//               backgroundColor: isUnread ? theme.primaryColor : Colors.grey[400],
//               child: Icon(
//                 isUnread
//                     ? Icons.notifications_active
//                     : Icons.notifications_none,
//                 color: theme.indicatorColor,
//               ),
//             ),
//             title: Text(
//               notification.message,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
//                 color: isUnread ? Colors.black : Colors.grey[700],
//               ),
//             ),
//             subtitle: Text(
//               _formatDate(notification.createdAt),
//               style: TextStyle(color: Colors.grey[600], fontSize: 14),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// **Helper Method to Format Date**
//   String _formatDate(DateTime dateTime) {
//     return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
//   }

//   /// **Marks all notifications as read in the UI**
//   // void _markAllAsRead() {
//   //   setState(() {
//   //     notifications =
//   //         notifications.map((n) => n.copyWith(isRead: true)).toList();
//   //   });
//   // }

//   void _markAllAsRead() {
//     context.read<NotificationBloc>().add(MarkNotificationsAsReadEvent());
//   }
// }

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

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late List<NotificationEntity> notifications;
  AccelerometerEvent? _accelerometerEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  static const double shakeThreshold = 15.0; // Adjust shake sensitivity
  bool hasShaken = false; // To prevent multiple triggers
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(FetchNotificationsEvent());
    notifications = []; // Initialize empty list

    // Animation for shake effect feedback
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Listen for accelerometer events
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
            _animationController
                .forward()
                .then((_) => _animationController.reverse());
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
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Notifications"),
      ),
      body: Column(
        children: [
          // Notification counter and Mark all as read button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                    int unreadCount = 0;
                    if (state is NotificationLoaded) {
                      unreadCount =
                          state.notifications.where((n) => !n.isRead).length;
                    }
                    return RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black87,
                          fontFamily: 'Montserrat Regular',
                        ),
                        children: [
                          const TextSpan(text: ''),
                          TextSpan(
                            text: 'Unread: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                          TextSpan(text: '$unreadCount'),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value * 0.05 * (hasShaken ? -1 : 1),
                      child: child,
                    );
                  },
                  child: ElevatedButton.icon(
                    onPressed: _markAllAsRead,
                    icon: const Icon(Icons.done_all,
                        color: Colors.white, size: 16),
                    label: const Text("Mark All Read"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat Bold',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(color: theme.dividerColor, thickness: 1),

          // Notifications List
          Expanded(
            child: BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is NotificationsMarkedAsRead) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("All notifications marked as read!"),
                      backgroundColor: theme.primaryColor,
                    
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else if (state is NotificationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else if (state is NotificationLoaded) {
                  setState(() {
                    notifications = state.notifications;
                  });
                }
              },
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: theme.primaryColor),
                          const SizedBox(height: 16),
                          Text(
                            "Loading notifications...",
                            style: TextStyle(
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black54,
                              fontFamily: 'Montserrat Regular',
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is NotificationLoaded) {
                    notifications = state.notifications;
                    return notifications.isEmpty
                        ? _buildEmptyState(theme, isDarkMode)
                        : _buildNotificationList(
                            notifications, theme, isDarkMode);
                  } else if (state is NotificationError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              size: 48, color: Colors.red[300]),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: TextStyle(color: Colors.red[300]),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<NotificationBloc>()
                                  .add(FetchNotificationsEvent());
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text("Try Again"),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return _buildEmptyState(theme, isDarkMode);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: isDarkMode ? Colors.white38 : Colors.black26,
          ),
          const SizedBox(height: 24),
          Text(
            "No notifications yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white70 : Colors.black54,
              fontFamily: 'Montserrat Bold',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "We'll notify you when something new arrives",
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white54 : Colors.black45,
              fontFamily: 'Montserrat Regular',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationEntity> notifications,
      ThemeData theme, bool isDarkMode) {
    return ListView.builder(
      itemCount: notifications.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        final isUnread = !notification.isRead;
        final now = DateTime.now();
        final difference = now.difference(notification.createdAt);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Material(
            elevation: isUnread ? 4 : 2,
            borderRadius: BorderRadius.circular(16),
            color: isUnread
                ? (isDarkMode
                    ? theme.primaryColor.withOpacity(0.15)
                    : theme.primaryColor.withOpacity(0.08))
                : theme.cardColor,
            child: InkWell(
              onTap: () {
                // Mark individual notification as read - future implementation
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: isUnread
                      ? Border.all(
                          color: theme.primaryColor.withOpacity(0.3),
                          width: 1.5)
                      : null,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notification icon with status indicator
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isUnread
                                ? theme.primaryColor.withOpacity(0.2)
                                : isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isUnread
                                ? Icons.notifications_active
                                : Icons.notifications_none,
                            color: isUnread ? theme.primaryColor : Colors.grey,
                            size: 22,
                          ),
                        ),
                        if (isUnread)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      isDarkMode ? Colors.black : Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // Notification content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.message,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  isUnread ? FontWeight.w600 : FontWeight.w400,
                              color: isUnread
                                  ? (isDarkMode ? Colors.white : Colors.black87)
                                  : (isDarkMode
                                      ? Colors.white70
                                      : Colors.black54),
                              fontFamily: isUnread
                                  ? 'Montserrat Bold'
                                  : 'Montserrat Regular',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: isDarkMode
                                    ? Colors.white54
                                    : Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _getTimeAgo(difference),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDarkMode
                                      ? Colors.white54
                                      : Colors.grey[600],
                                  fontFamily: 'Montserrat Regular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getTimeAgo(Duration difference) {
    if (difference.inDays > 0) {
      return difference.inDays == 1
          ? 'Yesterday'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  void _markAllAsRead() {
    context.read<NotificationBloc>().add(MarkNotificationsAsReadEvent());
  }
}
