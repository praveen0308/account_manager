import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';

class QuickActionItem extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  final String text;

  const QuickActionItem(
      {Key? key, required this.onClick, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
        child: Row(
      children: [Icon(icon), Text(text)],
    ));
  }
}
