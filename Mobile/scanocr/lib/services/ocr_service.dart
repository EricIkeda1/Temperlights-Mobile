import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  static Future<String> recognizeTextFromImage(String imagePath) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFilePath(imagePath);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    final rawText = recognizedText.text;

    String extractField(RegExp pattern) {
      return pattern.firstMatch(rawText)?.group(1)?.trim() ?? 'Não encontrado';
    }

    final peso = extractField(RegExp(r'ENGENHARIA\s+([\d,]+)\s*Kg', caseSensitive: false));
    final dimensoes = extractField(RegExp(r'(\d{2,4})\s*x\s*(\d{2,4})', caseSensitive: false));
    final data = extractField(RegExp(r'\b(\d{2}/\d{2}/\d{2})\b')); 
    final codigoBarras = extractField(RegExp(r'\b(\d{12,20})\b'));
    final tipoVidro = extractField(RegExp(r'(INCOLOR\s+\d+MM\s*-\s*TEMPERADO|VERDE\s+\d+MM\s*-\s*TEMPERADO)', caseSensitive: false));
    final cidade = extractField(RegExp(r'([A-ZÁ-Ú]+(?:\s+[A-ZÁ-Ú]+)*)\s+VERDE\s+\d+MM', caseSensitive: false));
    final linhaProducao = extractField(RegExp(r'\b(FX|FR|CR)\b', caseSensitive: false));
    final grupo = extractField(RegExp(r'GRUPO\s+([A-Z]+)', caseSensitive: false));
    final localUso = extractField(RegExp(r'(área gourmet item \d+)', caseSensitive: false));

    String linhaTexto;
    switch (linhaProducao.toUpperCase()) {
      case 'FX':
        linhaTexto = 'Linha de Produção: FX (Fixa)';
        break;
      case 'FR':
        linhaTexto = 'Setor de Furação: FR';
        break;
      case 'CR':
        linhaTexto = 'Corte Reto: CR';
        break;
      default:
        linhaTexto = 'Linha de Produção: Não identificada';
    }

    return '''
Informações extraídas da etiqueta:

• Grupo: $grupo
• Peso: $peso Kg
• Dimensões: $dimensoes mm
• Data: $data
• Código de Barras: $codigoBarras
• Tipo de Vidro: $tipoVidro
• Cidade: $cidade
• $linhaTexto
• Local de Uso: $localUso
''';
  }
}
