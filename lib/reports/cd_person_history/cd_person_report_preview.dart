
import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:printing/printing.dart';

import 'cd_person_report.dart';


class CDPersonReportPreview extends StatelessWidget {
  final List<CDTransaction> transactions;
  final PersonModel person;
  const CDPersonReportPreview({Key? key, required this.transactions, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Debit Report'),
      ),
      body: PdfPreview(
        build: (context) => makeCDPersonReport(transactions,person),
      ),
    );
  }
}