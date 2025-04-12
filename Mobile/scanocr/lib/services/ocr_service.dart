import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:string_similarity/string_similarity.dart';

class OCRService {
  static Future<String> recognizeTextFromImage(String imagePath) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFilePath(imagePath);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    return recognizedText.text.trim().isEmpty
        ? 'Nenhum texto encontrado'
        : recognizedText.text.trim();
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
      final similarity = StringSimilarity.compareTwoStrings(scannedText, refText);

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
}
