import 'package:flutter/material.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  String userName;
  String token;
  HomeScreen({super.key, required this.userName, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeLogoutState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
            
          });
        }

        return const SizedBox();
      }),
    );
  }
}
