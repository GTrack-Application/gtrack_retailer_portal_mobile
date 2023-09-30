import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/common/themes/themes.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/price_checker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gtrack Retailer Port',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme(),
      home: const PriceCheckerScreen(),
    );
  }
}
