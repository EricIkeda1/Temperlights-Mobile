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
    buscarDadosDoCodigo();
  }

  Future<void> buscarDadosDoCodigo() async {
    final supabase = Supabase.instance.client;

    print('🔍 Buscando dados para o código: ${widget.code}');

    try {
      final response = await supabase
          .from('testes2')
          .select('id, producao, IDMaquina')
          .eq('id', widget.code)
          .maybeSingle();

      print('Resposta do Supabase: $response');

      if (response != null) {
        setState(() {
          supabaseData = response;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum dado encontrado para este código.')),
        );
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
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
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.precision_manufacturing,
                            size: 80,
                            color: Color(0xFFF37021),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Dados da Máquina',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 20),
                          InfoRow(label: 'ID', value: '${supabaseData!['id']}'),
                          InfoRow(label: 'Produção', value: '${supabaseData!['producao']}'),
                          InfoRow(label: 'ID da Máquina', value: '${supabaseData!['IDMaquina']}'),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF37021),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Voltar',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF555555)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(color: Color(0xFF222222))),
          ),
        ],
      ),
    );
  }
}
