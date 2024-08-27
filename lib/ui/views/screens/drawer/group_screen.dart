import 'package:flutter/material.dart';
import 'package:flutter_application/logic/blocs/group/group_bloc.dart';
import 'package:flutter_application/logic/blocs/group/group_events.dart';
import 'package:flutter_application/logic/blocs/group/group_states.dart';
import 'package:flutter_application/ui/views/widgets/group_item_for_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GroupBloc>().add(GetGroupsEvent());
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
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
        if (state is GroupLoadedState) {
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const ManageSubject(
                        //         subjectModel: null,
                        //       ),
                        //     ));
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
                state.groups.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                        return GroupItemForAdmin(
                            groupModel: state.groups[index]);
                      }))
                    : const Center(
                        child: Text("No groups is found"),
                      )
              ],
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
