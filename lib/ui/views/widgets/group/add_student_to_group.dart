import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/group_model.dart';
import 'package:flutter_application/ui/views/widgets/group/update_student.dart';

class AddStudentToGroup extends StatefulWidget {
  final GroupModel groupModel;
  const AddStudentToGroup({super.key, required this.groupModel});

  @override
  State<AddStudentToGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddStudentToGroup> {
  TextEditingController studentsIdController = TextEditingController();
  List students = [];

  @override
  void initState() {
    super.initState();

    for (var element in widget.groupModel.students) {
      students.add(element.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Student To Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "Students Id:  ",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          students.join(", "),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      List? box = await updateStudents(context, students);
                      if (box != null) {
                        students = box;
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.person_add_solid,
                      size: 30,
                    ))
              ],
            ),
            // !  looooook
            // ElevatedButton(
            //     onPressed: () {
            //       // context.read<GroupBloc>().add(AddStudentsToGroupEvent(
            //       //     groupId: widget.groupModel.id, studentsId: students));
            //       // Navigator.pushReplacement(
            //       //     context,
            //       //     MaterialPageRoute(
            //       //       builder: (context) => const AdminScreen(),
            //       //     ));
            //     },
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.blue,
            //         padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
            //     child: const Text(
            //       "Add Students",
            //       style: TextStyle(
            //           fontSize: 25,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.white),
            //     ))
          ],
        ),
      ),
    );
  }
}
