import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage(
    {
      Key? key,
      int? id = -1
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Item')
      ),
      body: Center(child: Text('Item')),
    );
  }
}