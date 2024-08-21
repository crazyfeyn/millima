import 'package:bloc/bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_application/services/auth_service.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final authService = AuthService();
  HomeBloc() : super(HomeInitialState()) {
    on<HomeLogout>(_homeLogout);
  }

  _homeLogout(event, emit) async{
    emit(HomeLoadingState());
    await authService.logout();
    emit(HomeLogoutState());
  }
}
