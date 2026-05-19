import 'package:flutter_test/flutter_test.dart';
import 'package:siga_pdf_flutter/report_pdf.dart';

void main() {
  test('sample data matches the annex content', () {
    expect(ReportData.sample.studentName, 'pppaaa');
    expect(ReportData.sample.summary.communication, 'Comunicou');
    expect(ReportData.sample.detail.heading, contains('Atividade (1)'));
  });

  testWidgets('pdf bytes are generated successfully', (tester) async {
    final bytes = await SigaReportPdf.build(ReportData.sample);

    expect(bytes, isNotEmpty);
    expect(bytes.length, greaterThan(1000));
  });
}
