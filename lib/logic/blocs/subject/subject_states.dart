import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/subject_model.dart';

sealed class SubjectState extends Equatable {
  @override
  List<Object> get props => [];
}

class SubjectInitialState extends SubjectState {}

class SubjectLoadingState extends SubjectState {}

class SubjectLoadedState extends SubjectState {
  final List<SubjectModel> subjects;

  SubjectLoadedState({required this.subjects});
}

class SubjectErrorState extends SubjectState {
  final String error;
  SubjectErrorState({required this.error});
}
