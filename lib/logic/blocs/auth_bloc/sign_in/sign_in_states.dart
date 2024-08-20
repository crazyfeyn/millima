import 'package:equatable/equatable.dart';

abstract class SignInStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInLoadedState extends SignInStates {}

class SignedOutState extends SignInStates {}

class SignInErrorState extends SignInStates {
  final String error;

  SignInErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
