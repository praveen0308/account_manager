import 'dart:typed_data';
import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/day_transaction_model.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/res/app_images.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';

Future<Uint8List> makeCDReport(List<PersonModel> persons) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load(AppImages.appIcon)).buffer.asUint8List());
  double totalBalance = persons
      .map((person) => person.credit - person.debit)
      .fold(0, (prev, amount) => prev + amount);
  final font = await PdfGoogleFonts.robotoBold();
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Cash Debit Report", style: Theme.of(context).header0),
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
                      'Name',
                      style: Theme.of(context).tableHeader,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Mobile Number',
                      style: Theme.of(context).tableHeader,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Credit',
                      style: Theme.of(context).tableHeader,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Debit',
                      style: Theme.of(context).tableHeader,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Balance',
                      style: Theme.of(context).tableHeader,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                ...persons.map(
                  (e) => TableRow(
                    children: [
                      PaddedText(e.name),
                      PaddedText(e.mobileNumber),
                      PaddedText("${e.credit}"),
                      PaddedText("${e.debit}"),
                      PaddedText("${e.credit - e.debit}"),
                    ],
                  ),
                ),
                TableRow(
                  children: [
                    Container(),
                    Container(),
                    Container(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text('Total Balance',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center)),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('₹${totalBalance.toStringAsFixed(2)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                font: font, fontWeight: FontWeight.bold)))
                  ],
                )
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Expanded(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    ));
