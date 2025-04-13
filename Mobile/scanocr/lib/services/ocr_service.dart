import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  static Future<Map<String, String>> recognizeStructuredData(String imagePath) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFilePath(imagePath);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    final text = recognizedText.text.toUpperCase();

    return {
      'empresa': _extract(text, ['EMPRESA', 'TEMPERLÂNDIA', 'TEMPERLANDIA', 'TEMPERLÂMPIA']),
      'grupo': _extract(text, ['GRUPO']),
      'secao': _extract(text, ['SEÇÃO', 'SECAO']),
      'peso': _extract(text, ['PESO'], suffix: 'KG'),
      'dimensoes': _extract(text, ['DIMENSÕES', 'DIMENSOES', 'LARGURA X ALTURA', 'X']),
      'ordem': _extract(text, ['OF', 'ORDEM DE FABRICAÇÃO']),
      'data': _extract(text, ['DATA DE PRODUÇÃO']),
      'codigo': _extract(text, ['CÓDIGO ITEM', 'CÓDIGO', 'CODIGO']),
      'chapa_plano': _extract(text, ['CHAPA', 'PLANO']),
      'localidade': _extract(text, ['LOCALIDADE', 'CIDADE']),
      'material': _extract(text, ['MATERIAL']),
    };
  }

  static String _extract(String fullText, List<String> keys, {String? suffix}) {
    for (final key in keys) {
      final pattern = RegExp('$key[:\\s\\-]*([\\w\\s,.+×xX\\-\\/]+${suffix ?? ""})');
      final match = pattern.firstMatch(fullText);
      if (match != null && match.groupCount >= 1) {
        return match.group(1)!.trim();
      }
    }
    return '';
  }

  static Future<Map<String, dynamic>> recognizeAndCompare(
    String scannedImagePath,
    String referenceFolderPath,
  ) async {
    final scannedText = await recognizeTextFromImage(scannedImagePath);

    final referenceDir = Directory(referenceFolderPath);
    final referenceFiles = referenceDir
        .listSync()
        .where((f) => f is File && f.path.toLowerCase().endsWith('.jpg'));

    String bestMatchFile = '';
    double bestSimilarity = 0.0;

    for (var file in referenceFiles) {
      final refText = await recognizeTextFromImage(file.path);
      final similarity = _compareStrings(scannedText, refText);

      if (similarity > bestSimilarity) {
        bestSimilarity = similarity;
        bestMatchFile = file.path;
      }
    }

    return {
      'textoEscaneado': scannedText,
      'melhorCorrespondencia': bestMatchFile,
      'similaridade': bestSimilarity,
    };
  }

  static Future<String> recognizeTextFromImage(String imagePath) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFilePath(imagePath);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    return recognizedText.text.trim().isEmpty
        ? 'Nenhum texto encontrado'
        : recognizedText.text.trim();
  }

  static double _compareStrings(String a, String b) {
    final aWords = a.toLowerCase().split(RegExp(r'\s+'));
    final bWords = b.toLowerCase().split(RegExp(r'\s+'));
    final totalWords = aWords.length;

    if (totalWords == 0) return 0.0;

    int matched = 0;
    for (var word in aWords) {
      if (bWords.contains(word)) matched++;
    }

    return matched / totalWords;
  }
}
