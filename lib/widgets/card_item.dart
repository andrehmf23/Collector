
import 'package:flutter/material.dart';

class cardItem extends StatelessWidget {
  final item;

  const cardItem(
    {
      required this.item,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(30, 30, 30, 0.5),
      child: ListTile(
        leading: Icon(Icons.image),
        title: Text(item['name']),
        subtitle: Text(item['description']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(item['purchased'] ? Icons.star : Icons.star_border),
            IconButton(icon: Icon(Icons.delete), onPressed: () => {}),
          ],
        ),
      ),
    );
  }
}