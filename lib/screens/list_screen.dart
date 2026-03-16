import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meeting_provider.dart';
import '../widgets/meeting_card.dart';
import 'add_edit_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MeetingProvider>(context);

    final meetings = provider.meetings.where((m) {

      return m.title.toLowerCase().contains(searchText.toLowerCase()) ||
          m.responsible.toLowerCase().contains(searchText.toLowerCase());

    }).toList();

    return Scaffold(

      appBar: AppBar(title: const Text("Meetings")),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8),

            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search meeting...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),

              onChanged: (value) {

                setState(() {
                  searchText = value;
                });

              },
            ),
          ),

          Expanded(
            child: ListView.builder(

              itemCount: meetings.length,

              itemBuilder: (context, index) {

                final meeting = meetings[index];

                return MeetingCard(meeting: meeting);

              },
            ),
          ),

        ],
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