import 'package:flutter/material.dart';
import 'package:flutter_application/ui/views/widgets/group/choose_room.dart';

class CreateTimetable extends StatefulWidget {
  final int groupId;
  const CreateTimetable({super.key, required this.groupId});

  @override
  State<StatefulWidget> createState() {
    return _CreateTimetableState();
  }
}

class _CreateTimetableState extends State<CreateTimetable> {
  int? selectedDayIndex;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? TimeOfDay.now() : startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hours = time.hourOfPeriod < 10
        ? '0${time.hourOfPeriod}'
        : time.hourOfPeriod.toString();
    final minutes =
        time.minute < 10 ? '0${time.minute}' : time.minute.toString();
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hours:$minutes $period';
  }

  String _convertTo24HourFormat(TimeOfDay time) {
    final hour = time.hour < 10 ? '0${time.hour}' : time.hour.toString();
    final minute =
        time.minute < 10 ? '0${time.minute}' : time.minute.toString();
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Timetable",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<int>(
              hint: const Text("Choose weekday"),
              value: selectedDayIndex,
              onChanged: (newValue) {
                setState(() {
                  selectedDayIndex = newValue;
                });
              },
              items: weekDays.asMap().entries.map((entry) {
                int idx = entry.key;
                String day = entry.value;
                return DropdownMenuItem(
                  value: idx,
                  child: Text(day),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Starting time:"),
                ElevatedButton(
                  onPressed: () => _selectTime(context, true),
                  child: Text(startTime == null
                      ? "Select"
                      : _formatTimeOfDay(startTime!)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Ending time:"),
                ElevatedButton(
                  onPressed: () => _selectTime(context, false),
                  child: Text(
                      endTime == null ? "Select" : _formatTimeOfDay(endTime!)),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedDayIndex != null &&
                      startTime != null &&
                      endTime != null
                  ? () async {
                      String start = _convertTo24HourFormat(startTime!);
                      String end = _convertTo24HourFormat(endTime!);

                      if (startTime!.hour > endTime!.hour ||
                          (startTime!.hour == endTime!.hour &&
                              startTime!.minute >= endTime!.minute)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("End time must be after the start time."),
                          ),
                        );
                        return;
                      }
                      await chooseRoom(context, widget.groupId,
                          (selectedDayIndex! + 1), start, end);
                    }
                  : null,
              child: const Text("Get Rooms"),
            ),
          ],
        ),
      ),
    );
  }
}
