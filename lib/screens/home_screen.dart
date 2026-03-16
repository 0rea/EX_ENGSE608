import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meeting_provider.dart';
import 'list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Total Meetings: ${provider.total}",
                style: const TextStyle(fontSize: 20)),

            Text("Pending: ${provider.pending}",
                style: const TextStyle(fontSize: 20)),

            Text("Completed: ${provider.done}",
                style: const TextStyle(fontSize: 20)),

            const SizedBox(height: 30),

            ElevatedButton(
              child: const Text("View Meetings"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}