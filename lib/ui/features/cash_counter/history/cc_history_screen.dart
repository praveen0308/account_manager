import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/history/footer.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cc_history_day_item.dart';
import 'package:account_manager/widgets/list_data_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CCHistoryScreen extends StatefulWidget {
  const CCHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CCHistoryScreen> createState() => _CCHistoryScreenState();
}

class _CCHistoryScreenState extends State<CCHistoryScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.cashTransactions),
          ),
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const ListDataHeader(),
                    const SizedBox(height: 16,),
                    Expanded(
                      child: BlocBuilder<CcHistoryCubit, CcHistoryState>(
                        builder: (context, state) {

                          if(state is ReceivedHistory){

                            if(state.data.isNotEmpty){
                              return ListView.separated(

                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  var person = state.data[index];
                                  return CCHistoryDayItem(data: state.data);
                                },
                                separatorBuilder: (BuildContext context,
                                    int index) {
                                  return const Divider(
                                    thickness: 1,
                                  );
                                },
                              );
                            }else{
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.person_add,size: 50,),
                                  SizedBox(height: 16,),
                                  Text("No transactions added!!!")
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
                  bottom: 0, left: 0, right: 0, child: Footer())
            ],
          ),
        ));
  }

  @override
  void initState() {
    BlocProvider.of<CcHistoryCubit>(context).fetchTransactions();
  }
}
