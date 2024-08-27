class GeneralUserInfoModel {
  int id;
  String name;
  String? phone;
  int roleId;
  String? email;
  String? photo;

  GeneralUserInfoModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.roleId,
    this.email,
    this.photo,
  });

  factory GeneralUserInfoModel.fromMap(Map<String, dynamic> map) {
    return GeneralUserInfoModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photo: map['photo'],
      roleId: map['role_id'],
    );
  }
}
