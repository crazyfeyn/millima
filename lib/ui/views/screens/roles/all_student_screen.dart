import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllStudentScreen extends StatelessWidget {
  const AllStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomeGetAllUsers());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is HomeGetAllUsersState) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              if (user.roleId == 1) {
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email ?? 'No email'),
                  leading: user.photo != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.photo!),
                        )
                      : const CircleAvatar(child: Icon(Icons.person)),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        }
        return const SizedBox();
      }),
    );
  }
}
