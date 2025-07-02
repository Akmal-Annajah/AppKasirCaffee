import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CoffeeShopAdminApp());
}

class CoffeeShopAdminApp extends StatelessWidget {
  const CoffeeShopAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop Admin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
