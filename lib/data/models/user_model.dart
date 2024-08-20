class UserModel {
  String name;
  String phone;
  String password;
  String passwordConfirmation;

  UserModel(
      {required this.name,
      required this.phone,
      required this.password,
      required this.passwordConfirmation});
}
