import 'package:flutter_application/data/models/subject_model.dart';
import 'package:flutter_application/logic/blocs/subject/subject_event.dart';
import 'package:flutter_application/logic/blocs/subject/subject_states.dart';
import 'package:flutter_application/services/subject_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitialState()) {
    on<GetSubjectEvent>(_onGetSubjects);
    on<AddSubjectEvent>(_addSubject);
    on<UpdateSubjectEvent>(_updateSubject);
    on<DeleteSubjectEvent>(_deleteSubject);
  }

  final SubjectService subjectService = SubjectService();

  Future<void> _onGetSubjects(GetSubjectEvent event, emit) async {
    emit(SubjectLoadingState());
    try {
      final response = await subjectService.getSubjects();
      List<SubjectModel> subjects = [];

      response['data'].forEach((value) {
        subjects.add(SubjectModel.fromMap(value));
      });

      emit(SubjectLoadedState(subjects: subjects));
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _addSubject(AddSubjectEvent event, emit) async {
    emit(SubjectLoadingState());
    try {
      await subjectService.addSubject(event.name);
      add(GetSubjectEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _updateSubject(UpdateSubjectEvent event, emit) async {
    try {
      await subjectService.updateSubject(event.subjectId, event.name);
      add(GetSubjectEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _deleteSubject(DeleteSubjectEvent event, emit) async {
    try {
      await subjectService.deleteSubject(event.subjectId);
      add(GetSubjectEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }
}
