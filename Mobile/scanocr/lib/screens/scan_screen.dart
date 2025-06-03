import 'package:flutter/material.dart';
import 'package:scanocr/services/barcode_scanner.dart';
import 'package:scanocr/screens/result_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Future<void> scanBarcode() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Row(
          children: const [
            CircularProgressIndicator(color: Color(0xFFFF6F00)), 
            SizedBox(width: 20),
            Text(
              'Iniciando o scanner...',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.of(context).pop();

    String barcode = await BarcodeScannerService.scanBarcode();

    if (!mounted) return;

    if (barcode != 'Cancelado' && barcode.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(code: barcode)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código de Barras'),
        centerTitle: true,
        backgroundColor: Color(0xFFFF6F00), 
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFE0B2),
              Color(0xFFFFB74D),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 120, color: Color(0xFFFF6F00)),
            const SizedBox(height: 20),
            const Text(
              'Aproxime o código de barras ou QR Code da câmera para escanear.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: scanBarcode,
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text(
                  'Iniciar Scanner',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6F00),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
