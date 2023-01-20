import 'package:flutter/material.dart';

class NumericKeyboardView extends StatefulWidget {
  final Function(String char) onTap;
  final bool isEnterEnabled;

  const NumericKeyboardView(
      {Key? key, required this.onTap, required this.isEnterEnabled})
      : super(key: key);

  @override
  State<NumericKeyboardView> createState() => _NumericKeyboardViewState();
}

class _NumericKeyboardViewState extends State<NumericKeyboardView> {
  final List<String> buttons = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "⌫",
    "0"
  ];

  @override
  void initState() {
    if (widget.isEnterEnabled) buttons.add("OK");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    const double itemHeight = 120;
    final double itemWidth = size.width / 2;

    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: buttons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (_, index) {
          return TextButton(
            onPressed: () {
              widget.onTap(buttons[index]);
            },
            child: Text(
              buttons[index],
              style: const TextStyle(fontSize: 18),
            ),
          );
        });
  }
}
