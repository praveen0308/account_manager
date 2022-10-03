import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryDark,),
        color: AppColors.primaryLightest
      ),
      child: Row(
        children: [
          Icon(Icons.search),
          const SizedBox(width: 16,),
          Expanded(child: TextFormField(

            decoration: InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
            ),
          ))
        ],
      ),
    );
  }
}
