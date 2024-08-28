import 'package:bloc/bloc.dart';
import 'package:flutter_application/data/models/auth/social_login_request.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/sign_in/sign_in_events.dart';
import 'package:flutter_application/logic/blocs/auth_bloc/sign_in/sign_in_states.dart';
import 'package:flutter_application/data/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SocialLoginTypes { google, facebook, github }

class SigninBloc extends Bloc<SignInEvent, SignInStates> {
  final authService = AuthService();
  SigninBloc() : super(SignInInitialState()) {
    on<SignInCheckToken>(_checkToken);
    on<SignInSubmitted>(_signInSubmitted);
    on<SocialLoginEvent>(_onSocialLogin);
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

  Future<void> _checkToken(
      SignInCheckToken event, Emitter<SignInStates> emit) async {
    emit(SignInLoadingState());
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('token');
      if (token != null && token.isNotEmpty) {
        GeneralUserInfoModel userModel = await authService.getUser();
        emit(SignInLoadedState(userModel));
      } else {
        emit(SignedOutState());
      }
    } catch (e) {
      emit(SignInErrorState(error: e.toString()));
    }
  }

  void _onSocialLogin(
    SocialLoginEvent event,
    Emitter<SignInStates> emit,
  ) async {
    SignInLoadingState();

    try {
      SocialLoginRequest? request;
      switch (event.type) {
        case SocialLoginTypes.google:
          const List<String> scopes = <String>['email'];
          final googleSignIn = GoogleSignIn(scopes: scopes);
          final googleUser = await googleSignIn.signIn();
          if (googleUser != null) {
            request = SocialLoginRequest(
              name: googleUser.displayName ?? '',
              email: googleUser.email,
            );
          }
          break;
        // case SocialLoginTypes.facebook:
        //   final result = await FacebookAuth.instance.login();
        //   if (result.status == LoginStatus.success) {
        //     final userData = await FacebookAuth.i.getUserData(
        //       fields: "name,email",
        //     );
        //     request = SocialLoginRequest(
        //       name: userData['name'] ?? '',
        //       email: userData['email'],
        //     );
        //   }
        // break;
        default:
          return;
      }

      if (request != null) {
        await authService.socialLogin(request);
        emit(
          SignInLoadedState(
            GeneralUserInfoModel(
                id: 102, name: request.name, phone: null, roleId: 1),
          ),
        );
      } else {
        throw ('User not found');
      }
    } catch (e) {
      SignInErrorState(error: e.toString());
    }
  }
}
