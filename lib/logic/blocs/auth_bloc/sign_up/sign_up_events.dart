import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/user_model.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final UserModel user;

  SignupSubmitted({required this.user});

  @override
  List<Object> get props => [user];
}
