class TimeSetting {
  int? id;
  String period;
  int hour;
  int minute;
  DateTime date;
  bool isToggled;

  TimeSetting({
    this.id,
    required this.period,
    required this.hour,
    required this.minute,
    required this.date,
    this.isToggled = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'period': period,
      'hour': hour,
      'minute': minute,
      'date': date.toIso8601String(),
      'isToggled': isToggled ? 1 : 0,
    };
  }

  factory TimeSetting.fromMap(Map<String, dynamic> map) {
    return TimeSetting(
      id: map['id'],
      period: map['period'],
      hour: map['hour'],
      minute: map['minute'],
      date: DateTime.parse(map['date']),
      // 문자열을 DateTime으로 변환
      isToggled: map['isToggled'] == 1,
    );
  }

  @override
  String toString() {
    return 'TimeSetting{id: $id, period: $period, hour: $hour, minute: $minute, date: ${date.toIso8601String()}, isToggled: $isToggled}';
  }

}
