import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'auth_fetch_controller.dart';
import 'bookingdt_fetch_controller.dart';
import 'payment_controller.dart';

Future<void> generateAndDownloadInvoice({
  required String serviceName,
  required String providerName,
  required String price,
  required String duration,
}) async {
  final pdf = pw.Document();

  final UserService userService = Get.put(UserService());
  final PaymentController paymentController = Get.put(PaymentController());
  final BookingDateTime bookingDateTime = Get.put(BookingDateTime());

  final userName = userService.userData['name'].toString();
  final amountReceivedCents = paymentController.paymentIntent!['amount_received'];
  final paymentId = paymentController.paymentIntent!['id'].toString();

  final amountReceived = amountReceivedCents / 100;
  final doublePrice = double.tryParse(price) ?? 0;
  final dueBalance = doublePrice - amountReceived;

  final startTime = bookingDateTime.bookingSlots.length == 1
      ? bookingDateTime.bookingSlots[0]['start'].toString()
      : bookingDateTime.bookingSlots.last['start'].toString();

  final endTime = bookingDateTime.bookingSlots.length == 1
      ? bookingDateTime.bookingSlots[0]['end'].toString()
      : bookingDateTime.bookingSlots.last['end'].toString();

  // Add content to PDF
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Service Invoice', style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Divider(),

            pw.SizedBox(height: 20),
            pw.Text('Customer Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text('Customer Name: $userName'),
            pw.SizedBox(height: 16),

            pw.Text('Service Details', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Bullet(text: 'Service Name: $serviceName'),
            pw.Bullet(text: 'Provider Name: $providerName'),
            pw.Bullet(text: 'Duration: $duration minutes'),
            pw.Bullet(text: 'Start Time: $startTime'),
            pw.Bullet(text: 'End Time: $endTime'),
            pw.SizedBox(height: 16),

            pw.Text('Payment Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Bullet(text: 'Price: \$${doublePrice.toStringAsFixed(2)}'),
            pw.Bullet(text: 'Amount Received: \$${amountReceived.toStringAsFixed(2)}'),
            pw.Bullet(text: 'Due Balance: \$${dueBalance.toStringAsFixed(2)}'),
            pw.Bullet(text: 'Payment ID: $paymentId'),

            pw.SizedBox(height: 40),
            pw.Divider(),
            pw.Center(
              child: pw.Text('Thank you for choosing our service!', style: pw.TextStyle(fontSize: 14)),
            ),
          ],
        );
      },
    ),
  );

  // === Preview Option ===
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
    name: '${serviceName}_invoice.pdf',
  );

  // === Save to Device (Cross-platform)
  Directory? outputDir;

  if (Platform.isAndroid) {
    final permissionStatus = await Permission.storage.request();
    if (!permissionStatus.isGranted) {
      Get.snackbar(
        'Permission Denied',
        'Storage permission is required to save the invoice.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    outputDir = await getExternalStorageDirectory();
  } else if (Platform.isIOS) {
    outputDir = await getApplicationDocumentsDirectory();
  }

  final filePath = '${outputDir!.path}/${serviceName}_invoice.pdf';
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  Get.snackbar(
    'Download Complete',
    'Invoice saved to: $filePath',
    snackPosition: SnackPosition.BOTTOM,
  );
}
