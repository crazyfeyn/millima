import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_application/services/auth_service.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final AuthService authService;

  HomeBloc({required this.authService}) : super(HomeInitialState()) {
    on<HomeLogout>(_homeLogout);
    on<HomeUserUpdated>(_homeUserUpdated);
    on<HomeGetAllUsers>(_homeGetAllUsers);

    // Load initial user data
    _loadInitialUserData();
  }

  Future<void> _loadInitialUserData() async {
    emit(HomeLoadingState());
    try {
      final userInfo = await authService.getUser();
      emit(HomeLoadedState(userInfo));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  Future<void> _homeLogout(HomeLogout event, Emitter<HomeStates> emit) async {
    emit(HomeLoadingState());
    await authService.logout();
    emit(HomeLogoutState());
  }

  Future<void> _homeUserUpdated(
      HomeUserUpdated event, Emitter<HomeStates> emit) async {
    emit(HomeLoadingState());
    try {
      await authService.updateProfile(
        name: event.generalUserInfoModel.name,
        phone: event.generalUserInfoModel.phone ?? '',
        email: event.generalUserInfoModel.email,
        photo: event.generalUserInfoModel.photo != null
            ? File(event.generalUserInfoModel.photo!)
            : null,
      );
      emit(HomeLoadedState(event.generalUserInfoModel));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  _homeGetAllUsers(HomeGetAllUsers event, Emitter<HomeStates> emit) async {
    emit(HomeLoadingState());
    try {
      List<GeneralUserInfoModel> users = await authService.getAllUsers();
      emit(HomeGetAllUsersState(users));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }
}
