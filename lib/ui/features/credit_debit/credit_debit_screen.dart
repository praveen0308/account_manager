import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/widgets/credit_debit_footer.dart';
import 'package:account_manager/ui/features/credit_debit/widgets/credit_debit_row.dart';
import 'package:account_manager/widgets/custom_dropdown.dart';
import 'package:account_manager/widgets/list_data_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../models/person_model.dart';
import '../../../reports/credit_debit/cd_transaction_preview.dart';

class CreditDebitScreen extends StatefulWidget {
  const CreditDebitScreen({Key? key}) : super(key: key);

  @override
  State<CreditDebitScreen> createState() => _CreditDebitScreenState();
}

class _CreditDebitScreenState extends State<CreditDebitScreen> {
  List<PersonModel> persons = [];

  @override
  void initState() {
    BlocProvider.of<CreditDebitCubit>(context).fetchPersons();
    super.initState();
  }

  showPopupMenu(BuildContext context, TapDownDetails details) {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy - 180,
        details.globalPosition.dx,
        details.globalPosition.dy - 180,
      ), //position where you want to show the menu on screen
      items: const [
        PopupMenuItem<int>(value: 1, child: Text('A to Z')),
        PopupMenuItem<int>(value: 2, child: Text('Creditor wise')),
        PopupMenuItem<int>(value: 3, child: Text('Debtor wise')),
        // PopupMenuItem<int>(value: 4, child: Text('Time wise')),
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;

      BlocProvider.of<CreditDebitCubit>(context).applyFilter(itemSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ListDataHeader(
                  onFilterClicked: (details) {
                    showPopupMenu(context, details);
                  },
                  onSearched: (String q) {
                    BlocProvider.of<CreditDebitCubit>(context).filterPersons(q);
                  },
                  onPdfClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CDReportPreview(persons: persons),
                      ),
                    );
                  },
                ),

                Expanded(
                  child: BlocBuilder<CreditDebitCubit, CreditDebitState>(
                    buildWhen: (_, state) {
                      if (state is LoadingPersons || state is ReceivedPersons) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is ReceivedPersons) {
                        BlocProvider.of<CreditDebitCubit>(context).fetchStatsByWalletId();
                        if (state.persons.isNotEmpty) {
                          persons.clear();
                          persons.addAll(state.persons);
                          return ListView.separated(
                            itemCount: state.persons.length,
                            itemBuilder: (context, index) {
                              var person = state.persons[index];
                              if(index==persons.length-1){
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 250),
                                  child: CreditDebitRow(personModel: person),
                                );
                              }else{
                                return CreditDebitRow(personModel: person);
                              }

                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                thickness: 1,
                              );
                            },
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              const Icon(
                                Icons.person_add,
                                size: 50,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                  "No persons added!! Add person by clicking add person button !!",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6,)
                            ],
                          );
                        }
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
              bottom: 0, left: 0, right: 0, child: CreditDebitFooter())
        ],
      ),
    ));
  }

}
