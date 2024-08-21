import 'package:bloc/bloc.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/sign_in/sign_in_events.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/sign_in/sign_in_states.dart';
import 'package:flutter_application/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninBloc extends Bloc<SignInEvent, SignInStates> {
  final authService = AuthService();
  SigninBloc() : super(SignInInitialState()) {
    on<SignInSubmitted>(_signInSubmitted);
  }

  void _signInSubmitted(
      SignInSubmitted event, Emitter<SignInStates> emit) async {
    emit(SignInLoadingState());
    try {
      final result = await authService.signIn(event.phone, event.password);
      if (result.data['success'] == true) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(
          'token',
          result.data['data']['token'],
        );
        GeneralUserInfoModel userModel = await authService.getUser();
        emit(SignInLoadedState(userModel));
      }
    } catch (e) {
      emit(SignInErrorState(error: e.toString()));
    }
  }
}
