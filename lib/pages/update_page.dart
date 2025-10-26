import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_collector/data/items.dart';
import 'package:flutter_application_collector/data/item.dart';
import 'package:flutter_application_collector/pages/camera_page.dart';
import '../widgets/build_image.dart';

class UpdatePage extends StatefulWidget {
  final Items items;
  final Item item;

  const UpdatePage({
    super.key, 
    required this.items,
    required this.item
    });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  // Variáveis de estado da tela
  bool _isPurchased = false;

  bool _error = false;
  String _errorMessage = '';

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _photo = '';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.item.name;
    _priceController.text = widget.item.price.toString();
    _descriptionController.text = widget.item.description;
    _isPurchased = widget.item.purchased;
    _photo = widget.item.photo;
  }

  // Função para adicionar um novo item ao banco de dados
  void _updateItem() {
    widget.item.name = _nameController.text;
    widget.item.price = double.parse(_priceController.text);
    widget.item.description = _descriptionController.text;
    widget.item.purchased = _isPurchased;
    widget.item.photo = _photo;

    widget.items.updateItem(widget.item);
    widget.items.saveItems();
    
    Navigator.pop(context, widget.item);
  }

  void updatePhoto(String photo) { 
    _photo = photo;
  }

  void _treatment() { 
    // substituir espaços duplos por nada
    _nameController.text = _nameController.text.replaceAll('  ', '');
    if (_nameController.text.length == 1) _nameController.text = '';
    _descriptionController.text = _descriptionController.text.replaceAll('  ', '');
    if (_descriptionController.text.length == 1) _descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Colecionável'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: colors.surface,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone de imagem
            Center(
              child: IconButton(
                icon: SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5), // opcional, pra arredondar
                    child: buildImage(_photo, 80),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraPage(
                        updatePhoto: updatePhoto,
                      ),
                    ),
                  ).then((_) => setState(() {})); // atualiza a UI ao voltar
                },
              ),
            ),
            const SizedBox(height: 15),

            if (_error == true) Container(
              margin: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              padding: EdgeInsets.all(10), // espaço interno
              decoration: BoxDecoration(
                color: const Color.fromARGB(40, 255, 0, 0), // cor de fundo
                border: Border.all(width: 2), // borda
                borderRadius: BorderRadius.circular(12), // borda arredondada
              ),
              child: Text(_errorMessage, 
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ), 
            ),

            // Campo de nome
            TextField(
              cursorColor: colors.onPrimary,
              style: TextStyle(color: colors.onPrimary),
              keyboardType: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(35),
              ],
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: colors.onPrimary),
              )
            ),

            const SizedBox(height: 10),

            // Campo de preço
            if (_isPurchased == false) TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                LengthLimitingTextInputFormatter(10),
              ],
              controller: _priceController,
              cursorColor: colors.onPrimary,
              style: TextStyle(color: colors.onPrimary),
              decoration: InputDecoration(
                labelText: "Preço",
                labelStyle: TextStyle(color: colors.onPrimary),
              )
            ),

            const SizedBox(height: 20),

            // Campo de descrição
            TextField(
              cursorColor: colors.onPrimary,
              style: TextStyle(color: colors.onPrimary),
              maxLines: 6, // número máximo de linhas que o bloco pode ter
              minLines: 3, // número mínimo de linhas visíveis
              keyboardType: TextInputType.multiline,
              controller: _descriptionController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(500),
              ],
              decoration: InputDecoration(
                labelText: "Descrição",
                labelStyle: TextStyle(color: colors.onPrimary),
                border: OutlineInputBorder(), // deixa o bloco com borda
                alignLabelWithHint: true, // alinha o label ao topo do bloco
              )
            ),

            const SizedBox(height: 15),

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

            const SizedBox(height: 15),

            // Botão de salvar
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.onSurface,
                  foregroundColor: colors.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  _treatment();
                  if (_nameController.text.isEmpty) {
                    setState(() {
                      _error = true;
                      _errorMessage = 'Por favor, insira um nome.';
                    });
                    return;
                  } else if ((double.tryParse(_priceController.text) ?? 0) == 0 && _isPurchased == false) {
                    setState(() {
                      _error = true;
                      _errorMessage = 'Por favor, insira um preço.';
                    });
                  } else {
                    _updateItem();
                  }
                },
                child: const Text('Salvar',
                    style: TextStyle(
                      fontSize: 15,
                    )
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
