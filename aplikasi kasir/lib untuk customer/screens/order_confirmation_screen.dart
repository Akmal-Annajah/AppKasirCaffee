import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'payment_method_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final Map<String, int> order;
  final int totalPrice;
  final int tableNumber;

  const OrderConfirmationScreen({
    Key? key,
    required this.order,
    required this.totalPrice,
    required this.tableNumber,
  }) : super(key: key);

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  late Map<String, int> currentOrder;

  // Menu data with exact prices - MUST match MenuScreen
  final Map<String, Map<String, dynamic>> menuData = {
    'Kopi Latte': {
      'price': 15000,
      'icon': Icons.coffee,
      'color': Colors.brown.shade300,
    },
    'Kopi Tubruk': {
      'price': 6000,
      'icon': Icons.local_cafe,
      'color': Colors.brown.shade600,
    },
    'V60 Pour Over': {
      'price': 15000,
      'icon': Icons.filter_vintage,
      'color': Colors.brown.shade400,
    },
    // Support for old menu name
    'v60': {
      'price': 15000,
      'icon': Icons.filter_vintage,
      'color': Colors.brown.shade400,
    },
  };

  @override
  void initState() {
    super.initState();
    currentOrder = Map.from(widget.order);
  }

  int getItemPrice(String itemName) {
    return menuData[itemName]?['price'] ?? 0;
  }

  int calculateTotal() {
    int total = 0;
    currentOrder.forEach((itemName, quantity) {
      total += quantity * getItemPrice(itemName);
    });
    return total;
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void removeItem(String itemName) {
    setState(() {
      currentOrder.remove(itemName);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName dihapus dari pesanan'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void updateQuantity(String itemName, int newQty) {
    setState(() {
      if (newQty <= 0) {
        currentOrder.remove(itemName);
      } else {
        currentOrder[itemName] = newQty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = calculateTotal();
    final totalItems = currentOrder.values.fold(0, (a, b) => a + b);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Pesanan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            child: Column(
              children: [
                Text(
                  'Meja ${widget.tableNumber}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalItems item dipilih',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Order items list
          Expanded(
            child:
                currentOrder.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Pesanan kosong',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Silakan tambah menu dari halaman sebelumnya',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: currentOrder.length,
                      itemBuilder: (context, index) {
                        final entry = currentOrder.entries.elementAt(index);
                        final itemName = entry.key;
                        final quantity = entry.value;
                        final itemPrice = getItemPrice(itemName);
                        final subtotal = quantity * itemPrice;
                        final menuInfo = menuData[itemName];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Slidable(
                            key: ValueKey(itemName),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => removeItem(itemName),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Hapus',
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Icon
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: (menuInfo?['color'] ??
                                              Colors.brown)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      menuInfo?['icon'] ?? Icons.coffee,
                                      color: menuInfo?['color'] ?? Colors.brown,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Item details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          itemName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Rp ${formatCurrency(itemPrice)} per item',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Quantity controls
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.brown.shade600,
                                            size: 20,
                                          ),
                                          onPressed:
                                              () => updateQuantity(
                                                itemName,
                                                quantity - 1,
                                              ),
                                          constraints: const BoxConstraints(
                                            minWidth: 32,
                                            minHeight: 32,
                                          ),
                                        ),
                                        Container(
                                          width: 30,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '$quantity',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.brown.shade600,
                                            size: 20,
                                          ),
                                          onPressed:
                                              () => updateQuantity(
                                                itemName,
                                                quantity + 1,
                                              ),
                                          constraints: const BoxConstraints(
                                            minWidth: 32,
                                            minHeight: 32,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // Subtotal
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Rp ${formatCurrency(subtotal)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),

          // Bottom section with total and buttons
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
                if (currentOrder.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Item: $totalItems',
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
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Rp ${formatCurrency(total)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.brown.shade700),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_shopping_cart,
                              color: Colors.brown.shade700,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Tambah Lagi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            currentOrder.isEmpty
                                ? null
                                : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => PaymentMethodScreen(
                                            tableNumber: widget.tableNumber,
                                            totalPrice:
                                                total, // Use calculated total
                                          ),
                                    ),
                                  );
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              currentOrder.isEmpty
                                  ? Colors.grey.shade300
                                  : Colors.brown.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: currentOrder.isEmpty ? 0 : 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              currentOrder.isEmpty
                                  ? Icons.shopping_cart_outlined
                                  : Icons.payment,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              currentOrder.isEmpty
                                  ? 'Pilih Menu Dulu'
                                  : 'Lanjut Bayar',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
