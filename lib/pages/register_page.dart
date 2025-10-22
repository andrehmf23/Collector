import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Variáveis de estado da tela
  String _name = '';
  double _price = 0.0;
  String _description = '';
  bool _isPurchased = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Registro'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: colors.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone de imagem
            Center(
              child: IconButton(
                icon: const Icon(Icons.image, size: 48),
                onPressed: () {
                  // abrir seletor de imagem futuramente
                },
              ),
            ),
            const SizedBox(height: 16),

            // Campo de nome
            TextField(
              cursorColor: colors.onPrimary,
              style: TextStyle(color: colors.onPrimary),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                LengthLimitingTextInputFormatter(20),
              ],
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: colors.onPrimary),
              ),
              onChanged: (val) => _name = val,
            ),

            const SizedBox(height: 10),

            // Campo de preço
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                LengthLimitingTextInputFormatter(10),
              ],
              cursorColor: colors.onPrimary,
              style: TextStyle(color: colors.onPrimary),
              decoration: InputDecoration(
                labelText: "Preço",
                labelStyle: TextStyle(color: colors.onPrimary),
              ),
              onChanged: (val) => _price = double.tryParse(val) ?? 0.0,
            ),

            const SizedBox(height: 20),

            // Campo de descrição
            TextField(
              cursorColor: colors.onPrimary,
              style: TextStyle(color: colors.onPrimary),
              maxLines: 5, // número máximo de linhas que o bloco pode ter
              minLines: 3, // número mínimo de linhas visíveis
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Descrição",
                labelStyle: TextStyle(color: colors.onPrimary),
                border: OutlineInputBorder(), // deixa o bloco com borda
                alignLabelWithHint: true, // alinha o label ao topo do bloco
              ),
              onChanged: (val) => _description = val,
            ),

            const SizedBox(height: 10),

            // Checkbox
            Row(
              children: [
                const Text("Comprado: "),
                Checkbox(
                  value: _isPurchased,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPurchased = value ?? false;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Botão de salvar
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.onSurface,
                  foregroundColor: colors.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Aqui você tem os valores de _name, _price, _description e _isPurchased
                  // Pode salvar no banco
                  print('Nome: $_name');
                  print('Preço: $_price');
                  print('Descrição: $_description');
                  print('Comprado: $_isPurchased');

                  Navigator.pop(context); // volta à tela anterior
                },
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
