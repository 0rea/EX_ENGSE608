import 'package:flutter/material.dart';
import '../models/meeting.dart';
import '../services/database_helper.dart';

class MeetingProvider extends ChangeNotifier {
  List<Meeting> meetings = [];

  Future loadMeetings() async {
    final data = await DatabaseHelper.instance.getAll();
    meetings = data.map((e) => Meeting.fromMap(e)).toList();
    notifyListeners();
  }

  Future addMeeting(Meeting meeting) async {
    await DatabaseHelper.instance.insert(meeting.toMap());
    await loadMeetings();
  }

  Future updateMeeting(Meeting meeting) async {
    await DatabaseHelper.instance.update(meeting.id!, meeting.toMap());
    await loadMeetings();
  }

  Future deleteMeeting(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadMeetings();
  }

  int get total => meetings.length;

  int get pending =>
      meetings.where((m) => m.status == "Pending").length;

  int get done =>
      meetings.where((m) => m.status == "Done").length;
}