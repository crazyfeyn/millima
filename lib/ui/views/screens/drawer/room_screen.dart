import 'package:flutter/material.dart';
import 'package:flutter_application/logic/blocs/room/room_bloc.dart';
import 'package:flutter_application/logic/blocs/room/room_events.dart';
import 'package:flutter_application/logic/blocs/room/room_states.dart';
import 'package:flutter_application/ui/views/screens/drawer/custom_drawer.dart';
import 'package:flutter_application/ui/views/screens/drawer/managa_room.dart';
import 'package:flutter_application/ui/views/widgets/room_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(GetRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rooms",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<RoomBloc, RoomState>(builder: (context, state) {
        if (state is RoomLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoomErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is RoomLoadedState) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              return RoomItem(roomModel: state.rooms[index]);
            },
          );
        }
        return const Center(
          child: Text("Empty Room"),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManageRoom(
                  roomModel: null,
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
