import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_application/ui/views/screens/auth/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  final GeneralUserInfoModel generalUserInfoModel;

  const HomeScreen({super.key, required this.generalUserInfoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onDoubleTap: () {},
          child: const CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(HomeLogout());
            },
            child: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: BlocListener<HomeBloc, HomeStates>(
        listener: (context, state) {
          if (state is HomeLogoutState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SigninScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Column(
          children: [
            Text('Welcome back ${generalUserInfoModel.name}'),
          ],
        ),
      ),
    );
  }
}
