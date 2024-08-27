import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/room_model.dart';
import 'package:flutter_application/logic/blocs/room/room_bloc.dart';
import 'package:flutter_application/logic/blocs/room/room_events.dart';
import 'package:flutter_application/ui/views/screens/drawer/room_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageRoom extends StatelessWidget {
  final RoomModel? roomModel;

  ManageRoom({super.key, required this.roomModel});

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  final ValueNotifier<double> capacityValueNotifier = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    if (roomModel != null) {
      nameEditingController.text = roomModel!.name;
      descriptionEditingController.text = roomModel!.description;
      capacityValueNotifier.value = roomModel!.capacity.toDouble();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          roomModel == null ? "Add Room" : "Edit Room",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
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
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: descriptionEditingController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder<double>(
              valueListenable: capacityValueNotifier,
              builder: (context, value, child) {
                return Column(
                  children: [
                    Text(
                      "Capacity: ${value.toInt()}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Slider(
                      value: value,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: value.toInt().toString(),
                      onChanged: (double newValue) {
                        capacityValueNotifier.value = newValue;
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                roomModel != null
                    ? context.read<RoomBloc>().add(UpdateRoomEvent(
                        roomId: roomModel!.id,
                        name: nameEditingController.text,
                        description: descriptionEditingController.text,
                        capacity: capacityValueNotifier.value.toInt()))
                    : context.read<RoomBloc>().add(AddRoomEvent(
                          name: nameEditingController.text,
                          description: descriptionEditingController.text,
                          capacity: capacityValueNotifier.value.toInt(),
                        ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoomScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              ),
              child: Text(
                roomModel == null ? "Add Room" : "Edit Room",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
