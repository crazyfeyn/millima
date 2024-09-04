import 'package:equatable/equatable.dart';

sealed class TimeTableEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTimeTablesEvent extends TimeTableEvent {
  final int groupId;
  GetTimeTablesEvent({required this.groupId});
}

class CreateTimeTableEvent extends TimeTableEvent {
  final int groupId;
  final int roomId;
  final int dayId;
  final String startTime;
  final String endTime;

  CreateTimeTableEvent({
    required this.groupId,
    required this.roomId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
  });
}