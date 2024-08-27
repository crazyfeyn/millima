import 'package:equatable/equatable.dart';

sealed class GroupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGroupsEvent extends GroupEvent {}

class GetStudentGroupsEvent extends GroupEvent {}

class UpdateGroupEvent extends GroupEvent {
  final int groupId;
  final String name;
  final int mainTeacherId;
  final int assistantTeacherId;

  UpdateGroupEvent({
    required this.groupId,
    required this.name,
    required this.mainTeacherId,
    required this.assistantTeacherId,
  });
}

class DeleteGroupEvent extends GroupEvent {
  final int groupId;

  DeleteGroupEvent({
    required this.groupId,
  });
}

class AddGroupEvent extends GroupEvent {
  final String name;
  final int mainTeacherId;
  final int assistantTeacherId;
  final int subjectId;

  AddGroupEvent({
    required this.name,
    required this.mainTeacherId,
    required this.assistantTeacherId,
    required this.subjectId,
  });
}

class AddStudentsToGroupEvent extends GroupEvent {
  final int groupId;
  final List studentsId;

  AddStudentsToGroupEvent({
    required this.groupId,
    required this.studentsId,
  });
}
