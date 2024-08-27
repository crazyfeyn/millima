import 'package:equatable/equatable.dart';

sealed class RoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRoomsEvent extends RoomEvent {}

class GetAvailableRoomsEvent extends RoomEvent {
  final int dayId;
  final String startTime;
  final String endTime;

  GetAvailableRoomsEvent({
    required this.dayId,
    required this.startTime,
    required this.endTime,
  });
}

class UpdateRoomEvent extends RoomEvent {
  final int roomId;
  final String name;
  final String description;
  final int capacity;

  UpdateRoomEvent({
    required this.roomId,
    required this.name,
    required this.description,
    required this.capacity,
  });
}

class DeleteRoomEvent extends RoomEvent {
  final int roomId;

  DeleteRoomEvent({
    required this.roomId,
  });
}

class AddRoomEvent extends RoomEvent {
  final String name;
  final String description;
  final int capacity;

  AddRoomEvent({
    required this.name,
    required this.description,
    required this.capacity,
  });
}
