import 'package:flutter/material.dart';
import 'package:flutter_application/logic/blocs/subject/subject_bloc.dart';
import 'package:flutter_application/logic/blocs/subject/subject_event.dart';
import 'package:flutter_application/logic/blocs/subject/subject_states.dart';
import 'package:flutter_application/ui/views/screens/drawer/custom_drawer.dart';
import 'package:flutter_application/ui/views/widgets/manage_subject.dart';
import 'package:flutter_application/ui/views/widgets/subject_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectBloc>().add(GetSubjectEvent());
  }

  @override
  Widget build(BuildContext context) {
    context.read<SubjectBloc>().add(GetSubjectEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subjects",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<SubjectBloc, SubjectState>(
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
            {
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Create a subject'),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ManageSubject(
                                    subjectModel: null,
                                  ),
                                ));
                          },
                          child:
                              // onTap: () => Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const AddGroup())),
                              const CircleAvatar(
                            child: Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.subjects.length,
                        itemBuilder: (context, index) {
                          return SubjectItem(
                              subjectModel: state.subjects[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return const Center(
            child: Text('No data is found'),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ManageSubject(
      //             subjectModel: null,
      //           ),
      //         ));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
