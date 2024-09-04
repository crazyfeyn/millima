import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<List?> updateStudents(BuildContext context, List selectedUserIds) {
  context.read<HomeBloc>().add(HomeGetAllUsers());
  return showDialog<List>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Studentlarni tanlang"),
            content:
                BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
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
                    state.users.where((user) => user.roleId == 1).toList();

                return SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: roleUsers.length,
                    itemBuilder: (context, index) {
                      GeneralUserInfoModel user = roleUsers[index];
                      bool isSelected = selectedUserIds.contains(user.id);

                      return ListTile(
                        title: Text(
                          user.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(user.phone!),
                        leading: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          clipBehavior: Clip.hardEdge,
                          child: user.photo == null
                              ? const Icon(Icons.person, size: 40)
                              : Image.network(
                                  "http://millima.flutterwithakmaljon.uz/storage/avatars/${user.photo}",
                                  fit: BoxFit.cover,
                                ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedUserIds.remove(user.id);
                            } else {
                              selectedUserIds.add(user.id);
                            }
                          });
                        },
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text("User topilmadi!"),
              );
            }),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(
                      selectedUserIds); // Tanlangan userlarning IDlarini qaytarish
                },
                child: const Text('Qo\'shish'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialogni yopish
                },
                child: const Text('Bekor qilish'),
              ),
            ],
          );
        },
      );
    },
  );
}
