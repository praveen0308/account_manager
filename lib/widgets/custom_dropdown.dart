import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../res/app_colors.dart';
import '../res/app_images.dart';

class CustomDropDown extends StatefulWidget {
  final String hint;
  final bool isOutlined;
  final int? selectedIndex;
  final List<dynamic> itemList;
  final Function(dynamic) onItemSelected;

  const CustomDropDown(
      {Key? key,
      required this.hint,
      required this.itemList,
      required this.onItemSelected,
      this.isOutlined = false,
      this.selectedIndex})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  dynamic selectedDocument;

  @override
  void initState() {
    if (widget.selectedIndex != null) {
      selectedDocument = widget.itemList[widget.selectedIndex!];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedContainer(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            icon: const Icon(Icons.arrow_drop_down_rounded),
            iconEnabledColor: AppColors.primary,
            value: selectedDocument,
            isExpanded: true,
            items: widget.itemList.map(buildDropDownMenuItem).toList(),
            onChanged: (value) {
              widget.onItemSelected(value);
              setState(() {
                selectedDocument = value!;
              });
            },
            hint: Text(widget.hint),
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<dynamic> buildDropDownMenuItem(dynamic item) =>
    DropdownMenuItem(
        value: item,
        child: Text(
          item.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ));
