import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const MenuCard({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: Image.asset(image, width: 50),
        title: Text(name),
        subtitle: Text('Rp $price'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onRemove, icon: const Icon(Icons.remove)),
            Text('$quantity'),
            IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
