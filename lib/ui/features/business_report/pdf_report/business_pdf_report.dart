import 'dart:typed_data';
import 'package:account_manager/res/app_images.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';

import '../../../../models/credit_debit_transaction.dart';

Future<Uint8List> makeBusinessPdfReport(int businessID,String startDate,String endDate,List<CDTransaction> transactions) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load(AppImages.appIcon)).buffer.asUint8List());

  final font = await PdfGoogleFonts.robotoBold();

  double totalBalance = transactions.last.closingBalance;

  final List<Widget> widgets = [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text("Business $businessID Report", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            Text("from $startDate to $endDate", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: Image(imageLogo),
        )
      ],
    ),
    Container(height: 50),
    Table(
      border: TableBorder.all(color: PdfColors.black),
      children: [
        TableRow(
          children: [
            Text(
              'ID',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Name',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Credit',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Debit',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Balance',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Text(
              'Added On',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),

          ],
        ),
        ...transactions.map(
              (e) => TableRow(
            children: [
              PaddedText(e.transactionId.toString()),
              PaddedText(e.personName.toString()),
              PaddedText("${e.credit}"),
              PaddedText("${e.debit}"),
              PaddedText("${e.closingBalance}"),
              PaddedText(e.getDate()),

            ],
          ),
        ),
        TableRow(
          children: [
            Container(),
            Container(),
            Container(),
            Container(),

            Text(totalBalance<0?"Due":"Advance",
              style: TextStyle(fontWeight: FontWeight.bold,color: totalBalance<0?PdfColors.red:PdfColors.green),
              textAlign: TextAlign.center,),
            Text('₹${totalBalance.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    font: font, fontWeight: FontWeight.bold,color: totalBalance<0?PdfColors.red:PdfColors.green))
          ],
        )
      ],
    ),
  ];

  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => widgets,//here goes the widgets list
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.center,
}) =>
    Expanded(
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(fontSize: 12)
        ));
