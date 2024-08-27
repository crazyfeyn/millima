class SubjectModel {
  int id;
  String name;

  SubjectModel({
    required this.id,
    required this.name,
  });

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'],
      name: map['name'],
    );
  }
}