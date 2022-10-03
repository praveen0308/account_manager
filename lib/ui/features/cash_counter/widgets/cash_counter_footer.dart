import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/container_light.dart';
import 'package:account_manager/widgets/date_picker_widget.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:account_manager/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:account_manager/route/route.dart' as route;

class CCBottomSheet extends StatefulWidget {
  const CCBottomSheet({Key? key}) : super(key: key);

  @override
  State<CCBottomSheet> createState() => _CCBottomSheetState();
}

class _CCBottomSheetState extends State<CCBottomSheet> {
  final GlobalKey _menuKey = GlobalKey();

  late PopupMenuButton<String> menus;

  showPopupMenu(BuildContext context, TapDownDetails details) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy - 180,
        details.globalPosition.dx,
        details.globalPosition.dy - 180,
      ), //position where you want to show the menu on screen
      items: const [
        PopupMenuItem<String>(
            value: '1',
            child:  Text('menu option 1')),
        PopupMenuItem<String>(
            value: '2',
            child:  Text('menu option 2')),
        PopupMenuItem<String>(
            value: '3',
            child:  Text('menu option 3')),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        //code here
      } else if (itemSelected == "2") {
        //code here
      } else {
        //code here
      }
    });
  }

  @override
  void initState() {
    menus = PopupMenuButton(
        key: _menuKey,
        itemBuilder: (_) =>
        const<PopupMenuItem<String>>[
          PopupMenuItem<String>(
              value: 'Doge',
              child: Text('Doge')),
          PopupMenuItem<String>(
              value: 'Lion',
              child: Text('Lion')),
        ],
        onSelected: (_) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          border: Border.all(color: AppColors.dividerColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<CashCounterCubit, CashCounterState>(
            buildWhen: (previousState,state){
              if(state is ClearScreen){
                return true;
              }
              if(state is EntriesChanged){
                return true;
              }

              return false;
            },
            builder: (context, state) {


              return Row(
                children: [
                  GestureDetector(
                    onTapDown: (details) => showPopupMenu(context, details),
                    child: ContainerLight(
                      childWidget: const Center(
                        child: Icon(Icons.list, size: 32),
                      ),
                      onClick: () {
                        // This is a hack because _PopupMenuButtonState is private.
                        //
                        // dynamic state = _menuKey.currentState;
                        // state.showButtonMenu();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: ContainerLight(
                        childWidget: Column(
                          children: [
                            const Text(
                              "Notes",
                              style: TextStyle(
                                  color: AppColors.primaryDarkest,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            Text(
                              state.noOfNotes.toString(),
                              style: const TextStyle(
                                  color: AppColors.primaryDarkest,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: ContainerLight(
                        childWidget: Column(
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                  color: AppColors.primaryDarkest,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            Text(
                              state.grandTotal.toString(),
                              style: const TextStyle(
                                  color: AppColors.primaryDarkest,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ))
                ],
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: const [
              Expanded(child: DatePickerWidget()),
              SizedBox(
                width: 16,
              ),
              Expanded(child: TimePickerWidget())
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(child: SecondaryButton(onClick: () {
                BlocProvider.of<CashCounterCubit>(context).clearFields();
              }, text: "Clear")),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: PrimaryButton(onClick: () {
                BlocProvider.of<CashCounterCubit>(context).addCashTransaction();
              }, text: "Save"))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          PrimaryButton(onClick: () {
            Navigator.pushNamed(context, route.cashCounterHistory);

          }, text: "View History")
        ],
      ),
    );
  }
}
