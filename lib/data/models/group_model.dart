import 'package:flutter_application/data/models/class_model.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/subject_model.dart';

class GroupModel {
  int id;
  String name;
  GeneralUserInfoModel mainTeacher;
  GeneralUserInfoModel assistantTeacher;
  SubjectModel? subjectModel;
  List<GeneralUserInfoModel> students;
  List<ClassModel> classes;

  GroupModel({
    required this.id,
    required this.name,
    required this.mainTeacher,
    required this.assistantTeacher,
    required this.subjectModel,
    required this.students,
    required this.classes,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    List<GeneralUserInfoModel> students =
        (map['students'] as List).map((student) {
      return GeneralUserInfoModel.fromMap(student);
    }).toList();

    List<ClassModel> classes = (map['classes'] as List).map((clas) {
      return ClassModel.fromMap(clas);
    }).toList();

    return GroupModel(
      id: map['id'],
      name: map['name'],
      mainTeacher: GeneralUserInfoModel.fromMap(map['mainTeacher']),
      assistantTeacher: GeneralUserInfoModel.fromMap(map['assistantTeacher']),
      students: students,
      classes: classes,
      subjectModel:
          map['subject'] != null ? SubjectModel.fromMap(map['subject']) : null,
    );
  }
}
