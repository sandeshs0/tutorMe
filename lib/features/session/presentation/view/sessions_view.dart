import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';
import 'package:tutorme/features/session/presentation/bloc/session_bloc.dart';
import 'package:tutorme/features/session/presentation/view/video_call_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  final TextEditingController _searchController = TextEditingController();
  bool _sortNewestFirst = true;
  String? _selectedStatus;
  // final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    context.read<SessionBloc>().add(FetchStudentSessions());
    // _configureWebViewController();
  }

  // void _configureWebViewController() {
  //   _webViewController
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onPageStarted: (String url) {
  //           debugPrint('Page started loading: $url');
  //         },
  //         onPageFinished: (String url) {
  //           debugPrint('Page finished loading: $url');
  //         },
  //         onWebResourceError: (WebResourceError error) {
  //           debugPrint('WebView error: ${error.description}');
  //         },
  //       ),
  //     );
  // }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SessionEntity> _filterAndSortSessions(List<SessionEntity> sessions) {
    // Filter by tutor name (case-insensitive) and selected status
    final filtered = sessions.where((session) {
      final searchTerm = _searchController.text.toLowerCase();
      final matchesSearch =
          session.tutorName.toLowerCase().contains(searchTerm);
      final matchesStatus = _selectedStatus == null ||
          session.status.toLowerCase() == _selectedStatus!.toLowerCase();
      return matchesSearch && matchesStatus;
    }).toList();

    // Sort by date (newest first if _sortNewestFirst, otherwise oldest first)
    filtered.sort((a, b) =>
        _sortNewestFirst ? b.date.compareTo(a.date) : a.date.compareTo(b.date));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Sessions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation!,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "View and manage your scheduled learning sessions",
            //   style: TextStyle(
            //       fontSize: 16,
            //       color: Theme.of(context).textTheme.bodyMedium?.color),
            // ),
            // const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            // const SizedBox(height: 16),
            _buildSessionFilters(),
            // const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.blueGrey),
              decoration: InputDecoration(
                hintText: "Search by tutor name...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            // const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Newest First",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
                Switch(
                  value: _sortNewestFirst,
                  onChanged: (value) {
                    setState(() {
                      _sortNewestFirst = value;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            // const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SessionBloc, SessionState>(
                builder: (context, state) {
                  if (state is SessionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SessionError) {
                    return Center(
                        child: Text(state.message,
                            style: const TextStyle(color: Colors.red)));
                  } else if (state is SessionLoaded) {
                    final sessions = _filterAndSortSessions(state.sessions);
                    if (sessions.isEmpty) {
                      return const Center(
                          child: Text("No sessions found.",
                              style: TextStyle(color: Colors.grey)));
                    }
                    return ListView.builder(
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        return _buildSessionCard(session, context);
                      },
                    );
                  } else if (state is SessionJoining) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SessionJoined) {
                    // return const Center(
                    //   child: Text("Joining video Session...", style: TextStyle(color: Colors.blueGrey),),
                    // );
                    // return _buildJitsiWebView(state.roomUrl);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JitsiWebViewScreen(roomUrl: state.roomUrl),
                        ),
                      ).then((_) {
                        // When the Jitsi screen is popped, refresh sessions
                        context.read<SessionBloc>().add(FetchStudentSessions());
                      });
                    });
                    return const SizedBox.shrink();
                  }
                  return const Center(
                      child: Text("No sessions available.",
                          style: TextStyle(color: Colors.grey)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildJitsiWebView(String roomUrl) {
  //   return WebViewWidget(
  //     controller: _webViewController..loadRequest(Uri.parse(roomUrl)),
  //   );
  // }

  Widget _buildSessionFilters() {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        int allCount = 0,
            scheduledCount = 0,
            inProgressCount = 0,
            completedCount = 0;
        if (state is SessionLoaded) {
          allCount = state.sessions.length;
          scheduledCount = state.sessions
              .where((session) => session.status == 'scheduled')
              .length;
          inProgressCount = state.sessions
              .where((session) => session.status == 'in-progress')
              .length;
          completedCount = state.sessions
              .where((session) => session.status == 'completed')
              .length;
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8), // Padding at the start
              _buildFilterChip("All Sessions", allCount,
                  const Color.fromARGB(255, 17, 5, 5), null),
              const SizedBox(width: 8),
              _buildFilterChip("Scheduled", scheduledCount,
                  const Color.fromARGB(255, 85, 0, 142), 'scheduled'),
              const SizedBox(width: 8),
              _buildFilterChip("In Progress", inProgressCount,
                  const Color.fromARGB(255, 6, 138, 10), 'in-progress'),
              const SizedBox(width: 8),
              _buildFilterChip("Completed", completedCount,
                  const Color.fromARGB(255, 0, 80, 126), 'completed'),
              const SizedBox(width: 8), // Padding at the end
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
      String label, int count, Color color, String? status) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status; // Set or clear filter
        });
      },
      child: Chip(
        label: Text("$label $count",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            )),
        // color: _selectedStatus == status
        //     ? Colors.white
        //     : Theme.of(context).textTheme.bodyMedium?.color)),
        backgroundColor: _selectedStatus == status ? color : color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color)),
      ),
    );
  }

  Widget _buildSessionCard(SessionEntity session, BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Session with ",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  TextSpan(
                    text: session.tutorName,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "${session.date.day}/${session.date.month}/${session.date.year}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  session.startTime?.split(' ')[4] ?? "N/A",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              session.status.toUpperCase(),
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor.withOpacity(1)),
            ),
            const SizedBox(height: 8),
            // Text(
            //   "Tracking id: ${session.sessionId}",
            //   style: TextStyle(
            //       fontSize: 14,
            //       color: Theme.of(context).textTheme.bodyMedium?.color),
            // ),
            if (session.status == 'scheduled' ||
                session.status == 'in-progress')
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // _joinSession(session.roomId ?? '');
                    context
                        .read<SessionBloc>()
                        .add(JoinSession(session.bookingId ?? ""));
                  },
                  icon: const Icon(Icons.video_call_rounded,
                      color: Colors.white, size: 20),
                  label: const Text("Join Session",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat Bold')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
            if (session.status == 'completed')
              Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showSessionDetailsDialog(session, context);
                  },
                  icon: Icon(Icons.info_outline,
                      color: theme.primaryColor, size: 20),
                  label: Text("View Details",
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 16,
                          fontFamily: 'Montserrat Regular')),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

// Widget _buildJitsiMeeting(SessionJoined state) {
//   return JitsiMeet(
//     room: state.roomId,
//     onWebOptions: (options) {
//       options["roomName"] = state.roomId.split('/').last; // Extract room name
//       options["jwt"] = state.jwtToken;
//       options["userInfo"] = {"displayName": "Student"}; // Use actual user name
//       options["configOverwrite"] = {
//         "startWithAudioMuted": false,
//         "startWithVideoMuted": false,
//         "prejoinPageEnabled": false,
//         "requireDisplayName": false,
//       };
//       options["interfaceConfigOverwrite"] = {
//         "DISABLE_JOIN_LEAVE_NOTIFICATIONS": true,
//         "MOBILE_APP_PROMO": false,
//         "TOOLBAR_BUTTONS": [
//           "microphone",
//           "camera",
//           "desktop",
//           "fullscreen",
//           "hangup",
//           "chat",
//         ],
//       };
//     },
//     onClosed: () {
//       context.read<SessionBloc>().add(FetchStudentSessions());
//     },
//   );
// }

  void _joinSession(String roomId) async {
    final Uri url = Uri.parse(roomId);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("❌ Could not launch session URL: $roomId");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to join session.")),
      );
    }
  }

  void _showSessionDetailsDialog(SessionEntity session, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Session Details with ${session.tutorName}",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              // color: Theme.of(context).textTheme.bodyMedium?.color
            )),
        content: Container(
          padding: const EdgeInsets.all(16),
          // color: Theme.of(context).cardColor, // Solid background
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Duration: ${(session.duration * 60).toInt()} minutes",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color)),
              const SizedBox(height: 8),
              Text("Total Fee: Rs.${session.totalFee.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color)),
              const SizedBox(height: 8),
              Text("Platform Fee: Rs.${session.platformFee.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color)),
              const SizedBox(height: 8),
              Text(
                  "Tutor Earnings: Rs.${session.tutorEarnings.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close",
                style: TextStyle(color: Colors.redAccent, fontSize: 16)),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
