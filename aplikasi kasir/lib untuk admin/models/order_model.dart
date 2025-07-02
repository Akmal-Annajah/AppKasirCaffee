import 'menu_model.dart';

class OrderModel {
  final String id;
  final String tableNumber;
  String status; // Pending, Diproses, Selesai
  final List<OrderItem> items;
  final int total;

  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.status,
    required this.items,
    required this.total,
  });
}

class OrderItem {
  final MenuModel menu;
  final int quantity;

  OrderItem({
    required this.menu,
    required this.quantity,
  });
}
