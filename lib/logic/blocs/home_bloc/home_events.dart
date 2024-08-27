import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';

sealed class HomeEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeUserUpdated extends HomeEvents {
  final GeneralUserInfoModel generalUserInfoModel;

  HomeUserUpdated(this.generalUserInfoModel);

  @override
  List<Object> get props => [generalUserInfoModel];
}

class HomeGetAllUsers extends HomeEvents {}

class HomeLogout extends HomeEvents {}
