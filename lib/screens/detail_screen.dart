import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meeting.dart';
import '../providers/meeting_provider.dart';
import 'add_edit_screen.dart';

class DetailScreen extends StatelessWidget {

  final Meeting meeting;

  const DetailScreen({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MeetingProvider>(context, listen: false);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Meeting Detail"),

        actions: [

          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditScreen(meeting: meeting),
                ),
              );

            },
          ),

          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {

              showDialog(
                context: context,

                builder: (_) => AlertDialog(
                  title: const Text("Delete Meeting"),
                  content: const Text("Are you sure you want to delete this meeting?"),

                  actions: [

                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    TextButton(
                      child: const Text("Delete"),

                      onPressed: () {

                        provider.deleteMeeting(meeting.id!);

                        Navigator.pop(context);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Meeting deleted"),
                          ),
                        );

                      },
                    ),

                  ],
                ),
              );

            },
          )

        ],
      ),

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