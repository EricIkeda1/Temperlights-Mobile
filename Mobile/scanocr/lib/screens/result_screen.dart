import 'package:flutter/material.dart';
import 'package:scanocr/services/ocr_service.dart';

class ResultScreen extends StatefulWidget {
  final String code;

  const ResultScreen({super.key, required this.code});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String recognizedText = 'Reconhecendo...';

  @override
  void initState() {
    super.initState();
    recognizeText();
  }

  Future<void> recognizeText() async {
    String text = await OCRService.recognizeTextFromImage(widget.code);
    setState(() {
      recognizedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Resultado OCR'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),

            Text(
              'Código Escaneado',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.code,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),
            Text(
              'Enviando para o Banco',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                recognizedText,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Courier',
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'Voltar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
