import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';
import 'package:flutter_application/data/models/subject_model.dart';
import 'package:flutter_application/logic/blocs/group/group_bloc.dart';
import 'package:flutter_application/logic/blocs/group/group_events.dart';
import 'package:flutter_application/ui/views/screens/drawer/custom_drawer.dart';
import 'package:flutter_application/ui/views/widgets/choose_subject.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'choose_teacher.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  TextEditingController nameEditingController = TextEditingController();
  GeneralUserInfoModel? mainTeacher;
  GeneralUserInfoModel? asistantTeacher;
  SubjectModel? subjectModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Main Teacher: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      mainTeacher != null ? mainTeacher!.name : "",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      mainTeacher = await chooseTeacher(context);
                      setState(() {});
                    },
                    icon: const Icon(CupertinoIcons.person_add_solid))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Asistant Teacher: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      asistantTeacher != null ? asistantTeacher!.name : "",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      asistantTeacher = await chooseTeacher(context);
                      setState(() {});
                    },
                    icon: const Icon(CupertinoIcons.person_add_solid))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Subjects: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      subjectModel != null ? subjectModel!.name : "",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      subjectModel = await chooseSubject(context);
                      setState(() {});
                    },
                    icon: const Icon(CupertinoIcons.person_add_solid))
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  context.read<GroupBloc>().add(AddGroupEvent(
                      name: nameEditingController.text,
                      mainTeacherId: mainTeacher!.id,
                      assistantTeacherId: asistantTeacher!.id,
                      subjectId: subjectModel!.id));
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => AdminScreen(),
                  //     ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: const Text(
                  "Add Group",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
