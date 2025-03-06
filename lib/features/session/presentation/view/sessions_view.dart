import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';
import 'package:tutorme/features/session/presentation/bloc/session_bloc.dart';
import 'package:tutorme/features/session/presentation/view/video_call_screen.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  final TextEditingController _searchController = TextEditingController();
  bool _sortNewestFirst = true;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    context.read<SessionBloc>().add(FetchStudentSessions());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SessionEntity> _filterAndSortSessions(List<SessionEntity> sessions) {
    final filtered = sessions.where((session) {
      final searchTerm = _searchController.text.toLowerCase();
      final matchesSearch =
          session.tutorName.toLowerCase().contains(searchTerm);
      final matchesStatus = _selectedStatus == null ||
          session.status.toLowerCase() == _selectedStatus!.toLowerCase();
      return matchesSearch && matchesStatus;
    }).toList();

    filtered.sort((a, b) =>
        _sortNewestFirst ? b.date.compareTo(a.date) : a.date.compareTo(b.date));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Sessions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation!,
        iconTheme: theme.appBarTheme.iconTheme,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: theme.primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  "Today: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSessionFilters(),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _searchController,
                        style: TextStyle(
                            color: theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.blueGrey),
                        decoration: InputDecoration(
                          hintText: "Search by tutor name...",
                          hintStyle: TextStyle(
                              color: theme.brightness == Brightness.dark
                                  ? Colors.grey[400]
                                  : Colors.grey),
                          prefixIcon: Icon(Icons.search,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.grey[400]
                                  : Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: theme.primaryColor, width: 2),
                          ),
                          filled: true,
                          fillColor: theme.brightness == Brightness.dark
                              ? theme.cardColor
                              : Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Sort by:",
                              style: TextStyle(
                                fontSize: 14,
                                color: theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _sortNewestFirst
                                  ? "Newest First"
                                  : "Oldest First",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                            Switch(
                              value: _sortNewestFirst,
                              onChanged: (value) {
                                setState(() {
                                  _sortNewestFirst = value;
                                });
                              },
                              activeColor: theme.primaryColor,
                              activeTrackColor:
                                  theme.primaryColor.withOpacity(0.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: _buildSessionsList(state, theme),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSessionsList(SessionState state, ThemeData theme) {
    if (state is SessionLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state is SessionError) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: TextStyle(color: Colors.red[400], fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else if (state is SessionLoaded) {
      final sessions = _filterAndSortSessions(state.sessions);

      if (sessions.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month_outlined,
                    size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  "No sessions found",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Try adjusting your filters",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final session = sessions[index];
            return _buildSessionCard(session, context);
          },
          childCount: sessions.length,
        ),
      );
    } else if (state is SessionJoining) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Preparing your session...",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    } else if (state is SessionJoined) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JitsiWebViewScreen(roomUrl: state.roomUrl),
          ),
        ).then((_) {
          context.read<SessionBloc>().add(FetchStudentSessions());
        });
      });
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return const SliverFillRemaining(
      child: Center(
        child: Text(
          "No sessions available.",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

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
              _buildFilterChip(
                  "All Sessions", allCount, const Color(0xFF2C3E50), null),
              const SizedBox(width: 8),
              _buildFilterChip("Scheduled", scheduledCount,
                  const Color(0xFF8E44AD), 'scheduled'),
              const SizedBox(width: 8),
              _buildFilterChip("In Progress", inProgressCount,
                  const Color(0xFF27AE60), 'in-progress'),
              const SizedBox(width: 8),
              _buildFilterChip("Completed", completedCount,
                  const Color(0xFF2980B9), 'completed'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
      String label, int count, Color color, String? status) {
    final isSelected = _selectedStatus == status;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = _selectedStatus == status ? null : status;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : theme.brightness == Brightness.dark
                        ? Colors.white
                        : color,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : theme.brightness == Brightness.dark
                          ? Colors.white
                          : color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard(SessionEntity session, BuildContext context) {
    final theme = Theme.of(context);

    Color statusColor;
    IconData statusIcon;

    switch (session.status) {
      case 'scheduled':
        statusColor = const Color(0xFF8E44AD);
        statusIcon = Icons.calendar_month;
        break;
      case 'in-progress':
        statusColor = const Color(0xFF27AE60);
        statusIcon = Icons.play_circle;
        break;
      case 'completed':
        statusColor = const Color(0xFF2980B9);
        statusIcon = Icons.check_circle;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.info;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? theme.cardColor
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: statusColor.withOpacity(0.1),
                  child: Icon(statusIcon, color: statusColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.tutorName,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              session.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark
                              ? Colors.grey.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.calendar_today,
                            size: 16, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${session.date.day}/${session.date.month}/${session.date.year}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark
                              ? Colors.grey.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.access_time,
                            size: 16, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        session.startTime?.split(' ')[4] ?? "N/A",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: _buildCardActions(session, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildCardActions(SessionEntity session, ThemeData theme) {
    if (session.status == 'scheduled' || session.status == 'in-progress') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            context
                .read<SessionBloc>()
                .add(JoinSession(session.bookingId ?? ""));
          },
          icon: const Icon(Icons.video_call_rounded,
              color: Colors.white, size: 20),
          label: const Text(
            "Join Session",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Montserrat Bold',
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
    } else if (session.status == 'completed') {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {
            _showSessionDetailsDialog(session, context);
          },
          icon: Icon(Icons.info_outline, color: theme.primaryColor, size: 20),
          label: Text(
            "View Details",
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 16,
              fontFamily: 'Montserrat Regular',
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.primaryColor),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void _showSessionDetailsDialog(SessionEntity session, BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Session Details",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                session.tutorName,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              subtitle: Text(
                "Tutor",
                style: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ),
            const Divider(),
            _buildDetailRow(
              Icons.timer,
              "Duration",
              "${(session.duration * 60).toInt()} minutes",
              theme,
            ),
            _buildDetailRow(
              Icons.money,
              "Total Fee",
              "Rs.${session.totalFee.toStringAsFixed(2)}",
              theme,
            ),
            _buildDetailRow(
              Icons.account_balance,
              "Platform Fee",
              "Rs.${session.platformFee.toStringAsFixed(2)}",
              theme,
            ),
            _buildDetailRow(
              Icons.payments,
              "Tutor Earnings",
              "Rs.${session.tutorEarnings.toStringAsFixed(2)}",
              theme,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Close",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: theme.primaryColor),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
