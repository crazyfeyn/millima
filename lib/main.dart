import 'package:flutter/material.dart';
import 'package:flutter_application/logic/blocs/group/group_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_application/logic/blocs/room/room_bloc.dart';
import 'package:flutter_application/logic/blocs/subject/subject_bloc.dart';
import 'package:flutter_application/data/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/blocs/auth_bloc/sign_in/sign_in_bloc.dart';
import 'logic/blocs/auth_bloc/sign_up/sign_up_bloc.dart';
import 'ui/views/screens/auth/sign_in_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(),
        ),
        BlocProvider<SigninBloc>(
          create: (context) => SigninBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(authService: authService),
        ),
        BlocProvider<RoomBloc>(
          create: (context) => RoomBloc(),
        ),
        BlocProvider<GroupBloc>(
          create: (context) => GroupBloc(),
        ),
        BlocProvider<SubjectBloc>(
          create: (context) => SubjectBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SigninScreen(),
      ),
    );
  }
}
