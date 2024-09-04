import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/time_table.dart';

sealed class TimeTableState extends Equatable {
  @override
  List<Object> get props => [];
}

class TimeTableInitialState extends TimeTableState {}

class TimeTableLoadingState extends TimeTableState {}

class TimeTableLoadedState extends TimeTableState {
  final Timetable? timeTables;

  TimeTableLoadedState({required this.timeTables});
}


class TimeTableErrorState extends TimeTableState {
  final String error;
  TimeTableErrorState({required this.error});
}