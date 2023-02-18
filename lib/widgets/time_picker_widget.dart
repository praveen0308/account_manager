import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay time) onTimeSelected;
  final PickerType? type;

  const TimePickerWidget(
      {Key? key, required this.onTimeSelected, this.type = PickerType.normal})
      : super(key: key);

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
        widget.onTimeSelected(selectedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Row(
        children: [
          Icon(Icons.access_time_rounded, color: AppColors.primaryDarkest,
            size: widget.type == PickerType.normal ? 32 : 24,),
          const SizedBox(width: 8,),
          Expanded(child: Text(selectedTime.format(context), style: TextStyle(
              fontSize: widget.type == PickerType.normal ? 20 : 14,
              color: AppColors.primaryText,fontWeight: FontWeight.w600),))
        ],
      ),
    );
  }
}
