import 'package:flutter/material.dart';
import 'package:scanocr/screens/home_screen.dart';
import 'package:scanocr/supabase/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await SupabaseManager.init();
  } catch (e, stackTrace) {
    debugPrint('Erro ao inicializar Supabase: $e');
    debugPrintStack(stackTrace: stackTrace);
  }

  runApp(const ScanOCRApp());
}

class ScanOCRApp extends StatelessWidget {
  const ScanOCRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScanOCR',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
