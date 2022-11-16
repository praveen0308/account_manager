import 'package:flutter/material.dart';


class AppDialog extends StatelessWidget {
  final Widget child;
  final double? height;

  const AppDialog({Key? key, required this.child, this.height=350}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 6,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ), child: child,)
    );
  }


}

