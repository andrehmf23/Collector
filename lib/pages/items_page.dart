
import 'package:flutter/material.dart';
import 'package:flutter_application_collector/widgets/card_item.dart';
import 'package:flutter_application_collector/data/data.dart';

class ItemsPage extends StatefulWidget {
  final int filter;

  const ItemsPage(
    {
      super.key,
      required this.filter
    }
  );

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  String _search = '';

  List<Map<String, dynamic>> _filteredItems = [];

  void _updateFilteredItems() {
    _filteredItems = data
      .where((item) => item['name']
      .toLowerCase()
      .contains(_search.toLowerCase()))
      .toList();
  }

  @override
  void initState() {
    super.initState();
    _updateFilteredItems();
  }

  @override
  void didUpdateWidget(covariant ItemsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter) {
      // Atualiza apenas a lista filtrada
      switch (widget.filter) {
        case 0:
          _filteredItems = data;
          break;
        case 1:
          _filteredItems = data.where((item) => !item['purchased']).toList();
          break;
        case 2:
          _filteredItems = data.where((item) => item['purchased']).toList();
          break;
      }
      setState(() {}); // só atualiza o necessário
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0), 
          child: TextField(
            cursorColor: colors.onPrimary,
            style: TextStyle(color: colors.onPrimary),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: colors.onPrimary),
              labelText: 'Pesquisar',
            ),
            onChanged: (value) => setState(() {
              _search = value;
              _updateFilteredItems();
            }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return CardItem(item: _filteredItems[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
