import 'package:account_manager/ui/features/income_expense/pick_category/pick_category_cubit.dart';
import 'package:account_manager/utils/income_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickCategory extends StatefulWidget {
  final IncomeType type;
  const PickCategory({Key? key, required this.type}) : super(key: key);

  @override
  State<PickCategory> createState() => _PickCategoryState();
}

class _PickCategoryState extends State<PickCategory> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PickCategoryCubit,PickCategoryState>(
        builder: (context,state){
          if (state is ReceivedCategories) {
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                var category = state.categories[index];

                return ListTile(
                  onTap: (){
                    Navigator.pop(context,category);
                  },
                  visualDensity:
                  const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Icon(
                      IconData(category.icon, fontFamily: "MaterialIcons")),
                  title: Text(category.name),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                );
              },
            );
          }

          if (state is Loading) {
            return const CircularProgressIndicator();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.category_outlined,
                  size: 80,
                ),
                Text("No Categories!!")
              ],
            ),
          );
        },
      ),
    ));
  }

  @override
  void initState() {
    BlocProvider.of<PickCategoryCubit>(context).fetchCategories(widget.type);
  }
}
