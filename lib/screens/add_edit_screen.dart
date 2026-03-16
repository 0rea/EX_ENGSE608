import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meeting.dart';
import '../providers/meeting_provider.dart';

class AddEditScreen extends StatefulWidget {

  final Meeting? meeting;

  const AddEditScreen({super.key, this.meeting});

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
  void initState() {
    super.initState();

    if (widget.meeting != null) {
      titleController.text = widget.meeting!.title;
      responsibleController.text = widget.meeting!.responsible;
      summaryController.text = widget.meeting!.summary;
      noteController.text = widget.meeting!.note;
      status = widget.meeting!.status;
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meeting == null ? "Add Meeting" : "Edit Meeting"),
      ),

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
                    v == null || v.isEmpty ? "Please enter title" : null,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: responsibleController,
                decoration:
                    const InputDecoration(labelText: "Responsible"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Please enter responsible person" : null,
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField(
                value: status,
                decoration: const InputDecoration(labelText: "Status"),
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

              const SizedBox(height: 10),

              TextFormField(
                controller: summaryController,
                decoration:
                    const InputDecoration(labelText: "Summary"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Please enter summary" : null,
              ),

              const SizedBox(height: 10),

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

                    if (widget.meeting == null) {

                      final meeting = Meeting(
                        title: titleController.text,
                        date: DateTime.now().toString(),
                        responsible: responsibleController.text,
                        status: status,
                        summary: summaryController.text,
                        note: noteController.text,
                      );

                      provider.addMeeting(meeting);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Meeting added"),
                        ),
                      );

                    } else {

                      final meeting = Meeting(
                        id: widget.meeting!.id,
                        title: titleController.text,
                        date: widget.meeting!.date,
                        responsible: responsibleController.text,
                        status: status,
                        summary: summaryController.text,
                        note: noteController.text,
                      );

                      provider.updateMeeting(meeting);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Meeting updated"),
                        ),
                      );

                    }

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