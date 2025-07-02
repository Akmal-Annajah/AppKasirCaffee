import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String tableNumber;
  final String status;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.tableNumber,
    required this.status,
    required this.onTap,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Diproses':
        return Colors.blue;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(),
          child: const Icon(Icons.table_bar, color: Colors.white),
        ),
        title: Text('Meja $tableNumber'),
        subtitle: Text('Status: $status'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
