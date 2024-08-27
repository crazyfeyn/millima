import 'package:equatable/equatable.dart';

sealed class SubjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSubjectEvent extends SubjectEvent {}

class UpdateSubjectEvent extends SubjectEvent {
  final int subjectId;
  final String name;

  UpdateSubjectEvent({
    required this.subjectId,
    required this.name,
  });
}

class DeleteSubjectEvent extends SubjectEvent {
  final int subjectId;

  DeleteSubjectEvent({
    required this.subjectId,
  });
}

class AddSubjectEvent extends SubjectEvent {
  final String name;

  AddSubjectEvent({
    required this.name,
  });
}