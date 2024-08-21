class GeneralUserInfoModel {
  String name;
  String phone;
  int roleId;
  String? email;
  String? photo;

  GeneralUserInfoModel({
    required this.name,
    required this.phone,
    required this.roleId,
    this.email,
    this.photo,
  });
}
