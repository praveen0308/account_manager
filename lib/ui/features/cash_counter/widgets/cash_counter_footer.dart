import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/settings/cc_settings_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/settings/cc_settings_dialog.dart';
import 'package:account_manager/utils/share_utils.dart';
import 'package:account_manager/widgets/container_light.dart';
import 'package:account_manager/widgets/date_picker_widget.dart';
import 'package:account_manager/widgets/marquee_widget.dart';
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
  bool _addIntoCreditDebit = false;

  showPopupMenu(BuildContext context, TapDownDetails details) {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy - 120,
        details.globalPosition.dx,
        details.globalPosition.dy - 120,
      ), //position where you want to show the menu on screen
      items: const [
        PopupMenuItem<int>(value: 1, child: Text('Note Settings')),
        PopupMenuItem<int>(value: 2, child: Text('Share')),
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == 1) {
        _displayDialog(context);
      } else if (itemSelected == 2) {
        ShareUtil.launchWhatsapp(BlocProvider.of<CashCounterCubit>(context)
            .getCurrentSession()
            .getFullDescription());
      } else {
        //code here
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  _displayDialog(BuildContext mContext) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider.value(
            value: BlocProvider.of<CashCounterCubit>(mContext),
            child: BlocProvider(
              create: (context) => CcSettingsCubit(
                  RepositoryProvider.of<CurrencyRepository>(context)),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 6,
                backgroundColor: Colors.transparent,
                child: const CCSettingsDialog(),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          border: Border.all(color: AppColors.dividerColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<CashCounterCubit, CashCounterState>(
            buildWhen: (previousState, state) {
              if (state is ClearScreen) {
                return true;
              }
              if (state is EntriesChanged) {
                return true;
              }

              return false;
            },
            builder: (context, state) {
              return Column(
                children: [
                  Row(
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
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding:const EdgeInsets.all(0),
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                          icon: const Icon(Icons.volume_up_rounded)),
                      Expanded(
                        child: MarqueeWidget(
                            child: Text(
                          state.getGrandTotalInWords(),
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryDarkest),
                        )),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
          CheckboxListTile(
            activeColor: AppColors.primaryDarkest,
            value: _addIntoCreditDebit,
            onChanged: (v) {
              setState(() {
                _addIntoCreditDebit = v!;
              });
            },
            title: const Text(
              "Add into Credit Debit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            children: [
              Expanded(child: DatePickerWidget(
                onDateSelected: (DateTime date) {
                  BlocProvider.of<CashCounterCubit>(context)
                      .setTransactionDate(date);
                },
              )),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: TimePickerWidget(
                onTimeSelected: (TimeOfDay time) {
                  BlocProvider.of<CashCounterCubit>(context)
                      .setTransactionTiming(time);
                },
              ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: SecondaryButton(
                      onClick: () {
                        BlocProvider.of<CashCounterCubit>(context)
                            .clearFields();
                      },
                      text: "Clear")),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: PrimaryButton(
                      onClick: () {
                        BlocProvider.of<CashCounterCubit>(context)
                            .addCashTransaction();
                      },
                      text: "Save"))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          PrimaryButton(
              onClick: () {
                Navigator.pushNamed(context, route.cashCounterHistory);
              },
              text: "View History")
        ],
      ),
    );
  }
}
