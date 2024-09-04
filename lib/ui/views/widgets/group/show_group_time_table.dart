import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/group_model.dart';
import 'package:flutter_application/data/models/week_days.dart';
import 'package:flutter_application/logic/blocs/time_table/time_table_bloc.dart';
import 'package:flutter_application/logic/blocs/time_table/time_table_events.dart';
import 'package:flutter_application/logic/blocs/time_table/time_table_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowGroupTimetable extends StatefulWidget {
  final GroupModel groupModel;
  const ShowGroupTimetable({super.key, required this.groupModel});

  @override
  State<ShowGroupTimetable> createState() => _ShowGroupTimetableState();
}

class _ShowGroupTimetableState extends State<ShowGroupTimetable> {
  @override
  void initState() {
    super.initState();
    context
        .read<TimetableBloc>()
        .add(GetTimeTablesEvent(groupId: widget.groupModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.groupModel.name} TimeTable",
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TimetableBloc, TimeTableState>(
        builder: (context, state) {
          if (state is TimeTableLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TimeTableErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is TimeTableLoadedState) {
            if (state.timeTables == null) {
              return const Center(
                child: Text("Timetable hali mavjud emas"),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: state.timeTables!.weekDays.entries.map((entry) {
                String weekDay = entry.key;
                List<WeekDays> timetable = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weekDay,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    ...timetable.map((day) {
                      return Card(
                        child: ListTile(
                          title: Text(day.room),
                          subtitle: Text("${day.startTime} - ${day.endTime}"),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            );
          }
          return const Center(
            child: Text("Timetable topilmadi!"),
          );
        },
      ),
    
    );
  }
}