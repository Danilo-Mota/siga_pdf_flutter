import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportData {
  const ReportData({
    required this.studentName,
    required this.birthDate,
    required this.institution,
    required this.yearAndClass,
    required this.diagnosis,
    required this.period,
    required this.summary,
    required this.detail,
    required this.appendixTitle,
    required this.appendixSubtitle,
    required this.appendixLines,
  });

  final String studentName;
  final String birthDate;
  final String institution;
  final String yearAndClass;
  final String diagnosis;
  final String period;
  final SummaryRow summary;
  final DetailRecord detail;
  final String appendixTitle;
  final String appendixSubtitle;
  final List<String> appendixLines;

  static const sample = ReportData(
    studentName: 'pppaaa',
    birthDate: '21/01/2016',
    institution: 'aa',
    yearAndClass: 'rere',
    diagnosis: 'Deficiência Auditiva',
    period: '01/05/2026 — 19/05/2026',
    summary: SummaryRow(
      date: '19/05/2026',
      number: '1',
      mediation: '—',
      participation: 'Não',
      communication: 'Comunicou',
      focusMinutes: '43',
      evidences: '---',
    ),
    detail: DetailRecord(
      heading: '19/05/2026 — Atividade (1) — 00:04',
      description: 'walace',
      mediation: '—',
      participation: 'Não',
      communication: 'Comunicou',
      focusMinutes: '43',
      strategies: 'tudao',
      learningResults: 'fps',
    ),
    appendixTitle: 'Apêndice',
    appendixSubtitle: 'Evidências',
    appendixLines: [
      'Nenhuma evidência encontrada no período selecionado.',
      'As imagens anexadas podem ser observadas nos registros correspondentes e são listadas neste apêndice\npara rastreabilidade.',
    ],
  );
}

class SummaryRow {
  const SummaryRow({
    required this.date,
    required this.number,
    required this.mediation,
    required this.participation,
    required this.communication,
    required this.focusMinutes,
    required this.evidences,
  });

  final String date;
  final String number;
  final String mediation;
  final String participation;
  final String communication;
  final String focusMinutes;
  final String evidences;
}

class DetailRecord {
  const DetailRecord({
    required this.heading,
    required this.description,
    required this.mediation,
    required this.participation,
    required this.communication,
    required this.focusMinutes,
    required this.strategies,
    required this.learningResults,
  });

  final String heading;
  final String description;
  final String mediation;
  final String participation;
  final String communication;
  final String focusMinutes;
  final String strategies;
  final String learningResults;
}

class SigaReportPdf {
  static const pageFormat = PdfPageFormat(596, 842);

  static Future<Uint8List> build(ReportData data) async {
    final fonts = await _PdfFonts.load();
    final styles = _ReportStyles(fonts);
    final document = pw.Document();

    document.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: pageFormat,
          margin: pw.EdgeInsets.zero,
          theme: pw.ThemeData.withFont(
            base: fonts.regular,
            bold: fonts.bold,
            italic: fonts.italic,
            boldItalic: fonts.bold,
          ),
        ),
        build: (_) => pw.Stack(
          children: [
            pw.Positioned.fill(child: pw.Container(color: PdfColors.white)),
            ..._tableBackgrounds(),
            ..._sectionLines(),
            ..._tableGridLines(),
            _title(styles),
            _studentSection(data, styles),
            _activitiesSection(data, styles),
            _detailsSection(data, styles),
            _appendixSection(data, styles),
          ],
        ),
      ),
    );

    return document.save();
  }

  static pw.Widget _title(_ReportStyles styles) {
    return _textBox(
      left: 60,
      top: 60.65,
      width: 475,
      text: 'Relatório de Acompanhamento',
      style: styles.title,
      textAlign: pw.TextAlign.center,
    );
  }

  static pw.Widget _studentSection(ReportData data, _ReportStyles styles) {
    return pw.Stack(
      children: [
        _textBox(
          left: 60,
          top: 130.38,
          width: 250,
          text: 'Identificação do Estudante',
          style: styles.sectionTitle,
        ),
        _cellText(
          left: 54.75,
          top: 158.48,
          width: 87,
          height: 37.5,
          text: 'Estudante',
          style: styles.bold10,
        ),
        _cellText(
          left: 141.75,
          top: 158.48,
          width: 150,
          height: 37.5,
          text: data.studentName,
          style: styles.regular10,
        ),
        _cellMultilineText(
          left: 291.75,
          top: 158.48,
          width: 87,
          height: 37.5,
          lines: const ['Data de', 'Nascimento'],
          style: styles.bold10,
        ),
        _cellText(
          left: 378.75,
          top: 158.48,
          width: 150,
          height: 37.5,
          text: data.birthDate,
          style: styles.regular10,
        ),
        _cellText(
          left: 54.75,
          top: 195.98,
          width: 87,
          height: 24.75,
          text: 'Instituição',
          style: styles.bold10,
        ),
        _cellText(
          left: 141.75,
          top: 195.98,
          width: 150,
          height: 24.75,
          text: data.institution,
          style: styles.regular10,
        ),
        _cellText(
          left: 291.75,
          top: 195.98,
          width: 87,
          height: 24.75,
          text: 'Ano e Turma',
          style: styles.bold10,
        ),
        _cellText(
          left: 378.75,
          top: 195.98,
          width: 150,
          height: 24.75,
          text: data.yearAndClass,
          style: styles.regular10,
        ),
        _cellText(
          left: 54.75,
          top: 220.73,
          width: 87,
          height: 24.75,
          text: 'Diagnóstico',
          style: styles.bold10,
        ),
        _cellText(
          left: 141.75,
          top: 220.73,
          width: 150,
          height: 24.75,
          text: data.diagnosis,
          style: styles.regular10,
        ),
        _cellText(
          left: 291.75,
          top: 220.73,
          width: 87,
          height: 24.75,
          text: 'Período',
          style: styles.bold10,
        ),
        _cellText(
          left: 378.75,
          top: 220.73,
          width: 150,
          height: 24.75,
          text: data.period,
          style: styles.regular10,
        ),
      ],
    );
  }

  static pw.Widget _activitiesSection(ReportData data, _ReportStyles styles) {
    return pw.Stack(
      children: [
        _textBox(
          left: 60,
          top: 283.8,
          width: 200,
          text: 'Atividades',
          style: styles.sectionTitle,
        ),
        _textBox(
          left: 60,
          top: 320.32,
          width: 180,
          text: 'Tabela Resumida',
          style: styles.subsectionTitle,
        ),
        _cellCenteredText(
          left: 54.75,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          text: 'Data',
          style: styles.bold10,
        ),
        _cellCenteredText(
          left: 126,
          top: 344.09,
          width: 54.75,
          height: 37.5,
          text: 'Nº',
          style: styles.bold10,
        ),
        _cellCenteredText(
          left: 180.75,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          text: 'Mediação',
          style: styles.bold10,
        ),
        _cellCenteredText(
          left: 252,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          text: 'Participação',
          style: styles.bold10,
        ),
        _cellCenteredMultilineText(
          left: 323.25,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          lines: const ['Comunicaçã', 'o'],
          style: styles.bold10,
        ),
        _cellCenteredMultilineText(
          left: 394.5,
          top: 344.09,
          width: 54.75,
          height: 37.5,
          lines: const ['Foco', '(min)'],
          style: styles.bold10,
        ),
        _cellCenteredText(
          left: 449.25,
          top: 344.09,
          width: 82.5,
          height: 37.5,
          text: 'Evidências',
          style: styles.bold10,
        ),
        _cellText(
          left: 54.75,
          top: 381.59,
          width: 71.25,
          height: 25,
          text: data.summary.date,
          style: styles.regular10,
        ),
        _cellCenteredText(
          left: 126,
          top: 381.59,
          width: 54.75,
          height: 25,
          text: data.summary.number,
          style: styles.bold10,
        ),
        _cellText(
          left: 180.75,
          top: 381.59,
          width: 71.25,
          height: 25,
          text: data.summary.mediation,
          style: styles.regular10,
        ),
        _cellText(
          left: 252,
          top: 381.59,
          width: 71.25,
          height: 25,
          text: data.summary.participation,
          style: styles.regular10,
        ),
        _cellText(
          left: 323.25,
          top: 381.59,
          width: 71.25,
          height: 25,
          text: data.summary.communication,
          style: styles.regular10,
        ),
        _cellCenteredText(
          left: 394.5,
          top: 381.59,
          width: 54.75,
          height: 25,
          text: data.summary.focusMinutes,
          style: styles.regular10,
        ),
        _cellText(
          left: 449.25,
          top: 381.59,
          width: 82.5,
          height: 25,
          text: data.summary.evidences,
          style: styles.regular10,
        ),
      ],
    );
  }

  static pw.Widget _detailsSection(ReportData data, _ReportStyles styles) {
    return pw.Stack(
      children: [
        _textBox(
          left: 60,
          top: 438.88,
          width: 220,
          text: 'Detalhes por Registro',
          style: styles.subsectionTitle,
        ),
        _textBox(
          left: 60,
          top: 463,
          width: 476,
          text: data.detail.heading,
          style: styles.bold11,
        ),
        _richLine(
          left: 60,
          top: 481.53,
          width: 320,
          spans: [
            _span('Descrição: ', styles.bold105),
            _span(data.detail.description, styles.regular105),
          ],
        ),
        _richLine(
          left: 60,
          top: 499.42,
          width: 220,
          spans: [
            _span('Mediação: ', styles.bold105),
            _span(data.detail.mediation, styles.regular105),
          ],
        ),
        _richLine(
          left: 60,
          top: 517.3,
          width: 260,
          spans: [
            _span('Participação: ', styles.bold105),
            _span(data.detail.participation, styles.regular105),
          ],
        ),
        _richLine(
          left: 60,
          top: 535.19,
          width: 320,
          spans: [
            _span('Comunicação: ', styles.bold105),
            _span(data.detail.communication, styles.regular105),
          ],
        ),
        _richLine(
          left: 60,
          top: 553.07,
          width: 220,
          spans: [
            _span('Foco (min): ', styles.bold105),
            _span(data.detail.focusMinutes, styles.regular105),
          ],
        ),
        _richLine(
          left: 60,
          top: 570.96,
          width: 420,
          spans: [
            _span('Estratégias pedagógicas: ', styles.bold105),
            _span(data.detail.strategies, styles.regular105),
          ],
        ),
        _richLine(
          left: 60,
          top: 588.84,
          width: 420,
          spans: [
            _span('Resultados e aprendizagem: ', styles.bold105),
            _span(data.detail.learningResults, styles.regular105),
          ],
        ),
      ],
    );
  }

  static pw.Widget _appendixSection(ReportData data, _ReportStyles styles) {
    return pw.Stack(
      children: [
        _textBox(
          left: 60,
          top: 659.01,
          width: 150,
          text: data.appendixTitle,
          style: styles.sectionTitle,
        ),
        _textBox(
          left: 60,
          top: 695.53,
          width: 120,
          text: data.appendixSubtitle,
          style: styles.subsectionTitle,
        ),
        _textBox(
          left: 60,
          top: 719.62,
          width: 253.5,
          text: data.appendixLines[0],
          style: styles.italic10,
        ),
        _textBox(
          left: 60,
          top: 738.85,
          width: 478,
          text: data.appendixLines[1],
          style: styles.italic10,
        ),
      ],
    );
  }

  static List<pw.Widget> _tableBackgrounds() {
    return [
      _fillRect(
          left: 54.75,
          top: 158.48,
          width: 87,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 291.75,
          top: 158.48,
          width: 87,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 54.75,
          top: 195.98,
          width: 87,
          height: 24.75,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 291.75,
          top: 195.98,
          width: 87,
          height: 24.75,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 54.75,
          top: 220.73,
          width: 87,
          height: 24.75,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 291.75,
          top: 220.73,
          width: 87,
          height: 24.75,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 54.75,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 126,
          top: 344.09,
          width: 54.75,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 180.75,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 252,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 323.25,
          top: 344.09,
          width: 71.25,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 394.5,
          top: 344.09,
          width: 54.75,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 449.25,
          top: 344.09,
          width: 82.5,
          height: 37.5,
          color: _ReportStyles.headerFill),
      _fillRect(
          left: 60,
          top: 463,
          width: 476,
          height: 18,
          color: _ReportStyles.detailFill),
    ];
  }

  static List<pw.Widget> _sectionLines() {
    return [
      _fillRect(
          left: 60,
          top: 150.5,
          width: 475,
          height: 1,
          color: _ReportStyles.ruleColor),
      _fillRect(
          left: 60,
          top: 303.5,
          width: 475,
          height: 1,
          color: _ReportStyles.ruleColor),
      _fillRect(
          left: 60,
          top: 678.5,
          width: 475,
          height: 1,
          color: _ReportStyles.ruleColor),
    ];
  }

  static List<pw.Widget> _tableGridLines() {
    return [
      _fillRect(
          left: 54.5,
          top: 158,
          width: 1,
          height: 87,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 141.5,
          top: 158,
          width: 1,
          height: 87,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 291.5,
          top: 158,
          width: 1,
          height: 87,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 378.5,
          top: 158,
          width: 1,
          height: 87,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 528.5,
          top: 158,
          width: 1,
          height: 87,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54,
          top: 158.5,
          width: 475,
          height: 1,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54,
          top: 196.5,
          width: 475,
          height: 1,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54,
          top: 220.5,
          width: 475,
          height: 1,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54,
          top: 245.5,
          width: 475,
          height: 1,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 126.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 180.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 252.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 323.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 394.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 449.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 531.5,
          top: 344,
          width: 1,
          height: 63,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54,
          top: 344.5,
          width: 478,
          height: 1,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54,
          top: 381.5,
          width: 478,
          height: 1,
          color: _ReportStyles.gridColor),
      _fillRect(
          left: 54,
          top: 406.5,
          width: 478,
          height: 1,
          color: _ReportStyles.gridColor),
    ];
  }
}

class _PdfFonts {
  const _PdfFonts({
    required this.regular,
    required this.bold,
    required this.italic,
  });

  final pw.Font regular;
  final pw.Font bold;
  final pw.Font italic;

  static Future<_PdfFonts> load() async {
    final regularData = await rootBundle.load('assets/fonts/Arial.ttf');
    final boldData = await rootBundle.load('assets/fonts/Arial-Bold.ttf');
    final italicData = await rootBundle.load('assets/fonts/Arial-Italic.ttf');

    return _PdfFonts(
      regular: pw.Font.ttf(regularData),
      bold: pw.Font.ttf(boldData),
      italic: pw.Font.ttf(italicData),
    );
  }
}

class _ReportStyles {
  _ReportStyles(_PdfFonts fonts)
      : title = pw.TextStyle(font: fonts.bold, fontSize: 20),
        sectionTitle = pw.TextStyle(font: fonts.bold, fontSize: 15),
        subsectionTitle = pw.TextStyle(font: fonts.bold, fontSize: 13),
        bold11 = pw.TextStyle(font: fonts.bold, fontSize: 11),
        bold105 = pw.TextStyle(font: fonts.bold, fontSize: 10.5),
        bold10 = pw.TextStyle(font: fonts.bold, fontSize: 10),
        regular105 = pw.TextStyle(font: fonts.regular, fontSize: 10.5),
        regular10 = pw.TextStyle(font: fonts.regular, fontSize: 10),
        italic10 = pw.TextStyle(font: fonts.italic, fontSize: 10);

  static final headerFill = PdfColor.fromInt(0xFFE6E6E6);
  static final detailFill = PdfColor.fromInt(0xFFE5E5E5);
  static final ruleColor = PdfColor.fromInt(0xFF808080);
  static final gridColor = PdfColor.fromInt(0xFFA6A6A6);

  final pw.TextStyle title;
  final pw.TextStyle sectionTitle;
  final pw.TextStyle subsectionTitle;
  final pw.TextStyle bold11;
  final pw.TextStyle bold105;
  final pw.TextStyle bold10;
  final pw.TextStyle regular105;
  final pw.TextStyle regular10;
  final pw.TextStyle italic10;
}

pw.Widget _fillRect({
  required double left,
  required double top,
  required double width,
  required double height,
  required PdfColor color,
}) {
  return pw.Positioned(
    left: left,
    top: top,
    child: pw.Container(
      width: width,
      height: height,
      color: color,
    ),
  );
}

pw.Widget _textBox({
  required double left,
  required double top,
  required double width,
  required String text,
  required pw.TextStyle style,
  pw.TextAlign textAlign = pw.TextAlign.left,
}) {
  return pw.Positioned(
    left: left,
    top: top,
    child: pw.SizedBox(
      width: width,
      child: pw.Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    ),
  );
}

pw.Widget _cellText({
  required double left,
  required double top,
  required double width,
  required double height,
  required String text,
  required pw.TextStyle style,
}) {
  return pw.Positioned(
    left: left,
    top: top,
    child: pw.Container(
      width: width,
      height: height,
      padding: const pw.EdgeInsets.only(left: 10.5, right: 8),
      alignment: pw.Alignment.centerLeft,
      child: pw.Text(text, style: style),
    ),
  );
}

pw.Widget _cellCenteredText({
  required double left,
  required double top,
  required double width,
  required double height,
  required String text,
  required pw.TextStyle style,
}) {
  return pw.Positioned(
    left: left,
    top: top,
    child: pw.Container(
      width: width,
      height: height,
      alignment: pw.Alignment.center,
      child: pw.Text(text, style: style, textAlign: pw.TextAlign.center),
    ),
  );
}

pw.Widget _cellMultilineText({
  required double left,
  required double top,
  required double width,
  required double height,
  required List<String> lines,
  required pw.TextStyle style,
}) {
  return pw.Positioned(
    left: left,
    top: top,
    child: pw.Container(
      width: width,
      height: height,
      padding:
          const pw.EdgeInsets.only(left: 10.5, right: 8, top: 6, bottom: 4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          for (final line in lines) pw.Text(line, style: style),
        ],
      ),
    ),
  );
}

pw.Widget _cellCenteredMultilineText({
  required double left,
  required double top,
  required double width,
  required double height,
  required List<String> lines,
  required pw.TextStyle style,
}) {
  return pw.Positioned(
    left: left,
    top: top,
    child: pw.Container(
      width: width,
      height: height,
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          for (final line in lines)
            pw.Text(line, style: style, textAlign: pw.TextAlign.center),
        ],
      ),
    ),
  );
}

pw.Widget _richLine({
  required double left,
  required double top,
  required double width,
  required List<pw.InlineSpan> spans,
}) {
  return pw.Positioned(
    left: left,
    top: top,
    child: pw.SizedBox(
      width: width,
      child: pw.RichText(
        text: pw.TextSpan(children: spans),
      ),
    ),
  );
}

pw.TextSpan _span(String text, pw.TextStyle style) {
  return pw.TextSpan(text: text, style: style);
}
