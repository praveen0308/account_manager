import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/utils/share_utils.dart';
import 'package:flutter/material.dart';
import 'package:account_manager/route/route.dart' as route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CreditDebitRow extends StatelessWidget {
  final PersonModel personModel;

  const CreditDebitRow({Key? key, required this.personModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, route.cdHistory,
            arguments: personModel);
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
        //
        // });

        BlocProvider.of<CreditDebitCubit>(context).fetchPersons();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryDarkest,
              child: Center(
                child: Text(
                  personModel.name.substring(0, 1),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personModel.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Text(
                  "Cr: +₹${personModel.credit}",
                  style: const TextStyle(
                      color: AppColors.successDark,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Db: -₹${personModel.debit}",
                  style: const TextStyle(
                      color: AppColors.error, fontWeight: FontWeight.w500),
                ),
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(children: [
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(
                            personModel.mobileNumber);
                      },
                      icon: const Icon(Icons.phone)),
                  IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                      constraints: const BoxConstraints(),
                      onPressed: () async {
                        ShareUtil.launchWhatsapp1("Hiii", personModel.mobileNumber);
                      },
                      icon: const Icon(Icons.whatsapp)),
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      onPressed: () async {
                        ShareUtil.launchWhatsapp1(personModel.toString(), personModel.mobileNumber);
                      },
                      icon: const Icon(Icons.share)),
                ],),

                Text("₹${personModel.credit - personModel.debit}",
                    style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
