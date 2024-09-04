import 'package:flutter_application/data/models/week_days.dart';

class Timetable {
  Map<String, List<WeekDays>> weekDays;

  Timetable({required this.weekDays});

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      weekDays: map.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((e) => WeekDays.fromMap(e)).toList(),
        ),
      ),
    );
  }
}