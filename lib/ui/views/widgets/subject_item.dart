import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/subject_model.dart';
import 'package:flutter_application/logic/blocs/subject/subject_bloc.dart';
import 'package:flutter_application/logic/blocs/subject/subject_event.dart';
import 'package:flutter_application/ui/views/widgets/manage_subject.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectItem extends StatelessWidget {
  final SubjectModel subjectModel;
  const SubjectItem({super.key, required this.subjectModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Name: ${subjectModel.name}"),
      subtitle: Text("Id: ${subjectModel.id}"),
      trailing: SizedBox(
        width: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageSubject(
                      subjectModel: subjectModel,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                size: 30,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                context
                    .read<SubjectBloc>()
                    .add(DeleteSubjectEvent(subjectId: subjectModel.id));
              },
              icon: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
