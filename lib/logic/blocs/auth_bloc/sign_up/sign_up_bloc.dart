import 'package:bloc/bloc.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_up_events.dart';
import 'sign_up_states.dart';

class SignupBloc extends Bloc<SignupEvent, SignupStates> {
  SignupBloc() : super(SignupInitialState()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  final authService = AuthService();

  Future<void> _onSignupSubmitted(
      SignupSubmitted event, Emitter<SignupStates> emit) async {
    emit(SignupLoadingState());
    try {
      final result = await authService.signUp(event.user);
      if (result.data['success'] == true) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', result.data['data']['token']);
        GeneralUserInfoModel generalUserInfoModel  = await authService.getUser();
        emit(SignupLoadedState(generalUserInfoModel));
      }
    } catch (e) {
      emit(SignupErrorState(error: e.toString()));
    }
  }
}
