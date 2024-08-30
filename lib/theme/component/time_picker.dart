import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePicker extends StatelessWidget {
  const TimePicker(
      {super.key, required this.selectedTime, required this.onDateTimeChanged});
  final TimeOfDay selectedTime;
  final Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 200.h,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime:
                  DateTime(2024, 1, 1, selectedTime.hour, selectedTime.minute),
              onDateTimeChanged: onDateTimeChanged,
              use24hFormat: true,
            ),
          ),
          CupertinoButton(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
