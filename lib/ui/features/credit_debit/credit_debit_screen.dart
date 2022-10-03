import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/widgets/credit_debit_footer.dart';
import 'package:account_manager/ui/features/credit_debit/widgets/credit_debit_row.dart';
import 'package:account_manager/widgets/list_data_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditDebitScreen extends StatefulWidget {
  const CreditDebitScreen({Key? key}) : super(key: key);

  @override
  State<CreditDebitScreen> createState() => _CreditDebitScreenState();
}

class _CreditDebitScreenState extends State<CreditDebitScreen> {
  @override
  void initState() {
    BlocProvider.of<CreditDebitCubit>(context).fetchPersons();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.creditDebit),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const ListDataHeader(),
                Expanded(
                  child: BlocBuilder<CreditDebitCubit, CreditDebitState>(
                    buildWhen: (_, state) {
                      if (state is LoadingPersons || state is ReceivedPersons)
                        return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state is ReceivedPersons) {
                        BlocProvider.of<CreditDebitCubit>(context).fetchStats();
                        if (state.persons.isNotEmpty) {
                          return ListView.separated(
                            itemCount: state.persons.length,
                            itemBuilder: (context, index) {
                              var person = state.persons[index];
                              return CreditDebitRow(personModel: person);
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
                            children: const [
                              Icon(
                                Icons.person_add,
                                size: 50,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                  "No persons added!! Add person by clicking add person button !!")
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
