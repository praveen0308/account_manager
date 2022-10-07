import 'package:account_manager/widgets/search_view.dart';
import 'package:flutter/material.dart';

class ListDataHeader extends StatelessWidget {
  final Function(String q) onSearched;
  final Function(TapDownDetails details) onFilterClicked;
  final VoidCallback onPdfClicked;

  const ListDataHeader({Key? key,
    required this.onFilterClicked,
    required this.onSearched,
    required this.onPdfClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
    Expanded(child: SearchView(
    onTextChanged: (String txt)
    {
      onSearched(txt);
    },
    )),
    const SizedBox(
    width: 16,
    ),

    GestureDetector(child: const Icon(Icons.filter_alt_rounded),onTapDown: (d){
      onFilterClicked(d);
    },),


    const SizedBox(
    width: 8,
    ),
    IconButton(
    icon: const Icon(Icons.picture_as_pdf),
    onPressed: onPdfClicked,
    )
    ,
    ]
    ,
    );
  }
}
