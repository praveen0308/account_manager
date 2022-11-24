import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../res/app_colors.dart';
import '../utils/date_time_helper.dart';

class DateFilterBar extends StatefulWidget {
  final Function(DateTime dateTime,DateFilter filter) filterChanged;

  const DateFilterBar({Key? key, required this.filterChanged}) : super(key: key);

  @override
  State<DateFilterBar> createState() => _DateFilterBarState();
}

class _DateFilterBarState extends State<DateFilterBar> {
  DateTime _fDate = DateTime.now();
  var activeFilter = DateFilter.monthly;

  String getCurrFilterLabel() {
    switch (activeFilter) {
      case DateFilter.daily:
        return DateFormat("dd MMM yy").format(_fDate);
      case DateFilter.monthly:
        if (_fDate.year == DateTime.now().year) {
          return DateFormat("MMMM").format(_fDate);
        } else {
          return DateFormat("MMM yyyy").format(_fDate);
        }

      case DateFilter.yearly:
        return DateFormat.y().format(_fDate);
    }
  }

  Future<void> _showFilters() async {
    switch (await showDialog<DateFilter>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, DateFilter.daily);
                },
                child: const Text('Daily'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, DateFilter.monthly);
                },
                child: const Text('Monthly'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, DateFilter.yearly);
                },
                child: const Text('Yearly'),
              ),
            ],
          );
        })) {
      case DateFilter.daily:
        setState(() {
          activeFilter = DateFilter.daily;
          widget.filterChanged(_fDate,activeFilter);
        });
        break;
      case DateFilter.monthly:
        setState(() {
          activeFilter = DateFilter.monthly;
          widget.filterChanged(_fDate,activeFilter);
        });
        break;

      case DateFilter.yearly:
        setState(() {
          activeFilter = DateFilter.yearly;
          widget.filterChanged(_fDate,activeFilter);
        });
        break;
      case null:
      // dialog dismissed
        break;
    }
  }

  void _shift(int d) {
    DateTime nDate;

    switch (activeFilter) {
      case DateFilter.daily:
        nDate = DateTime(_fDate.year, _fDate.month, _fDate.day + d);
        break;
      case DateFilter.monthly:
        nDate = DateTime(_fDate.year, _fDate.month + d, _fDate.day);
        break;
      case DateFilter.yearly:
        nDate = DateTime(_fDate.year + d, _fDate.month, _fDate.day);
        break;
    }

    setState(() {
      _fDate = nDate;
    });
    widget.filterChanged(_fDate,activeFilter);

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded, size: 28),
            onPressed: () {
              _shift(-1);
            },
          ),
          Expanded(
            child: GestureDetector(
              onTap: _showFilters,
              child: Text(
                getCurrFilterLabel(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDarkest),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded, size: 28),
            onPressed: () {
              _shift(1);
            },
          ),
        ],
      ),
    );
  }
}
