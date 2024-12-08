class TimeSetting {
  final int id;
  final String period;
  final int hour;
  final int minute;
  final DateTime date;
  final String? memo;

  TimeSetting({
    required this.id,
    required this.period,
    required this.hour,
    required this.minute,
    required this.date,
    this.memo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'period': period,
      'hour': hour,
      'minute': minute,
      'date': date.toIso8601String(),
      'memo': memo,
    };
  }

  factory TimeSetting.fromMap(Map<String, dynamic> map) {
    return TimeSetting(
      id: map['id'],
      period: map['period'],
      hour: map['hour'],
      minute: map['minute'],
      date: DateTime.parse(map['date']), // 문자열을 DateTime으로 변환
      memo: map['memo'],
    );
  }
}