import 'package:account_manager/models/currency.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/text_styles.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/settings/cc_settings_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/settings/cc_settings_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CCSettingsDialog extends StatefulWidget {
  const CCSettingsDialog({Key? key}) : super(key: key);

  @override
  State<CCSettingsDialog> createState() => _CCSettingsDialogState();
}

class _CCSettingsDialogState extends State<CCSettingsDialog> {

  List<Currency> currencies = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppColors.white,
      height: 350,
      child: Column(
        children: [
          Text("Note Settings", style: AppTextStyles.headline5(),),
          const SizedBox(height: 16,),
          BlocConsumer<CcSettingsCubit, CcSettingsState>(
            listener: (context, state) {
              if(state is UpdatedSuccessfully){
                showToast("Updated Successfully!!",ToastType.success);
                Navigator.pop(context,true);
                BlocProvider.of<CashCounterCubit>(context).emit(const ClearScreen(0 , 0 , 0));
              }
            },
            builder: (context, state) {

              if (state is Error) {
                return Center(
                  child: Column(
                    children: const [
                      Icon(Icons.error),
                      Text("Something went wrong!!!")
                    ],
                  ),
                );
              }

              if (state is ReceivedNotes) {
                currencies.clear();
                currencies.addAll(state.currencies);
                return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 4),
                    itemBuilder: (_, index) {
                      var currency = currencies[index];
                      return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: currency.isActive,
                          title: Text(currency.item.toString()),
                          onChanged: (v) {
                            BlocProvider
                                .of<CcSettingsCubit>(context)
                                .currencies[index].isActive = v ?? true;
                            currencies[index].isActive = v ?? true;
                            setState(() {});
                          });
                    },
                    itemCount: state.currencies.length);
              }
              return const CircularProgressIndicator();
            },
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(child: SecondaryButton(onClick: () {
                Navigator.pop(context,false);
              }, text: "Cancel")),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: PrimaryButton(
                      onClick: () {
                        BlocProvider.of<CcSettingsCubit>(context)
                            .updateCurrencies();
                      },
                      text: "Save"))
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<CcSettingsCubit>(context).fetchCurrencies();
    super.initState();
  }
}
