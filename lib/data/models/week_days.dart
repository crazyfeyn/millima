class WeekDays {
  String room;
  String startTime;
  String endTime;

  WeekDays({
    required this.room,
    required this.startTime,
    required this.endTime,
  });

  factory WeekDays.fromMap(Map<String, dynamic> map) {
    return WeekDays(
      room: map['room'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }
}