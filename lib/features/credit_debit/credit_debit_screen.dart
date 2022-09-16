import 'package:account_manager/res/app_strings.dart';
import 'package:flutter/material.dart';

class CreditDebitScreen extends StatefulWidget {
  const CreditDebitScreen({Key? key}) : super(key: key);

  @override
  State<CreditDebitScreen> createState() => _CreditDebitScreenState();
}

class _CreditDebitScreenState extends State<CreditDebitScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.creditDebit),
      ),
      body: Container(),
    ));
  }
}
