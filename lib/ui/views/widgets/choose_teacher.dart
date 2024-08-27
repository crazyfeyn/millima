import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<GeneralUserInfoModel?> chooseTeacher(BuildContext context) {
  GeneralUserInfoModel? selectedUser;

  return showDialog<GeneralUserInfoModel>(
    context: context,
    builder: (BuildContext context) {
      context.read<HomeBloc>().add(HomeGetAllUsers());
      return AlertDialog(
        title: const Text("Select a teacher"),
        content: BlocBuilder<HomeBloc, HomeStates>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is HomeGetAllUsersState) {
              List<GeneralUserInfoModel> roleUsers =
                  state.users.where((element) => element.roleId == 2).toList();

              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: roleUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        roleUsers[index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(roleUsers[index].phone ?? ''),
                      leading: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: roleUsers[index].photo == null
                            ? const Icon(
                                Icons.person,
                                size: 40,
                              )
                            : Image.network(
                                "http://millima.flutterwithakmaljon.uz/storage/avatars/${roleUsers[index].photo}",
                                fit: BoxFit.cover,
                              ),
                      ),
                      onTap: () {
                        selectedUser = roleUsers[index];
                        Navigator.of(context).pop(selectedUser);
                      },
                    );
                  },
                ),
              );
            }
            return const Center(
              child: Text("User topilmadi!"),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Bekor qilish'),
          ),
        ],
      );
    },
  );
}
