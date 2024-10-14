import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/group_model.dart';
import 'package:flutter_application/logic/blocs/group/group_bloc.dart';
import 'package:flutter_application/logic/blocs/group/group_states.dart';
import 'package:flutter_application/ui/views/screens/drawer/custom_drawer.dart';
import 'package:flutter_application/ui/views/screens/drawer/managa_room.dart';
import 'package:flutter_application/ui/views/screens/profile/profile_widget.dart';
import 'package:flutter_application/ui/views/widgets/add_group.dart';
import 'package:flutter_application/ui/views/widgets/group/group_item_for_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatelessWidget {
  final GeneralUserInfoModel generalUserInfoModel;

  const AdminScreen({super.key, required this.generalUserInfoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileWidget(
                        generalUserInfoModel: generalUserInfoModel))),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
        if (state is GroupLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GroupErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Create a group'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManageRoom(
                                roomModel: null,
                              ),
                            ));
                      },
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddGroup())),
                        child: const CircleAvatar(
                          child: Icon(Icons.add),
                        ),
                      ))
                ],
              ),
              if (state is GroupLoadedState)
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: state.groups.length,
                  itemBuilder: (context, index) {
                    return GroupItemForAdmin(
                      groupModel: GroupModel(
                          id: state.groups[index].id,
                          name: state.groups[index].name,
                          mainTeacher: state.groups[index].mainTeacher,
                          assistantTeacher:
                              state.groups[index].assistantTeacher,
                          subjectModel: state.groups[index].subjectModel,
                          students: state.groups[index].students,
                          classes: state.groups[index].classes),
                    );
                  },
                )),
            ],
          ),
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ManageRoom(
      //             roomModel: null,
      //           ),
      //         ));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
