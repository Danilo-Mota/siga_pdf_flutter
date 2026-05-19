import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'report_pdf.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SigaPdfApp());
}

class SigaPdfApp extends StatelessWidget {
  const SigaPdfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIGA PDF',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F2937),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F4F5),
      ),
      home: const ReportPreviewPage(),
    );
  }
}

class ReportPreviewPage extends StatelessWidget {
  const ReportPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pré-visualização do PDF SIGA'),
      ),
      body: PdfPreview(
        build: (_) => SigaReportPdf.build(ReportData.sample),
        pdfFileName: 'SIGA_pppaaa_20260501_20260519_clone.pdf',
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        maxPageWidth: 720,
      ),
    );
  }
}
