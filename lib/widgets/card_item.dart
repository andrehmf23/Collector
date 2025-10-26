import 'package:flutter/material.dart';
import 'package:flutter_application_collector/data/item.dart';
import 'package:flutter_application_collector/pages/update_page.dart';
import 'package:flutter_application_collector/pages/camera_page.dart';
import '../data/items.dart';
import 'build_image.dart';


class CardItem extends StatefulWidget {
  final Item item;
  final Items items;
  final Function deleteItem;

  const CardItem(
    {
      super.key,
      required this.item,
      required this.items,
      required this.deleteItem
    }
  );

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {

  void updatePhoto(String photo) {
    setState(() {
      widget.item.photo = photo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(30, 30, 30, 0.5),
      child: ListTile(
        leading: IconButton(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5), // opcional, pra arredondar
              child: buildImage(widget.item.photo, 30),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraPage(
                  updatePhoto: updatePhoto
                ),
              ),
            ).then((_) => setState(() {
              widget.items.updateItem(widget.item);
            })); // atualiza a UI ao voltar
          },
        ),
        title: Text(widget.item.name),
        subtitle: Text(widget.item.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if(!widget.item.purchased) IconButton(
              icon: Icon(Icons.local_grocery_store), 
              onPressed: () {
                widget.item.purchased = true;
                widget.items.updateItem(widget.item);
                setState(() {});
              }
            ),
            SizedBox(width: 5),
            IconButton(
              icon: Icon(Icons.delete), 
              onPressed: () {
              widget.deleteItem(widget.item);
            }),
          ],
        ),
        onTap: () async {
          final updatedItem = await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => UpdatePage(items: widget.items, item: widget.item),
            ),
          );

          if (updatedItem != null) {
            setState(() {
              widget.item.name = updatedItem.name;
              widget.item.description = updatedItem.description;
              widget.item.price = updatedItem.price;
              widget.item.purchased = updatedItem.purchased;
            });
          }
        }
      ),
    );
  }
}