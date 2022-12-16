import 'package:account_manager/models/person_model.dart';

import 'package:account_manager/ui/features/credit_debit/edit_transaction/select_person/select_person_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPersonArgs{
  final int walletId;
  final PersonModel person;

  SelectPersonArgs(this.walletId, this.person);

}
class SelectPersonScreen extends StatefulWidget {
  final SelectPersonArgs args;
  const SelectPersonScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<SelectPersonScreen> createState() => _SelectPersonScreenState();
}

class _SelectPersonScreenState extends State<SelectPersonScreen> {


  @override
  void initState() {
    BlocProvider.of<SelectPersonCubit>(context).fetchPersonsByWalletId(widget.args.walletId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text("Select Person"),),
      body: BlocConsumer<SelectPersonCubit,SelectPersonState>(builder: (context,state){
        if(state is LoadingPersons){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(state is ReceivedPersons){
          return ListView.separated(itemBuilder: (context,index){
            var person = state.persons[index];
            return  ListTile(
              onTap: (){
                Navigator.pop(context,person);
              },
              selected: widget.args.person.personId == person.personId,
              leading: CircleAvatar(
                child: Text(person.name[0]),
              ),
              title: Text(person.name),
              trailing: const Icon(Icons.chevron_right),
            );
          }, separatorBuilder: (context,index){
            return const Divider();
          }, itemCount: state.persons.length);
        }
        return const Center(child: Text("No Persons"),);
      }, listener: (context,state){}),
    ));
  }

}
