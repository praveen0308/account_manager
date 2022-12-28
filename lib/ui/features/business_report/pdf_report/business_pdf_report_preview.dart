import 'package:account_manager/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../../../models/credit_debit_transaction.dart';
import 'business_pdf_report.dart';


class BusinessPdfReportPreview extends StatelessWidget {
  final int businessId;
  final String startDate;
  final String endDate;
  final List<CDTransaction> transactions;
  const BusinessPdfReportPreview({Key? key, required this.businessId, required this.startDate, required this.endDate, required this.transactions,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Report'),
      ),
      body: PdfPreview(
        build: (context) => makeBusinessPdfReport(businessId,startDate,endDate,transactions),
      ),
    );
  }
}