import 'package:equatable/equatable.dart';

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

class SignOut extends SignInEvent {}
