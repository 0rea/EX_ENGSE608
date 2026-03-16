import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meeting.dart';
import '../providers/meeting_provider.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final responsibleController = TextEditingController();
  final summaryController = TextEditingController();
  final noteController = TextEditingController();

  String status = "Pending";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Meeting")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (v) =>
                    v!.isEmpty ? "Enter title" : null,
              ),

              TextFormField(
                controller: responsibleController,
                decoration:
                    const InputDecoration(labelText: "Responsible"),
              ),

              DropdownButtonFormField(
                value: status,
                items: ["Pending", "Done"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    status = v!;
                  });
                },
              ),

              TextFormField(
                controller: summaryController,
                decoration:
                    const InputDecoration(labelText: "Summary"),
              ),

              TextFormField(
                controller: noteController,
                decoration:
                    const InputDecoration(labelText: "Note"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {

                  if (_formKey.currentState!.validate()) {

                    final meeting = Meeting(
                      title: titleController.text,
                      date: DateTime.now().toString(),
                      responsible: responsibleController.text,
                      status: status,
                      summary: summaryController.text,
                      note: noteController.text,
                    );

                    provider.addMeeting(meeting);

                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}