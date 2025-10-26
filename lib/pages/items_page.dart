
import 'package:flutter/material.dart';
import 'package:flutter_application_collector/widgets/card_item.dart';
import '../data/items.dart';
import '../data/item.dart';

class ItemsPage extends StatefulWidget {
  final int filter;
  final Items items;

  const ItemsPage(
    {
      super.key,
      required this.filter,
      required this.items
    }
  );

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  String _search = '';
  List<Item> _filteredItems = [];

  void _updateFilteredItems() {
    _filteredItems = widget.items.items
        .where((item) => item.name.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    switch (widget.filter) {
      case 1:
        _filteredItems = _filteredItems.where((item) => !item.purchased).toList();
        break;
      case 2:
        _filteredItems = _filteredItems.where((item) => item.purchased).toList();
        break;
    }
  }

  void _deleteItem(Item item) {
    widget.items.removeItem(item);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    _updateFilteredItems();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            cursorColor: colors.onPrimary,
            style: TextStyle(color: colors.onPrimary),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: colors.onPrimary),
              labelText: 'Pesquisar',
            ),
            onChanged: (value) => setState(() => _search = value),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80, left: 5, right: 5),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              return CardItem(item: _filteredItems[index], items: widget.items, deleteItem: _deleteItem);
            },
          ),
        ),
      ],
    );
  }
}
