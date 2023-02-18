import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime date) onDateSelected;

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final PickerType? type;
  const DatePickerWidget({Key? key, required this.onDateSelected, this.firstDate, this.lastDate, this.initialDate, this.type=PickerType.normal})
      : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.initialDate??DateTime.now(),
        firstDate: widget.firstDate??DateTime(1980, 1),
        lastDate: widget.lastDate??DateTime(2050));
    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
        widget.onDateSelected(currentDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.calendar_month,
            color: AppColors.primaryDarkest,
            size: widget.type==PickerType.normal?32:24,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            DateTimeHelper.formatDate(currentDate, "dd MMM yyyy"),
            style: TextStyle(
                fontSize: widget.type==PickerType.normal?20:14,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600),
          ))
        ],
      ),
    );
  }
}
