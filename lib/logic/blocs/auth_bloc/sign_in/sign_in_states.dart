import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/user_model.dart';

abstract class SignInStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInLoadedState extends SignInStates {
  GeneralUserInfoModel generalUserInfoModel;

  SignInLoadedState(this.generalUserInfoModel);
}

class SignedOutState extends SignInStates {}

class SignInErrorState extends SignInStates {
  final String error;

  SignInErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
