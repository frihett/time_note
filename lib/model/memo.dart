class Memo {
  int? id;
  DateTime date;
  String content;

  Memo({
    this.id,
    required this.date,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'content': content,
    };
  }

  factory Memo.fromMap(Map<String, dynamic> map) {
    return Memo(
      id: map['id'],
      date: DateTime.parse(map['date']),
      content: map['content'],
    );
  }

  @override
  String toString() {
    return 'Memo{id: $id, date: ${date.toIso8601String()}, content: $content}';
  }
}
