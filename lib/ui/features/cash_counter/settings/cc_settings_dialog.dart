import 'package:account_manager/ui/features/cash_counter/settings/cc_settings_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/settings/cc_settings_cubit.dart';
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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CcSettingsCubit, CcSettingsState>(
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
            if (state is ReceivedCurrencies) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (_, index) {
                    return CheckboxListTile(value: state.currencies[index].isActive, onChanged: (v) {});
                  },
                  itemCount: state.currencies.length);
            }
            return const CircularProgressIndicator();
          },
        ),
        Row(children: [
          SecondaryButton(onClick: () {}, text: "Cancel"),
          PrimaryButton(onClick: () {}, text: "Save")
        ],)
      ],
    );
  }

  @override
  void initState() {
    BlocProvider.of<CcSettingsCubit>(context).fetchCurrencies();
  }
}
