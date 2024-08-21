import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/user_model.dart';

abstract class SignupStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupLoadedState extends SignupStates {
  GeneralUserInfoModel generalUserInfoModel;
  SignupLoadedState(this.generalUserInfoModel);
}

class SignupErrorState extends SignupStates {
  final String error;

  SignupErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
