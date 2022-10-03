import 'package:account_manager/widgets/search_view.dart';
import 'package:flutter/material.dart';

class ListDataHeader extends StatelessWidget {
  const ListDataHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: SearchView()),
        SizedBox(width: 16,),
        Icon(Icons.filter_alt_rounded),
        SizedBox(width: 8,),
        Icon(Icons.picture_as_pdf),

      ],
    );
  }
}
