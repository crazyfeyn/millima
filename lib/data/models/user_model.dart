class UserModel {
  String name;
  String phone;
  String password;
  String passwordConfirmation;
  int? roleId;
  String? email;

  UserModel({
    required this.name,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    this.roleId,
  });
  
}
