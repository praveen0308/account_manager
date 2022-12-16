import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/cash_counter/cash_calculator_view/cash_counting_row.dart';
import 'package:account_manager/ui/features/cash_counter/edit_cash_transaction/edit_cash_transaction_cubit.dart';
import 'package:account_manager/utils/extension_methods.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/footer_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

import '../../../../models/currency.dart';
import '../../../../utils/util_methods.dart';
import '../../../../widgets/container_light.dart';
import '../../../../widgets/date_picker_widget.dart';
import '../../../../widgets/marquee_widget.dart';
import '../../../../widgets/outlined_text_field.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/time_picker_widget.dart';

class EditCashTransactionScreen extends StatefulWidget {
  final CashTransactionModel transaction;

  const EditCashTransactionScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<EditCashTransactionScreen> createState() =>
      _EditCashTransactionScreenState();
}

class _EditCashTransactionScreenState extends State<EditCashTransactionScreen> {
  int transactionId = 0;


  List<Currency> currencies = [];
  final TextEditingController _manuallyAddedController =
      TextEditingController();
  final TextEditingController _manuallySubtractedController =
      TextEditingController();
  final TextEditingController _nameTxtController = TextEditingController();
  final TextEditingController _remarkTxtController = TextEditingController();

  @override
  void initState() {
    transactionId = widget.transaction.transactionID ?? 0;
    var map = widget.transaction.getDescriptionMap();
    populateCurrencies();
    currencies.forEach((element) {
      element.qty = map[element.item] ?? 0;
    });

    widget.transaction.getDescriptionMap().forEach((key, value) {
      BlocProvider.of<EditCashTransactionCubit>(context).noteMaps[key] = value;
    });

    BlocProvider.of<EditCashTransactionCubit>(context).noOfNotes = widget.transaction.noOfNotes;
    BlocProvider.of<EditCashTransactionCubit>(context).denominationTotal = widget.transaction.denominationTotal;
    BlocProvider.of<EditCashTransactionCubit>(context).grandTotal = widget.transaction.grandTotal;
    BlocProvider.of<EditCashTransactionCubit>(context).manuallyAdded = widget.transaction.manuallyAdded??0;
    BlocProvider.of<EditCashTransactionCubit>(context).manuallySubtracted = widget.transaction.manuallySubtracted??0;
    BlocProvider.of<EditCashTransactionCubit>(context).personName = widget.transaction.name??"";
    BlocProvider.of<EditCashTransactionCubit>(context).remark = widget.transaction.remark??"";


    _manuallyAddedController.text =
        (widget.transaction.manuallyAdded as num).toString();
    _manuallySubtractedController.text =
        (widget.transaction.manuallySubtracted as num).toString();
    _nameTxtController.text = widget.transaction.name.toString();
    _remarkTxtController.text = widget.transaction.remark.toString();
    super.initState();
  }

  void populateCurrencies() {
    currencies.clear();
    currencies.add(Currency(item: 2000, qty: 0));
    currencies.add(Currency(item: 500, qty: 0));
    currencies.add(Currency(item: 200, qty: 0));
    currencies.add(Currency(item: 100, qty: 0));
    currencies.add(Currency(item: 50, qty: 0));
    currencies.add(Currency(item: 20, qty: 0));
    currencies.add(Currency(item: 10, qty: 0));
    currencies.add(Currency(item: 5, qty: 0));
    currencies.add(Currency(item: 2, qty: 0));
    currencies.add(Currency(item: 1, qty: 0));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaction"),
      ),
      body: Stack(
        children: [
          BlocListener<EditCashTransactionCubit, EditCashTransactionState>(
  listener: (context, state) {
    if(state is UpdatedSuccessfully){
      showToast("Updated successfully!!!",ToastType.success);
      Navigator.pop(context,true);
    }
  },
  child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var currency = currencies[index];
                        return CashCountingRow(
                            item: currency.item,
                            qty: currency.qty!,
                            onQtyChanged: (item, qty) {
                              BlocProvider.of<EditCashTransactionCubit>(context)
                                  .updateNoteQty(item, qty);
                              currencies.forEach((element) {
                                if (element.item == item) {
                                  element.qty = qty;
                                }
                              });
                            });
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 0.5,
                        );
                      },
                      itemCount: currencies.length),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.primaryDarkest,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedTextField(
                        margin: const EdgeInsets.all(0),
                        controller: _manuallyAddedController,
                        inputType: TextInputType.number,
                        maxLength: 7,
                        hintText: "Added(+)",
                        onSubmitted: (String txt) {
                          BlocProvider.of<EditCashTransactionCubit>(context)
                              .updateManuallyAddedAmt(txt);
                        },
                        onTextChanged: (String txt) {
                          BlocProvider.of<EditCashTransactionCubit>(context)
                              .updateManuallyAddedAmt(txt);
                        },
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: OutlinedTextField(
                        margin: const EdgeInsets.all(0),
                        controller: _manuallySubtractedController,
                        inputType: TextInputType.number,
                        maxLength: 7,
                        hintText: "Subtracted(-)",
                        onSubmitted: (String txt) {
                          BlocProvider.of<EditCashTransactionCubit>(context)
                              .updateManuallySubtractedAmt(txt);
                        },
                        onTextChanged: (String txt) {
                          BlocProvider.of<EditCashTransactionCubit>(context)
                              .updateManuallySubtractedAmt(txt);
                        },
                      )),
                    ],
                  ),
                  OutlinedTextField(
                    controller: _nameTxtController,
                    inputType: TextInputType.text,
                    maxLength: 50,
                    onSubmitted: (String txt) {
                      BlocProvider.of<EditCashTransactionCubit>(context)
                          .personName = txt;
                    },
                    onTextChanged: (String txt) {
                      BlocProvider.of<EditCashTransactionCubit>(context)
                          .personName = txt;
                    },
                    hintText: "Person Name",
                  ),
                  OutlinedTextField(
                    controller: _remarkTxtController,
                    inputType: TextInputType.text,
                    maxLength: 200,
                    onSubmitted: (String txt) {
                      BlocProvider.of<EditCashTransactionCubit>(context)
                          .remark = txt;
                    },
                    onTextChanged: (String txt) {
                      BlocProvider.of<EditCashTransactionCubit>(context)
                          .remark = txt;
                    },
                    hintText: "Remark",
                  ),
                  Container(
                    height: 500,
                  )
                ],
              ),
            ),
          ),
),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:
                BlocBuilder<EditCashTransactionCubit, EditCashTransactionState>(
              builder: (context, state) {
                return FooterContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
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
                                BlocProvider.of<EditCashTransactionCubit>(
                                        context)
                                    .noOfNotes
                                    .toString(),
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
                              FittedBox(
                                child: Text(
                                  BlocProvider.of<EditCashTransactionCubit>(
                                          context)
                                      .grandTotal
                                      .toString(),
                                  style: const TextStyle(
                                      color: AppColors.primaryDarkest,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ],
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        IconButton(
                            padding: const EdgeInsets.all(0),
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: const Icon(Icons.volume_up_rounded)),
                        Expanded(
                          child: MarqueeWidget(
                              child: Text(
                            UtilMethods.convertIntoWords(
                                BlocProvider.of<EditCashTransactionCubit>(
                                        context)
                                    .grandTotal),
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDarkest),
                          )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(child: DatePickerWidget(
                          onDateSelected: (DateTime date) {
                            BlocProvider.of<EditCashTransactionCubit>(context)
                                .setTransactionDate(date);
                          },
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(child: TimePickerWidget(
                          onTimeSelected: (TimeOfDay time) {
                            BlocProvider.of<EditCashTransactionCubit>(context)
                                .setTransactionTiming(time);
                          },
                        ))
                      ],
                    ),
                    if (state is Updating)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state is! Updating)
                      PrimaryButton(
                          onClick: () {
                            BlocProvider.of<EditCashTransactionCubit>(context)
                                .updateCashTransaction(transactionId);
                          },
                          text: "Update"),
                  ],
                ));
              },
            ),
          )
        ],
      ),
    ));
  }
}
