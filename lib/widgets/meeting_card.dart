import 'package:flutter/material.dart';
import '../models/meeting.dart';
import '../screens/detail_screen.dart';

class MeetingCard extends StatelessWidget {

  final Meeting meeting;

  const MeetingCard({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(meeting.title),
        subtitle: Text(meeting.status),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(meeting: meeting),
            ),
          );
        },
      ),
    );
  }
}