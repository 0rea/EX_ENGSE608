import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meeting_provider.dart';
import '../widgets/meeting_card.dart';
import 'add_edit_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Meetings")),
      body: ListView.builder(
        itemCount: provider.meetings.length,
        itemBuilder: (context, index) {

          final meeting = provider.meetings[index];

          return MeetingCard(meeting: meeting);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditScreen(),
            ),
          );
        },
      ),
    );
  }
}