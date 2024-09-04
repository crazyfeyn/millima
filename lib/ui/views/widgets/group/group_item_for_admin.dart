import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/group_model.dart';
import 'package:flutter_application/logic/blocs/group/group_bloc.dart';
import 'package:flutter_application/logic/blocs/group/group_events.dart';
import 'package:flutter_application/ui/views/widgets/group/add_student_to_group.dart';
import 'package:flutter_application/ui/views/widgets/group/create_time_table.dart';
import 'package:flutter_application/ui/views/widgets/group/show_group_time_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupItemForAdmin extends StatelessWidget {
  final GroupModel groupModel;
  const GroupItemForAdmin({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => GroupInformationScreen(
            //         groupModel: groupModel,
            //       ),
            //     ));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Group Name: ${groupModel.name}",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddStudentToGroup(groupModel: groupModel),
                              ));
                        },
                        icon: const Icon(
                          CupertinoIcons.person_add_solid,
                          size: 30,
                          color: Colors.white,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Main Teacher Id: ${groupModel.mainTeacher.id}",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           UpdateGroup(group: groupModel),
                          //     ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 30,
                          color: Colors.white,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Asistant Teacher id: ${groupModel.assistantTeacher.id}",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .read<GroupBloc>()
                              .add(DeleteGroupEvent(groupId: groupModel.id));
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.red,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShowGroupTimetable(groupModel: groupModel),
                              ));
                        },
                        child: const Text("Show TimeTable")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateTimetable(
                                  groupId: groupModel.id,
                                ),
                              ));
                        },
                        child: const Text("Add TimeTable")),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
