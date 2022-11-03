
import 'package:account_manager/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:printing/printing.dart';

import 'cd_transaction_report.dart';


class CDReportPreview extends StatelessWidget {
  final List<PersonModel> persons;
  const CDReportPreview({Key? key, required this.persons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Debit Report'),
      ),
      body: PdfPreview(
        build: (context) => makeCDReport(persons),
      ),
    );
  }
}