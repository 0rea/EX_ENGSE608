import 'package:flutter/material.dart';
import '../models/meeting.dart';

class DetailScreen extends StatelessWidget {

  final Meeting meeting;

  const DetailScreen({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Meeting Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Title: ${meeting.title}"),
            Text("Responsible: ${meeting.responsible}"),
            Text("Status: ${meeting.status}"),
            Text("Summary: ${meeting.summary}"),
            Text("Note: ${meeting.note}"),

          ],
        ),
      ),
    );
  }
}