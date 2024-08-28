import 'package:flutter_application/data/models/group_model.dart';
import 'package:flutter_application/logic/blocs/group/group_events.dart';
import 'package:flutter_application/logic/blocs/group/group_states.dart';
import 'package:flutter_application/data/services/group_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitialState()) {
    on<GetGroupsEvent>(_onGetGroups);
    on<GetStudentGroupsEvent>(_onGetStudentGroups);
    on<AddGroupEvent>(_addGroups);
    on<UpdateGroupEvent>(_updateGroups);
    on<AddStudentsToGroupEvent>(_addStudentsToGroups);
    on<DeleteGroupEvent>(_deleteGroups);
  }

  Future<void> _onGetGroups(GetGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getGroups();
      List<GroupModel> groups = [];
      response['data'].forEach((value) {
        groups.add(GroupModel.fromMap(value));
      });

      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _onGetStudentGroups(GetStudentGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getStudentGroups();
      List<GroupModel> groups = [];

      response['data'].forEach((value) {
        groups.add(GroupModel.fromMap(value));
      });

      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _addGroups(AddGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      emit(GroupLoadingState());
      await groupService.addGroup(event.name, event.mainTeacherId,
          event.assistantTeacherId, event.subjectId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _addStudentsToGroups(AddStudentsToGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.addStudentsToGroup(event.groupId, event.studentsId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _updateGroups(UpdateGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.updateGroup(event.groupId, event.name,
          event.mainTeacherId, event.assistantTeacherId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _deleteGroups(DeleteGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.deleteGroup(event.groupId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }
}
