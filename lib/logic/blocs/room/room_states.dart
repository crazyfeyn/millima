import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/room_model.dart';

sealed class RoomState extends Equatable {
  @override
  List<Object> get props => [];
}

class RoomInitialState extends RoomState {}

class RoomLoadingState extends RoomState {}

class RoomLoadedState extends RoomState {
  final List<RoomModel> rooms;

  RoomLoadedState({required this.rooms});
}

class RoomErrorState extends RoomState {
  final String error;
  RoomErrorState({required this.error});
}
