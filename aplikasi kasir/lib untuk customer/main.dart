import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'screens/choose_table_screen.dart';

void main() {
  runApp(const CoffeeCustomerApp());
}

class CoffeeCustomerApp extends StatelessWidget {
  const CoffeeCustomerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop Customer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ChooseTableScreen(),
    );
  }
}
