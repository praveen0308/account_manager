import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/day_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:printing/printing.dart';

import 'cash_transaction_report.dart';


class PdfPreviewPage extends StatelessWidget {
  final List<CashTransactionModel> transactions;
  const PdfPreviewPage({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cash Counter Report'),
      ),
      body: PdfPreview(
        build: (context1) => makePdf(transactions),
      ),
    );
  }
}