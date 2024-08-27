class ClassModel {
  int id;
  String room_name;
  String day_name;
  String start_time;
  String end_time;

  ClassModel({
    required this.id,
    required this.room_name,
    required this.day_name,
    required this.start_time,
    required this.end_time,
  });

  // Factory constructor for creating a ClassModel from a map
  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'],
      room_name: map['room_id'].toString(),
      day_name: map['day_id'].toString(),
      start_time: map['start_time'],
      end_time: map['end_time'],
    );
  }

  // Method to convert ClassModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': room_name,
      'day_id': day_name,
      'start_time': start_time,
      'end_time': end_time,
    };
  }
}