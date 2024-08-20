import 'package:equatable/equatable.dart';

abstract class SignupStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupLoadedState extends SignupStates {}

class SignupErrorState extends SignupStates {
  final String error;

  SignupErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
