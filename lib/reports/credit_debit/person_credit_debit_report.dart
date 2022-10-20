import 'dart:io';
import 'dart:ui';

import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';
class PersonCreditDebitReport {
  final CreditDebitRepository _creditDebitRepository;

  PersonCreditDebitReport(this._creditDebitRepository);

  Future<bool> generateReport() async {
    throw UnimplementedError();
    try {
      // Create a new PDF document.
      final PdfDocument document = PdfDocument();
// Add a PDF page and draw text.
      document.pages.add().graphics.drawString(
          'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: const Rect.fromLTWH(0, 0, 150, 20));
// Save the document.
      File('HelloWorld.pdf').writeAsBytes(await document.save());
// Dispose the document.
      document.dispose();
      // await saveAndLaunchFile(bytes, 'Invoice.pdf');
    } catch (e) {
      return false;
    }

    return true;
  }
}
