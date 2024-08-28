import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/sign_in/sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInSubmitted extends SignInEvent {
  final String phone;
  final String password;

  SignInSubmitted({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];
}

class SignInGetUser extends SignInEvent {
  final UserModel userModel;

  SignInGetUser(this.userModel);
}

final class SocialLoginEvent extends SignInEvent {
  final SocialLoginTypes type;

  SocialLoginEvent({required this.type});
}

class SignInCheckToken extends SignInEvent {}

class SignOut extends SignInEvent {}
