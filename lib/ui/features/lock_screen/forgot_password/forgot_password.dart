import 'package:account_manager/local/secure_storage.dart';
import 'package:flutter/material.dart';

import '../../../../models/pair.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final List<Pair<String,String>> questions = [];
  int activeQ = 1;
  final SecureStorage _storage = SecureStorage();
  @override
  void initState() {
    _storage.getQuestion(activeQ);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
