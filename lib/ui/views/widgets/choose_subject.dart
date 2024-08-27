import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/subject_model.dart';
import 'package:flutter_application/logic/blocs/subject/subject_bloc.dart';
import 'package:flutter_application/logic/blocs/subject/subject_event.dart';
import 'package:flutter_application/logic/blocs/subject/subject_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<SubjectModel?> chooseSubject(BuildContext context) {
  BlocProvider.of<SubjectBloc>(context).add(GetSubjectEvent());
  SubjectModel? selectedSubjects;

  return showDialog<SubjectModel>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Fanni tanlang"),
        content: BlocBuilder<SubjectBloc, SubjectState>(
          builder: (context, state) {
            if (state is SubjectLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SubjectErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is SubjectLoadedState) {
              List<SubjectModel> subjects = state.subjects;

              return Container(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "Name: ${subjects[index].name}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text("Id: ${subjects[index].id}"),
                      onTap: () {
                        selectedSubjects = subjects[index];
                        Navigator.of(context).pop(selectedSubjects);
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
