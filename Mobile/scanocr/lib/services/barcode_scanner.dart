import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScannerService {
  static Future<String> scanBarcode() async {
    try {
      String scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancelar',
        true,
        ScanMode.BARCODE,
      );

      if (scanResult == '-1') return 'Cancelado';

      if (scanResult.startsWith(']C1')) {
        scanResult = scanResult.substring(3);
      }

      scanResult = scanResult.trim();

      if (!scanResult.startsWith('0') && scanResult.length < 18) {
        scanResult = scanResult.padLeft(18, '0');
      }

      return scanResult;
    } catch (e) {
      return 'Erro ao escanear: $e';
    }
  }
}
