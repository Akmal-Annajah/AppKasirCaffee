List<Map<String, dynamic>> dummyMenuList = [
  {
    'name': 'Cappuccino',
    'price': 25000,
    'category': 'Coffee',
    'image': 'assets/images/sample_coffee.png',
  },
  {
    'name': 'Sandwich',
    'price': 30000,
    'category': 'Food',
    'image': 'assets/images/sample_food.png',
  },
];

List<Map<String, dynamic>> dummyTransactionHistory = [
  {
    'table': '1',
    'total': 75000,
    'date': '2024-06-28',
  },
  {
    'table': '3',
    'total': 50000,
    'date': '2024-06-27',
  },
];
List<Map<String, dynamic>> dummyOrderList = [
  {
    'id': 'ORD001',
    'table': '2',
    'status': 'Pending',
    'items': [
      {'name': 'Cappuccino', 'qty': 2, 'price': 50000},
      {'name': 'Sandwich', 'qty': 1, 'price': 30000},
    ],
    'total': 80000,
  },
  {
    'id': 'ORD002',
    'table': '5',
    'status': 'Diproses',
    'items': [
      {'name': 'Americano', 'qty': 1, 'price': 25000},
    ],
    'total': 25000,
  },
];
