
import 'package:flutter/material.dart';
import 'package:flutter_application_collector/widgets/card_item.dart';

class AllPage extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const AllPage(
    {
      required this.items,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return cardItem(item: items[index]);
      },
    );
  }
}