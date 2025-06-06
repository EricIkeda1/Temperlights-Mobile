import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MachineSwapScreen extends StatefulWidget {
  final int code;
  const MachineSwapScreen({super.key, required this.code});

  @override
  State<MachineSwapScreen> createState() => _MachineSwapScreenState();
}

class _MachineSwapScreenState extends State<MachineSwapScreen> {
  Map<String, dynamic>? supabaseData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final supabase = Supabase.instance.client;
    try {
      final data = await supabase
          .from('testes2')
          .select('id, producao, IDMaquina')
          .eq('id', widget.code)
          .maybeSingle();

      setState(() {
        supabaseData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar dados: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text('Troca de Máquina'),
        backgroundColor: const Color(0xFFF37021),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : supabaseData == null
                ? const Text('Nenhum dado disponível.')
                : DataCard(data: supabaseData!),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const DataCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final dynamic producaoRaw = data['producao'] ?? [];
    final List<String> producaoList = [];

    if (producaoRaw is List) {
      for (var item in producaoRaw) {
        producaoList.add(item.toString());
      }
    }

    final producaoString = producaoList.toString();

    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.precision_manufacturing, size: 80, color: Color(0xFFF37021)),
          const SizedBox(height: 20),
          const Text(
            'Dados da Máquina',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          ),
          const SizedBox(height: 20),
          Text(
            'Produção:\n\n$producaoString\n\nID Máquina: ${data['IDMaquina']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF37021),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Voltar', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
