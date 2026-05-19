# siga_pdf_flutter

Aplicativo Flutter que recria o PDF do anexo SIGA usando a biblioteca `pdf`.

## O que tem aqui

- preview web com `PdfPreview` para gerar, imprimir e baixar o arquivo
- composição do PDF em coordenadas fixas para ficar visualmente próxima ao anexo
- fontes `Arimo` embutidas por serem abertas e compatíveis com as métricas do Arial

## Rodando localmente

```bash
flutter pub get
flutter run -d chrome
```

## Arquivos principais

- `lib/main.dart`: tela com preview e ações de exportação
- `lib/report_pdf.dart`: montagem completa do documento PDF

## Fonte usada

As fontes em `assets/fonts/Arimo-*.ttf` vêm do projeto oficial Arimo do Google Fonts e a licença está em `assets/fonts/OFL-Arimo.txt`.
