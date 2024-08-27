import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';

sealed class HomeStates extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeLoadedState extends HomeStates {
  final GeneralUserInfoModel generalUserInfoModel;

  HomeLoadedState(this.generalUserInfoModel);

  @override
  List<Object> get props => [generalUserInfoModel];
}

class HomeGetAllUsersState extends HomeStates {
  List<GeneralUserInfoModel> users;

  HomeGetAllUsersState(this.users);
}

class HomeLogoutState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String error;

  HomeErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
