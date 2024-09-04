import 'package:flutter_application/data/models/time_table.dart';
import 'package:flutter_application/data/services/timetable_service.dart';
import 'package:flutter_application/logic/blocs/time_table/time_table_events.dart';
import 'package:flutter_application/logic/blocs/time_table/time_table_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimetableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  TimetableBloc() : super(TimeTableInitialState()) {
    on<GetTimeTablesEvent>(_onGetTimetables);
    on<CreateTimeTableEvent>(_addTimetable);
  }

  final TimetableService timetableService = TimetableService();

  Future<void> _onGetTimetables(GetTimeTablesEvent event, emit) async {
    emit(TimeTableLoadingState());
    try {
      final Map<String, dynamic> response =
          await timetableService.getGroupTimeTables(event.groupId);
      dynamic box = response['data'];
      if (box.isEmpty) {
        emit(TimeTableLoadedState(timeTables: null));
      } else {
        final timeTable = Timetable.fromMap(response['data']);
        emit(TimeTableLoadedState(timeTables: timeTable));
      }
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }

  Future<void> _addTimetable(CreateTimeTableEvent event, emit) async {
    try {
      await timetableService.createTimetable(event.groupId, event.roomId,
          event.dayId, event.startTime, event.endTime);
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }
}
