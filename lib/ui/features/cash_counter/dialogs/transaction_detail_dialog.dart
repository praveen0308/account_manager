import 'package:flutter/material.dart';

class TransactionDetailDialog extends StatelessWidget {
  final String data;
  const TransactionDetailDialog({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(data,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),));
  }
}
