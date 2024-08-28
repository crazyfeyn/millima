import 'package:flutter_application/data/models/room_model.dart';
import 'package:flutter_application/logic/blocs/room/room_events.dart';
import 'package:flutter_application/logic/blocs/room/room_states.dart';
import 'package:flutter_application/data/services/room_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitialState()) {
    on<GetRoomsEvent>(_onGetRooms);
    on<GetAvailableRoomsEvent>(_onGetAvailableRooms);
    on<AddRoomEvent>(_addRoom);
    on<UpdateRoomEvent>(_updateRoom);
    on<DeleteRoomEvent>(_deleteRoom);
  }

  final RoomService roomService = RoomService();

  Future<void> _onGetRooms(GetRoomsEvent event, emit) async {
    emit(RoomLoadingState());
    try {
      final response = await roomService.getRooms();
      List<RoomModel> rooms = [];

      response['data'].forEach((value) {
        rooms.add(RoomModel.fromMap(value));
      });

      emit(RoomLoadedState(rooms: rooms));
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _onGetAvailableRooms(GetAvailableRoomsEvent event, emit) async {
    emit(RoomLoadingState());
    try {
      final response = await roomService.getAvailableRooms(
          event.dayId, event.startTime, event.endTime);
      List<RoomModel> rooms = [];

      response['data'].forEach((value) {
        rooms.add(RoomModel.fromMap(value));
      });

      emit(RoomLoadedState(rooms: rooms));
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _addRoom(AddRoomEvent event, emit) async {
    print('------1');
    try {
      await roomService.addRoom(event.name, event.description, event.capacity);
      add(GetRoomsEvent());
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _updateRoom(UpdateRoomEvent event, emit) async {
    try {
      await roomService.updateRoom(
          event.roomId, event.name, event.description, event.capacity);
      add(GetRoomsEvent());
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _deleteRoom(DeleteRoomEvent event, emit) async {
    try {
      await roomService.deleteRoom(event.roomId);
      add(GetRoomsEvent());
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }
}
