import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/room_model.dart';
import 'package:flutter_application/logic/blocs/room/room_bloc.dart';
import 'package:flutter_application/logic/blocs/room/room_events.dart';
import 'package:flutter_application/ui/views/screens/drawer/managa_room.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomItem extends StatelessWidget {
  final RoomModel roomModel;
  const RoomItem({super.key, required this.roomModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Room Name: ${roomModel.name}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                "Descripstion: ${roomModel.description}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Capacity: ${roomModel.capacity}",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ManageRoom(
                                    roomModel: roomModel,
                                  ),
                                ));
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            context
                                .read<RoomBloc>()
                                .add(DeleteRoomEvent(roomId: roomModel.id));
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
