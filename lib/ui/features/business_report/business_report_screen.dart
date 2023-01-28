import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/ui/features/business_report/business_report_cubit.dart';
import 'package:account_manager/ui/features/business_report/pdf_report/business_pdf_report_preview.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../res/app_colors.dart';
import '../../../utils/income_type.dart';
import '../../../widgets/date_picker_widget.dart';

class BusinessReportScreen extends StatefulWidget {
  const BusinessReportScreen({Key? key}) : super(key: key);

  @override
  State<BusinessReportScreen> createState() => _BusinessReportScreenState();
}

class _BusinessReportScreenState extends State<BusinessReportScreen> {
  final List<String> _wallets = ["Business 1", "Business 2", "Business 3"];
  final List<String> _types = ["All", "Credit", "Debit"];
  var _activeWallet = "Business 1";
  var _activeType = "All";
  DateTime today = DateTime.now();
  late DateTime startDate;
  late DateTime endDate;

  final List<CDTransaction> visibleTransactions = [];

  int getActiveWalletId() {
    if (_activeWallet == "Business 1") {
      return 1;
    }
    if (_activeWallet == "Business 2") {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  void initState() {
    startDate = DateTime(today.year,today.month,today.day);
    endDate = DateTime(startDate.year, startDate.month, startDate.day + 30);
    setState((){});
    BlocProvider.of<BusinessReportCubit>(context)
        .fetchTransactions(getActiveWalletId(), startDate, endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Business Report"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BusinessPdfReportPreview(
                        businessId: getActiveWalletId(),
                        startDate: DateFormat("dd MMM yyyy").format(startDate),
                        endDate: DateFormat("dd MMM yyyy").format(startDate),
                        transactions: visibleTransactions),
                  ),
                );
              },
              icon: const Icon(Icons.picture_as_pdf))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [Text("Start Date"), Text("End Date")],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: DatePickerWidget(
                      onDateSelected: (DateTime date) {
                        startDate = date;
                        BlocProvider.of<BusinessReportCubit>(context)
                            .fetchTransactions(
                                getActiveWalletId(), startDate, endDate);
                      },
                      lastDate: endDate,
                    ),
                  ),
                  Expanded(
                    child: DatePickerWidget(
                      onDateSelected: (DateTime date) {
                        endDate = date;
                        BlocProvider.of<BusinessReportCubit>(context)
                            .fetchTransactions(
                                getActiveWalletId(), startDate, endDate);
                      },
                      initialDate: startDate,
                      firstDate: startDate,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: _wallets
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: _activeWallet,
                        onChanged: (value) {
                          setState(() {
                            _activeWallet = value as String;
                          });
                          BlocProvider.of<BusinessReportCubit>(context)
                              .fetchTransactions(
                                  getActiveWalletId(), startDate, endDate);
                        },
                        buttonHeight: 40,
                        itemHeight: 40,
                        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: AppColors.primaryDarkest, width: 1.5),
                          color: Colors.white,
                        ),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                          child: FittedBox(
                        child: DropdownButton2(
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: _types
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: _activeType,
                          onChanged: (value) {
                            setState(() {
                              _activeType = value as String;
                            });
                            BlocProvider.of<BusinessReportCubit>(context)
                                .filterTransactions(_activeType);
                          },
                          buttonHeight: 40,
                          itemHeight: 40,
                          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: AppColors.primaryDarkest, width: 1.5),
                            color: Colors.white,
                          ),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              BlocConsumer<BusinessReportCubit, BusinessReportState>(
                  builder: (context, state) {
                if (state is ReceivedTransactions) {
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,

                      itemCount: state.transactions.length+1,
                      itemBuilder: (context, index) {
                        var len = state.transactions.length;


                        if(index==len){
                          return const SizedBox(height: 150,);
                        }
                        var transaction = state.transactions[index];
                        return ListTile(
                          onTap: () {},
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          leading: CircleAvatar(
                            child: Text(transaction.personName == null
                                ? "X"
                                : transaction.personName![0]),
                          ),
                          title: Text(transaction.personName ?? "Unknown"),
                          subtitle: Text(transaction.getDate()),
                          trailing: Text(
                            "₹${transaction.getAmount()}",
                            style: TextStyle(
                                color: transaction.type == TransactionType.credit.name
                                    ? AppColors.successDark
                                    : AppColors.error,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {


                        return const Divider(
                          thickness: 0.2,
                          color: Colors.black,
                        );
                      },
                    ),
                  );
                }
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.category_outlined,
                        size: 80,
                      ),
                      Text("Transactions not found!!")
                    ],
                  ),
                );
              }, listener: (context, state) {
                if (state is ReceivedTransactions) {
                  visibleTransactions.clear();
                  visibleTransactions.addAll(state.transactions);
                } else {
                  visibleTransactions.clear();
                }
              }),


            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BlocBuilder<BusinessReportCubit, BusinessReportState>(
              builder: (context, state) {
                return Row(
                  children: [
                    _buildTotalView(
                        BlocProvider.of<BusinessReportCubit>(context).totalDebit,
                        TransactionType.debit),
                    _buildTotalView(
                        BlocProvider.of<BusinessReportCubit>(context).totalCredit,
                        TransactionType.credit),
                  ],
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildTotalView(num amount, TransactionType type) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: type == TransactionType.debit
          ? AppColors.successLightest
          : AppColors.errorLightest,
      child: Center(
        child: Text(
          "₹$amount",
          style: TextStyle(
              fontSize: 22,
              color: type == TransactionType.credit
                  ? AppColors.successDark
                  : AppColors.error,
              fontWeight: FontWeight.w700),
        ),
      ),
    ));
  }
}
