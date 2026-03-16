class Meeting {
  int? id;
  String title;
  String date;
  String responsible;
  String status;
  String summary;
  String note;

  Meeting({
    this.id,
    required this.title,
    required this.date,
    required this.responsible,
    required this.status,
    required this.summary,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'responsible': responsible,
      'status': status,
      'summary': summary,
      'note': note,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      responsible: map['responsible'],
      status: map['status'],
      summary: map['summary'],
      note: map['note'],
    );
  }
}