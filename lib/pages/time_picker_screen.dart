import 'package:flutter/material.dart';

class TimePickerScreen extends StatefulWidget {
  final TimeOfDay? initialTime;

  TimePickerScreen({this.initialTime});

  @override
  _TimePickerScreenState createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Notification Time'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime ?? TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                  child: Text('Select Time'),
                ),
                if (selectedTime != null)
                  Text('Selected Time: ${selectedTime!.format(context)}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(selectedTime);
                  },
                  child: Text('Confirm'),
                ),
              ],
            ),
          ),
        ));
  }
}