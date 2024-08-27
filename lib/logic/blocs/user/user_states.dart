import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';

sealed class UserStates extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoadingStates extends UserStates {}

class UserLaoadedStates extends UserStates {
  GeneralUserInfoModel generalUserInfoModel;
  UserLaoadedStates(this.generalUserInfoModel);
}

class UserErrorStates extends UserStates {
  String error;
  UserErrorStates(this.error);
}
