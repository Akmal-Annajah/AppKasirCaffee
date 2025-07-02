import 'package:flutter/material.dart';
import 'order_confirmation_screen.dart';

class MenuScreen extends StatefulWidget {
  final int tableNumber;

  const MenuScreen({Key? key, required this.tableNumber}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Map<String, int> order = {};
  int totalPrice = 0;

  List<Map<String, dynamic>> menus = [
    {
      'name': 'Kopi Latte',
      'price': 15000,
      'image': 'assets/images/latte.png',
      'icon': Icons.coffee,
      'color': Colors.brown.shade300,
    },
    {
      'name': 'Kopi Tubruk',
      'price': 6000,
      'image': 'assets/images/hitam.png',
      'icon': Icons.local_cafe,
      'color': Colors.brown.shade600,
    },
    {
      'name': 'V60 Pour Over',
      'price': 15000,
      'image': 'assets/images/v60.png',
      'icon': Icons.filter_vintage,
      'color': Colors.brown.shade400,
    },
  ];

  void addItem(String name, int price) {
    setState(() {
      order[name] = (order[name] ?? 0) + 1;
      totalPrice += price;
    });
  }

  void removeItem(String name, int price) {
    setState(() {
      if (order[name] != null && order[name]! > 0) {
        order[name] = order[name]! - 1;
        totalPrice -= price;
        if (order[name] == 0) {
          order.remove(name);
        }
      }
    });
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Menu - Meja ${widget.tableNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.brown.shade700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Text(
              'Pilih menu favorit Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Menu list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final item = menus[index];
                final qty = order[item['name']] ?? 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Icon/Image placeholder
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: item['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: item['color'].withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            item['icon'],
                            size: 40,
                            color: item['color'],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Menu info
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.brown.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Rp ${formatCurrency(item['price'])}',
                                  style: TextStyle(
                                    color: Colors.brown.shade700,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Quantity controls
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color:
                                      qty > 0
                                          ? Colors.brown.shade600
                                          : Colors.grey.shade400,
                                ),
                                onPressed:
                                    qty > 0
                                        ? () => removeItem(
                                          item['name'],
                                          item['price'],
                                        )
                                        : null,
                                iconSize: 28,
                              ),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  '$qty',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.brown.shade600,
                                ),
                                onPressed:
                                    () => addItem(item['name'], item['price']),
                                iconSize: 28,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom section with total and button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Order summary
                if (order.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Item: ${order.values.fold(0, (sum, qty) => sum + qty)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.brown.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.receipt_long,
                              color: Colors.brown.shade600,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Total price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Pembayaran:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Rp ${formatCurrency(totalPrice)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Continue button
                ElevatedButton(
                  onPressed:
                      order.isEmpty
                          ? null
                          : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => OrderConfirmationScreen(
                                      order: order,
                                      totalPrice: totalPrice,
                                      tableNumber: widget.tableNumber,
                                    ),
                              ),
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        order.isEmpty
                            ? Colors.grey.shade300
                            : Colors.brown.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: order.isEmpty ? 0 : 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        order.isEmpty
                            ? Icons.shopping_cart_outlined
                            : Icons.arrow_forward,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order.isEmpty
                            ? 'Pilih Menu Terlebih Dahulu'
                            : 'Lanjut ke Konfirmasi',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
