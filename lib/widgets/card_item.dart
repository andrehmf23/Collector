
import 'package:flutter/material.dart';
import 'package:flutter_application_collector/pages/register_page.dart';

class CardItem extends StatelessWidget {
  final item;

  const CardItem(
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
            IconButton(icon: Icon(item['purchased'] ? Icons.star : Icons.star_border), onPressed: () => {}),
            SizedBox(width: 5),
            IconButton(icon: Icon(Icons.delete), onPressed: () => {}),
          ],
        ),
        onTap: () => {
          Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => const RegisterPage()
            )
          )
        },
      ),
    );
  }
}